CREATE DATABASE IF NOT EXISTS waimai;
use waimai;
create table user
(
    id          bigint auto_increment comment '主键'
        primary key,
    openid      varchar(45) null comment '微信用户唯一标识',
    name        varchar(50) null comment '姓名',
    phone       varchar(100) null comment '手机号',
    sex         varchar(2) null comment '性别',
    id_number   varchar(18) null comment '身份证号',
    avatar      varchar(500) null comment '头像',
    create_time date null
) comment '用户信息' collate = utf8mb3_bin;


create table shopping_cart
(
    id          bigint auto_increment comment '主键'
        primary key,
    name        varchar(50) null comment '名称',
    image       varchar(100) null comment '图片',
    user_id     bigint         not null comment '主键',
    dish_id     bigint null comment '菜品id',
    setmeal_id  bigint null comment '套餐id',
    dish_flavor varchar(50) null comment '口味',
    number      int default 1  not null comment '数量',
    amount      decimal(10, 2) not null comment '金额',
    create_time datetime null comment '创建时间'
) comment '购物车' collate = utf8mb3_bin;


create table address_book
(
    id            bigint auto_increment comment '主键'
        primary key,
    user_id       bigint      not null comment '用户id',
    consignee     varchar(50) null comment '收货人',
    sex           tinyint null comment '性别 0 女 1 男',
    phone         varchar(11) not null comment '手机号',
    province_code varchar(12) charset utf8mb4  null comment '省级区划编号',
    province_name varchar(32) charset utf8mb4  null comment '省级名称',
    city_code     varchar(12) charset utf8mb4  null comment '市级区划编号',
    city_name     varchar(32) charset utf8mb4  null comment '市级名称',
    district_code varchar(12) charset utf8mb4  null comment '区级区划编号',
    district_name varchar(32) charset utf8mb4  null comment '区级名称',
    detail        varchar(200) charset utf8mb4 null comment '详细地址',
    label         varchar(100) charset utf8mb4 null comment '标签',
    is_default    tinyint(1) default 0         not null comment '默认 0 否 1是'
) comment '地址簿' collate = utf8mb3_bin;

create table category
(
    id          bigint auto_increment comment '主键'
        primary key,
    type        int null comment '类型   1 菜品分类 2 套餐分类',
    name        varchar(64)   not null comment '分类名称',
    sort        int default 0 not null comment '顺序',
    status      int null comment '分类状态 0:禁用，1:启用',
    create_time datetime null comment '创建时间',
    update_time datetime null comment '更新时间',
    create_user bigint null comment '创建人',
    update_user bigint null comment '修改人',
    constraint idx_category_name
        unique (name)
) comment '菜品及套餐分类' collate = utf8mb3_bin;

create table dish
(
    id          bigint auto_increment comment '主键'
        primary key,
    name        varchar(64) not null comment '菜品名称',
    category_id bigint      not null comment '菜品分类id',
    price       decimal(10, 2) null comment '菜品价格',
    image       varchar(200) null comment '图片',
    description varchar(400) null comment '描述信息',
    status      int default 1 null comment '0 停售 1 起售',
    create_time datetime null comment '创建时间',
    update_time datetime null comment '更新时间',
    create_user bigint null comment '创建人',
    update_user bigint null comment '修改人',
    constraint idx_dish_name
        unique (name)
) comment '菜品' collate = utf8mb3_bin;

create table dish_flavor
(
    id      bigint auto_increment comment '主键'
        primary key,
    dish_id bigint not null comment '菜品',
    name    varchar(64) null comment '口味名称',
    value   varchar(500) null comment '口味数据list'
) comment '菜品口味关系表' collate = utf8mb3_bin;

create table employee
(
    id          bigint auto_increment comment '主键'
        primary key,
    name        varchar(32)   not null comment '姓名',
    username    varchar(32)   not null comment '用户名',
    password    varchar(64)   not null comment '密码',
    phone       varchar(11)   not null comment '手机号',
    sex         varchar(2)    not null comment '性别',
    id_number   varchar(18)   not null comment '身份证号',
    status      int default 1 not null comment '状态 0:禁用，1:启用',
    create_time datetime null comment '创建时间',
    update_time datetime null comment '更新时间',
    create_user bigint null comment '创建人',
    update_user bigint null comment '修改人',
    constraint idx_username
        unique (username)
) comment '员工信息' collate = utf8mb3_bin;

