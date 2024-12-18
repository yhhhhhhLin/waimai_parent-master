package com.waimai.service;

import com.waimai.dto.EmployeeDTO;
import com.waimai.dto.EmployeeLoginDTO;
import com.waimai.dto.EmployeePageQueryDTO;
import com.waimai.dto.PasswordEditDTO;
import com.waimai.entity.Employee;
import com.waimai.result.PageResult;

/**
 * 员工操作
 */
public interface EmployeeService {
    //员工登录
    Employee login(EmployeeLoginDTO employeeLoginDTO);

    //添加员工
    void save(EmployeeDTO employeeDTO);

    //分页查询员工
   PageResult PageQuery(EmployeePageQueryDTO employeePageQueryDTO);

    //账号的启用和禁用
    void startOrStop(Integer status, Long id);

    //根据id查询员工
    Employee getById(Long id);

    //编辑员工信息
    void update(EmployeeDTO employeeDTO);

    //员工修改密码
    void editPassword(PasswordEditDTO passwordEditDTO);
}
