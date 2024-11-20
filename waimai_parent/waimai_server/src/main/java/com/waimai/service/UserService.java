package com.waimai.service;

import com.waimai.dto.UserLoginDTO;
import com.waimai.entity.User;

public interface UserService {

    //微信登录
    User wxLogin(UserLoginDTO userLoginDTO);
}
