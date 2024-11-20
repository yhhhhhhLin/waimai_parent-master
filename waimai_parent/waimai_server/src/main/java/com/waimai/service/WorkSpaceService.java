package com.waimai.service;

import com.waimai.vo.BusinessDataVO;
import com.waimai.vo.DishOverViewVO;
import com.waimai.vo.OrderOverViewVO;
import com.waimai.vo.SetmealOverViewVO;

import java.time.LocalDateTime;

public interface WorkSpaceService {

    //查询今天的营业额
    BusinessDataVO getBusinessData(LocalDateTime beginTime, LocalDateTime endTime);

    /**
     * 查询订单管理数据
     * @return
     */
    OrderOverViewVO getOrderOverView();

    /**
     * 查询菜品总览
     * @return
     */
    DishOverViewVO getDishOverView();

    /**
     * 查询套餐总览
     * @return
     */
    SetmealOverViewVO getSetmealOverView();
}
