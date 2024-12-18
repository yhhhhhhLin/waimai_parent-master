package com.waimai.service.impl;

import com.waimai.constant.StatusConstant;
import com.waimai.entity.Orders;
import com.waimai.mapper.DishMapper;
import com.waimai.mapper.OrderMapper;
import com.waimai.mapper.SetmealMapper;
import com.waimai.mapper.UserMapper;
import com.waimai.service.WorkSpaceService;
import com.waimai.vo.BusinessDataVO;
import com.waimai.vo.DishOverViewVO;
import com.waimai.vo.OrderOverViewVO;
import com.waimai.vo.SetmealOverViewVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class WorkSpaceServiceImpl implements WorkSpaceService {
    @Autowired
    private OrderMapper orderMapper;     //订单DAO

    @Autowired
    private DishMapper dishMapper;       //菜品DAO

    @Autowired
    private SetmealMapper setmealMapper; //套餐DAO

    @Autowired
    private UserMapper userMapper;       //用户DAO


    /**
     * 查询指定时间段内的营业数据（营业额、有效订单、订单完成率、平均客单价、新增用户数）
     *
     * @param beginTime 今天开始时间
     * @param endTime   今天结束时间
     * @return 今日营业数据
     */
    public BusinessDataVO getBusinessData(LocalDateTime beginTime, LocalDateTime endTime) {
        Map<String, Object> map = new HashMap<>();
        map.put("beginTime", beginTime);
        map.put("endTime", endTime);
        //获取今天总订单数
        Integer totalOrderCount = orderMapper.countByMap(map);

        //status设置为 5已完成
        map.put("status", Orders.COMPLETED);

        //获取今天总营业额
        Double turnover = orderMapper.sumByMap(map);
        turnover = turnover != null ? turnover : 0.0;

        //有效订单数
        Integer validOrderCount = orderMapper.countByMap(map);

        //订单完成率 有效订单数 / 总订单数
        Double orderCompletionRate = 0.0;

        //平均客单价 营业额 / 有效订单数
        Double unitPrice = 0.0;

        //判断总订单数和有效订单数是否为大于0
        if (totalOrderCount > 0 && validOrderCount > 0) {
            //订单完成率 有效订单数 / 总订单数
            orderCompletionRate = validOrderCount.doubleValue() / totalOrderCount;

            //平均客单价 营业额 / 有效订单数
            unitPrice = turnover / validOrderCount;
        }

        //新增用户数 select count(id) from user where create_time > ? and create_time < ?
        LocalDate localDate = endTime.toLocalDate();
        map.put("endTime",localDate);
        Integer newUsers = userMapper.countByMap(map);

        return BusinessDataVO.builder()
                .turnover(turnover)                        //营业额
                .validOrderCount(validOrderCount)          //有效订单数
                .orderCompletionRate(orderCompletionRate)  //订单完成率
                .unitPrice(unitPrice)                      //平均客单价
                .newUsers(newUsers)                        //新增用户数
                .build();
    }

    /**
     * 查询订单管理数据
     *
     * @return
     */
    public OrderOverViewVO getOrderOverView() {
        Map map = new HashMap();
        map.put("beginTime", LocalDateTime.now().with(LocalTime.MIN));
        map.put("status", Orders.TO_BE_CONFIRMED);

        //待接单
        Integer waitingOrders = orderMapper.countByMap(map);

        //待派送
        map.put("status", Orders.CONFIRMED);
        Integer deliveredOrders = orderMapper.countByMap(map);

        //已完成
        map.put("status", Orders.COMPLETED);
        Integer completedOrders = orderMapper.countByMap(map);

        //已取消
        map.put("status", Orders.CANCELLED);
        Integer cancelledOrders = orderMapper.countByMap(map);

        //全部订单
        map.put("status", null);
        Integer allOrders = orderMapper.countByMap(map);

        return OrderOverViewVO.builder()
                .waitingOrders(waitingOrders)
                .deliveredOrders(deliveredOrders)
                .completedOrders(completedOrders)
                .cancelledOrders(cancelledOrders)
                .allOrders(allOrders)
                .build();
    }

    /**
     * 查询菜品总览
     *
     * @return
     */
    public DishOverViewVO getDishOverView() {
        Map map = new HashMap();
        map.put("status", StatusConstant.ENABLE);
        Integer sold = dishMapper.countByMap(map);

        map.put("status", StatusConstant.DISABLE);
        Integer discontinued = dishMapper.countByMap(map);

        return DishOverViewVO.builder()
                .sold(sold)
                .discontinued(discontinued)
                .build();
    }

    /**
     * 查询套餐总览
     *
     * @return
     */
    public SetmealOverViewVO getSetmealOverView() {
        Map map = new HashMap();
        map.put("status", StatusConstant.ENABLE);
        Integer sold = setmealMapper.countByMap(map);

        map.put("status", StatusConstant.DISABLE);
        Integer discontinued = setmealMapper.countByMap(map);

        return SetmealOverViewVO.builder()
                .sold(sold)
                .discontinued(discontinued)
                .build();
    }
}