create table order_detail
(
    id          bigint auto_increment comment '主键'
        primary key,
    name        varchar(50) null comment '名字',
    image       varchar(100) null comment '图片',
    order_id    bigint         not null comment '订单id',
    dish_id     bigint null comment '菜品id',
    setmeal_id  bigint null comment '套餐id',
    dish_flavor varchar(50) null comment '口味',
    number      int default 1  not null comment '数量',
    amount      decimal(10, 2) not null comment '金额'
) comment '订单明细表' collate = utf8mb3_bin;

create table orders
(
    id                      bigint auto_increment comment '主键'
        primary key,
    number                  varchar(50) null comment '订单号',
    status                  int     default 1 not null comment '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
    user_id                 bigint            not null comment '下单用户',
    address_book_id         bigint            not null comment '地址id',
    order_time              datetime          not null comment '下单时间',
    checkout_time           datetime null comment '结账时间',
    pay_method              int     default 1 not null comment '支付方式 1微信,2支付宝',
    pay_status              tinyint default 0 not null comment '支付状态 0未支付 1已支付 2退款',
    amount                  decimal(10, 2)    not null comment '实收金额',
    remark                  varchar(100) null comment '备注',
    phone                   varchar(255) null comment '手机号',
    address                 varchar(255) null comment '地址',
    user_name               varchar(255) null comment '用户名称',
    consignee               varchar(255) null comment '收货人',
    cancel_reason           varchar(255) null comment '订单取消原因',
    rejection_reason        varchar(255) null comment '订单拒绝原因',
    cancel_time             datetime null comment '订单取消时间',
    estimated_delivery_time datetime null comment '预计送达时间',
    delivery_status         tinyint(1) default 1 not null comment '配送状态  1立即送出  0选择具体时间',
    delivery_time           datetime null comment '送达时间',
    pack_amount             int null comment '打包费',
    tableware_number        int null comment '餐具数量',
    tableware_status        tinyint(1) default 1 not null comment '餐具数量状态  1按餐量提供  0选择具体数量'
) comment '订单表' collate = utf8mb3_bin;

create table setmeal
(
    id          bigint auto_increment comment '主键'
        primary key,
    category_id bigint         not null comment '菜品分类id',
    name        varchar(64)    not null comment '套餐名称',
    price       decimal(10, 2) not null comment '套餐价格',
    status      int default 1 null comment '状态 0:停用 1:启用',
    description varchar(512) null comment '描述信息',
    image       varchar(255) null comment '图片',
    create_time datetime null comment '创建时间',
    update_time datetime null comment '更新时间',
    create_user bigint null comment '创建人',
    update_user bigint null comment '修改人',
    constraint idx_setmeal_name
        unique (name)
) comment '套餐' collate = utf8mb3_bin;

create table setmeal_dish
(
    id         bigint auto_increment comment '主键'
        primary key,
    setmeal_id varchar(32) not null comment '套餐id ',
    dish_id    varchar(32) not null comment '菜品id',
    name       varchar(32) null comment '菜品名称 （冗余字段）',
    price      decimal(10, 2) null comment '菜品原价（冗余字段）',
    copies     int null comment '份数'
) comment '套餐菜品关系' collate = utf8mb3_bin;


INSERT INTO waimai.user (id, openid, name, phone, sex, id_number, avatar, create_time)
VALUES (1, 'example_openid', 'John Doe', '17606639143', '0', '123456789012345678', 'http://example.com/avatar.jpg',
        '2024-11-20');


INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (56, '29', '54', '清炒小油菜', 18.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (57, '29', '49', '米饭', 2.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (58, '29', '68', '鸡蛋汤', 400.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (59, '30', '55', '蒜蓉娃娃菜', 1800.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (60, '30', '49', '米饭', 200.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (61, '30', '69', '平菇豆腐汤', 600.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (62, '31', '56', '清炒西兰花', 1800.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (63, '31', '49', '米饭', 200.00, 1);
INSERT INTO waimai.setmeal_dish (id, setmeal_id, dish_id, name, price, copies)
VALUES (64, '31', '68', '鸡蛋汤', 400.00, 1);


INSERT INTO waimai.address_book (id, user_id, consignee, sex, phone, province_code, province_name, city_code, city_name,
                                 district_code, district_name, detail, label, is_default)
VALUES (1, 1, 'zzlin', 1, '17606639143', null, null, null, null, null, null, '内蒙古', '公司', 0);
INSERT INTO waimai.address_book (id, user_id, consignee, sex, phone, province_code, province_name, city_code, city_name,
                                 district_code, district_name, detail, label, is_default)
VALUES (2, 1, '张国大', 1, '17685585214', null, null, null, null, null, null, '电白', '家', 0);
INSERT INTO waimai.address_book (id, user_id, consignee, sex, phone, province_code, province_name, city_code, city_name,
                                 district_code, district_name, detail, label, is_default)
VALUES (3, 1, '张过大', 1, '17685524841', null, null, null, null, null, null, '广州大学', '学校', 1);


INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (11, 1, '酒水饮料', 10, 1, '2024-10-09 22:09:18', '2024-10-09 22:09:18', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (12, 1, '传统主食', 9, 1, '2024-10-09 22:09:32', '2024-10-09 22:18:53', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (13, 2, '人气套餐', 12, 1, '2024-10-09 22:11:38', '2024-10-10 11:04:40', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (15, 2, '商务套餐', 13, 1, '2024-10-09 22:14:10', '2024-10-10 11:04:48', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (16, 1, '蜀味烤鱼', 4, 1, '2024-10-09 22:15:37', '2024-10-09 22:15:37', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (17, 1, '蜀味牛蛙', 5, 1, '2024-10-09 22:16:14', '2024-10-09 22:16:42', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (18, 1, '特色蒸菜', 6, 1, '2024-10-09 22:17:42', '2024-10-09 22:17:42', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (19, 1, '新鲜时蔬', 7, 1, '2024-10-09 22:18:12', '2024-10-09 22:18:28', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (20, 1, '水煮鱼', 8, 1, '2024-10-09 22:22:29', '2024-10-09 22:23:45', 1, 1);
INSERT INTO waimai.category (id, type, name, sort, status, create_time, update_time, create_user, update_user)
VALUES (21, 1, '汤类', 11, 1, '2024-10-10 10:51:47', '2024-10-10 10:51:47', 1, 1);


INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (46, '王老吉', 11, 600.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/cb892e0a-d008-43d4-bbd5-cd7afa5c58d9王老吉.jpg', '', 1,
        '2024-10-09 22:40:47', '2024-11-26 15:16:14', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (47, '北冰洋', 11, 400.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/c9ff5e9b-2f84-45d7-b6af-4d3801755353北冰洋.jpg',
        '还是小时候的味道', 1, '2024-10-10 09:18:49', '2024-11-26 15:16:33', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (48, '雪花啤酒', 11, 400.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/65434e6a-e6c5-4874-869a-67228fe3bf0f雪花啤酒.jpg', '', 1,
        '2024-10-10 09:22:54', '2024-11-26 15:21:24', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (49, '米饭', 12, 200.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/d1fd0bfd-031c-4158-97f0-010845c4e43d米饭.jpg',
        '精选五常大米', 1, '2024-10-10 09:30:17', '2024-11-26 15:21:32', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (50, '馒头', 12, 100.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/6de9d5cf-55c4-4f91-a284-34de2b8eb1c4馒头.jpg', '优质面粉', 1,
        '2024-10-10 09:34:28', '2024-11-26 15:21:42', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (51, '老坛酸菜鱼', 20, 5600.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/146e30ec-c512-4717-99eb-10d952af55df老坛酸菜鱼.jpg',
        '原料：汤，草鱼，酸菜', 1, '2024-10-10 09:40:51', '2024-11-26 15:21:53', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (52, '经典酸菜鮰鱼', 20, 6600.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/c7357e4b-c251-4776-818f-c7f20473dde6经典酸菜鮰鱼.jpg',
        '原料：酸菜，江团，鮰鱼', 1, '2024-10-10 09:46:02', '2024-11-26 15:21:14', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (53, '蜀味水煮草鱼', 20, 3800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/19e28acb-3248-4f50-a4d9-47fe0bebdf66蜀味水煮草鱼.jpg',
        '原料：草鱼，汤', 1, '2024-10-10 09:48:37', '2024-11-26 15:21:04', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (54, '清炒小油菜', 19, 1800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/869ffee0-371b-445b-bd41-af0047df4b33清炒小油菜.jpg',
        '原料：小油菜', 1, '2024-10-10 09:51:46', '2024-11-26 15:20:51', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (55, '蒜蓉娃娃菜', 19, 1800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/08272923-b26d-445f-abfb-879692baff9d蒜蓉娃娃菜.jpg',
        '原料：蒜，娃娃菜', 1, '2024-10-10 09:53:37', '2024-11-26 15:20:40', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (56, '清炒西兰花', 19, 1800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/b0b62908-08b3-48bd-8d8c-f4bde2442e6b清炒西兰花.jpg',
        '原料：西兰花', 1, '2024-10-10 09:55:44', '2024-11-26 15:20:22', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (57, '炝炒圆白菜', 19, 1800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/81a2f4da-3c84-40a1-90ee-5797305a6a78炝炒圆白菜.jpg',
        '原料：圆白菜', 1, '2024-10-10 09:58:35', '2024-11-26 15:20:03', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (58, '清蒸鲈鱼', 18, 9800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/addb6d4b-056c-4770-b3a3-efc4f1472591清蒸鲈鱼.jpg',
        '原料：鲈鱼', 1, '2024-10-10 10:12:28', '2024-11-26 15:36:58', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (59, '东坡肘子', 18, 13800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/6b819591-8fbc-4b19-9b48-223478255cc3东坡肘子.jpg',
        '原料：猪肘棒', 1, '2024-10-10 10:24:03', '2024-11-26 15:36:46', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (60, '梅菜扣肉', 18, 5800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/0e2606b8-4402-4eeb-9087-ffa7707cc4f5梅菜扣肉.jpg',
        '原料：猪肉，梅菜', 1, '2024-10-10 10:26:03', '2024-11-26 15:36:37', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (61, '剁椒鱼头', 18, 6600.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/1482b248-cd77-4ab7-b97f-d67b5ef643e0剁椒鱼头.jpg',
        '原料：鲢鱼，剁椒', 1, '2024-10-10 10:28:54', '2024-11-26 15:36:30', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (62, '金汤酸菜牛蛙', 17, 8800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/f46888e3-c256-46a8-beea-c342a17e1e96金汤酸菜牛蛙.jpg',
        '原料：鲜活牛蛙，酸菜', 1, '2024-10-10 10:33:05', '2024-11-26 15:36:24', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (63, '香锅牛蛙', 17, 8800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/8aad76a8-3eb8-4da0-bb77-c1342e69d052香锅牛蛙.jpg',
        '配料：鲜活牛蛙，莲藕，青笋', 1, '2024-10-10 10:35:40', '2024-11-26 15:36:18', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (64, '馋嘴牛蛙', 17, 8800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/1aaa1e3f-291b-4bd3-98da-29c75c0c4251馋嘴牛蛙.jpg',
        '配料：鲜活牛蛙，丝瓜，黄豆芽', 1, '2024-10-10 10:37:52', '2024-11-26 15:36:11', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (65, '草鱼2斤', 16, 6800.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/8dd5d4f3-6d06-4875-aceb-7613d8b91916草鱼2斤.jpg',
        '原料：草鱼，黄豆芽，莲藕', 1, '2024-10-10 10:41:08', '2024-11-26 15:36:03', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (66, '江团鱼2斤', 16, 11900.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/0f44811f-2dca-45d9-9744-25425077adb2江团鱼2斤.jpg',
        '配料：江团鱼，黄豆芽，莲藕', 1, '2024-10-10 10:42:42', '2024-11-26 15:35:56', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (67, '鮰鱼2斤', 16, 7200.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/a78b3f17-161b-43ae-ba04-d5695fea45b5鮰鱼2斤.jpg',
        '原料：鮰鱼，黄豆芽，莲藕', 1, '2024-10-10 10:43:56', '2024-11-26 15:35:48', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (68, '鸡蛋汤', 21, 400.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/c7314d76-e803-4015-bc6c-5178f87028c5鸡蛋汤.jpg',
        '配料：鸡蛋，紫菜', 1, '2024-10-10 10:54:25', '2024-11-26 15:35:40', 1, 1);
INSERT INTO waimai.dish (id, name, category_id, price, image, description, status, create_time, update_time,
                         create_user, update_user)
VALUES (69, '平菇豆腐汤', 21, 600.00,
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/f0d17d35-2817-4476-8bee-c15fce025012平菇豆腐汤.jpg',
        '配料：豆腐，平菇', 1, '2024-10-10 10:55:02', '2024-11-26 15:35:31', 1, 1);


INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (40, 10, '甜味', '["无糖","少糖","半糖","多糖","全糖"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (41, 7, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (42, 7, '温度', '["热饮","常温","去冰","少冰","多冰"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (45, 6, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (46, 6, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (47, 5, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (48, 5, '甜味', '["无糖","少糖","半糖","多糖","全糖"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (49, 2, '甜味', '["无糖","少糖","半糖","多糖","全糖"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (50, 4, '甜味', '["无糖","少糖","半糖","多糖","全糖"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (51, 3, '甜味', '["无糖","少糖","半糖","多糖","全糖"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (52, 3, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (110, 57, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (111, 56, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (112, 54, '忌口', '["不要葱","不要蒜","不要香菜"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (113, 53, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (114, 53, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (115, 52, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (116, 52, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (117, 51, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (118, 51, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (119, 67, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (120, 66, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (121, 65, '辣度', '["不辣","微辣","中辣","重辣"]');
INSERT INTO waimai.dish_flavor (id, dish_id, name, value)
VALUES (122, 60, '忌口', '["不要葱","不要蒜","不要香菜","不要辣"]');

INSERT INTO waimai.employee (id, name, username, password, phone, sex, id_number, status, create_time, update_time,
                             create_user, update_user)
VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1,
        '2022-02-15 15:51:20', '2024-09-17 09:16:20', 10, 1);
INSERT INTO waimai.employee (id, name, username, password, phone, sex, id_number, status, create_time, update_time,
                             create_user, update_user)
VALUES (2, '管理员2', 'root', 'e10adc3949ba59abbe56e057f20f883e', '18878271821', '0', '445627118281727112', 1,
        '2024-11-21 23:09:44', '2024-11-21 23:09:44', 1, 1);

INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (32, '平菇豆腐汤',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/f0d17d35-2817-4476-8bee-c15fce025012平菇豆腐汤.jpg', 15, 69,
        null, null, 2, 600.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (33, '雪花啤酒',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/65434e6a-e6c5-4874-869a-67228fe3bf0f雪花啤酒.jpg', 15, 48,
        null, null, 2, 400.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (34, '北冰洋',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/c9ff5e9b-2f84-45d7-b6af-4d3801755353北冰洋.jpg', 15, 47,
        null, null, 2, 400.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (35, '馒头', 'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/6de9d5cf-55c4-4f91-a284-34de2b8eb1c4馒头.jpg',
        15, 50, null, null, 1, 100.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (36, '米饭', 'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/d1fd0bfd-031c-4158-97f0-010845c4e43d米饭.jpg',
        15, 49, null, null, 1, 200.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (37, '蒜蓉娃娃菜',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/08272923-b26d-445f-abfb-879692baff9d蒜蓉娃娃菜.jpg', 15, 55,
        null, null, 1, 1800.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (38, '香锅牛蛙',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/8aad76a8-3eb8-4da0-bb77-c1342e69d052香锅牛蛙.jpg', 15, 63,
        null, null, 1, 8800.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (39, '金汤酸菜牛蛙',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/f46888e3-c256-46a8-beea-c342a17e1e96金汤酸菜牛蛙.jpg', 15,
        62, null, null, 1, 8800.00);
INSERT INTO waimai.order_detail (id, name, image, order_id, dish_id, setmeal_id, dish_flavor, number, amount)
VALUES (40, '草鱼2斤',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/8dd5d4f3-6d06-4875-aceb-7613d8b91916草鱼2斤.jpg', 15, 65,
        null, '微辣', 1, 6800.00);

INSERT INTO waimai.orders (id, number, status, user_id, address_book_id, order_time, checkout_time, pay_method,
                           pay_status, amount, remark, phone, address, user_name, consignee, cancel_reason,
                           rejection_reason, cancel_time, estimated_delivery_time, delivery_status, delivery_time,
                           pack_amount, tableware_number, tableware_status)
VALUES (15, '1732609470156', 5, 1, 3, '2024-11-26 16:24:30', '2024-11-26 16:24:31', 1, 1, 29300.00, '', '17685524841',
        '广州大学', 'John Doe', '张过大', null, null, null, '2024-11-26 17:24:00', 1, '2024-11-26 16:24:40', 0, 0, 0);

INSERT INTO waimai.setmeal (id, category_id, name, price, status, description, image, create_time, update_time,
                            create_user, update_user)
VALUES (29, 15, '商务套餐A', 2000.00, 1, '',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/02254a25-1749-4e7d-bd0d-4557605967f7商务套餐A.jpg',
        '2024-10-10 10:58:09', '2024-11-26 16:09:36', 1, 1);
INSERT INTO waimai.setmeal (id, category_id, name, price, status, description, image, create_time, update_time,
                            create_user, update_user)
VALUES (30, 15, '商务套餐B', 2200.00, 1, '',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/188aa5bf-b6f7-4d2f-8fe8-53bb266ad8aa商务套餐B.jpg',
        '2024-10-10 11:00:13', '2024-11-26 16:16:35', 1, 1);
INSERT INTO waimai.setmeal (id, category_id, name, price, status, description, image, create_time, update_time,
                            create_user, update_user)
VALUES (31, 15, '商务套餐C', 2400.00, 1, '',
        'https://waimai-class.oss-cn-shenzhen.aliyuncs.com/3989f3a4-1627-48c4-91e7-86294f396d1b商务套餐C.jpg',
        '2024-10-10 11:11:23', '2024-11-26 16:16:33', 1, 1);
