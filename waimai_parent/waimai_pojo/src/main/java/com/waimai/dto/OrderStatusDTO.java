package com.waimai.dto;

import lombok.Data;

/**
 * @author linzz
 */
@Data
public class OrderStatusDTO {
    private Long id;
    /**
     * 更新后状态
     */
    private Integer status;
    private String value;
}
