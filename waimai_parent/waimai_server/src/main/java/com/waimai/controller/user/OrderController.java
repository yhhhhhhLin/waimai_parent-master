package com.waimai.controller.user;

import com.waimai.dto.OrdersPaymentDTO;
import com.waimai.dto.OrdersSubmitDTO;
import com.waimai.result.PageResult;
import com.waimai.result.R;
import com.waimai.service.OrderService;
import com.waimai.vo.OrderPaymentVO;
import com.waimai.vo.OrderSubmitVO;
import com.waimai.vo.OrderVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 订单
 */
@RestController("userOrderController")
@RequestMapping("/user/order")
@Slf4j
@Api(tags = "C端-订单接口")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 用户下单
     *
     * @param ordersSubmitDTO 订单购买信息
     * @return  订单信息（订单id，金额，订单号，下单时间）
     */
    @PostMapping("/submit")
    @ApiOperation("用户下单")
    public R<OrderSubmitVO> submit(@RequestBody OrdersSubmitDTO ordersSubmitDTO) {
        log.info("用户下单:{}", ordersSubmitDTO);
        OrderSubmitVO orderSubmitVO = orderService.submitOrder(ordersSubmitDTO);
        return R.success(orderSubmitVO);
    }

//    private void payFirst(OrderSubmitVO orderSubmitVO) {
//        OrdersPaymentDTO ordersPaymentDTO = new OrdersPaymentDTO();
//        ordersPaymentDTO.setOrderNumber(orderSubmitVO.getOrderNumber());
////        TODO 支付宝
//        ordersPaymentDTO.setPayMethod(1);
//        payment(ordersPaymentDTO);
//
//    }

    /**
     * 订单支付
     *
     * @param ordersPaymentDTO
     * @return
     */
    @PutMapping("/payment")
    @ApiOperation("订单支付")
    public R<OrderPaymentVO> payment(@RequestBody OrdersPaymentDTO ordersPaymentDTO) {
        log.info("订单支付：{}",ordersPaymentDTO);
        OrderPaymentVO orderPaymentVO = orderService.payment(ordersPaymentDTO);
        return R.success(orderPaymentVO);
    }

    /**
     * 历史订单查询
     *
     * @param page
     * @param pageSize
     * @param status 订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款
     * @return
     */
    @GetMapping("/historyOrders")
    @ApiOperation("历史订单查询")
    public R<PageResult> page(int page, int pageSize, Integer status) {
        PageResult pageResult = orderService.pageQuery4User(page, pageSize, status);
        return R.success(pageResult);
    }

    /**
     * 查询订单详情
     *
     * @param id
     * @return
     */
    @GetMapping("/orderDetail/{id}")
    @ApiOperation("查询订单详情")
    public R<OrderVO> details(@PathVariable("id") Long id) {
        OrderVO orderVO = orderService.details(id);
        return R.success(orderVO);
    }

    /**
     * 催单
     *
     * @param id
     * @return
     */
    @GetMapping("/reminder/{id}")
    @ApiOperation("催单")
    public R reminder(@PathVariable("id") Long id) {
        orderService.reminder(id);
        return R.success();
    }

    /**
     * 用户取消订单
     *
     * @return
     */
    @PutMapping("/cancel/{id}")
    @ApiOperation("取消订单")
    public R cancel(@PathVariable("id") Long id) {
        orderService.userCancelById(id);
        return R.success();
    }

    /**
     * 再来一单
     *
     * @param id
     * @return
     */
    @PostMapping("/repetition/{id}")
    @ApiOperation("再来一单")
    public R repetition(@PathVariable Long id) {
        orderService.repetition(id);
        return R.success();
    }
}
