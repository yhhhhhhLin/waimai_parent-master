package com.waimai.service.impl;

import com.waimai.constant.MessageConstant;
import com.waimai.dto.UserLoginDTO;
import com.waimai.entity.User;
import com.waimai.exception.LoginFailedException;
import com.waimai.mapper.UserMapper;
import com.waimai.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
@Slf4j
public class UserServiceImpl implements UserService {
    public static final String LOGIN_URL = "https://api.weixin.qq.com/sns/jscode2session";

    @Autowired
    private UserMapper userMapper;

    @Value("${waimai.wechat.appid}")
    private String appid;

    @Value("${waimai.wechat.secret}")
    private String secret;


    private String getOpenid(String code) {
//        Map<String, String> param = new HashMap<>();
//        param.put("appid",appid);
//        param.put("secret",secret);
//        param.put("js_code",code);
//        param.put("grant_type","authorization_code");
//
//        //数据格式:{openid:xxxx,session_key:xxxx}
//        String res = HttpClientUtil.doGet(LOGIN_URL, param);
//        JSONObject jsonObject = JSON.parseObject(res);
//        String openid = jsonObject.getString("openid");
//        log.info("查询到微信用户的openid:{}", openid);
//
//        if (openid == null){
//            throw new LoginFailedException(MessageConstant.LOGIN_FAILED);
//        }
//
//        暂时不能微信登陆，mock数据
        if("1234".equals(code)){
            return "example_openid";
        }else{
            throw new LoginFailedException(MessageConstant.LOGIN_FAILED);
        }
    }

    /**
     * 微信登陆
     *
     * @param userLoginDTO 微信授权码
     * @return 用户信息
     */
    public User wxLogin(UserLoginDTO userLoginDTO) {
        String code = userLoginDTO.getCode();

        //获取微信用户的openid
        String openid = getOpenid(code);

        if (openid == null) {
            throw new LoginFailedException(MessageConstant.LOGIN_FAILED);
        }

        //根据openid查询用户
        User user = userMapper.getByOpenid(openid);
        if (user == null) {
            //新用户自动注册
            user = new User();
            user.setOpenid(openid);
            user.setCreateTime(LocalDate.now());
            userMapper.insert(user);
        }
        return user;
    }

}
