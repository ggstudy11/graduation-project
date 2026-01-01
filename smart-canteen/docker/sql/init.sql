-- 创建数据库
CREATE DATABASE IF NOT EXISTS smart_canteen CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE smart_canteen;

-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    `password` VARCHAR(100) NOT NULL COMMENT '密码',
    `nickname` VARCHAR(50) COMMENT '昵称',
    `phone` VARCHAR(20) COMMENT '手机号',
    `email` VARCHAR(100) COMMENT '邮箱',
    `role` VARCHAR(20) DEFAULT 'USER' COMMENT '角色: USER/ADMIN',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 菜品表
CREATE TABLE IF NOT EXISTS `dish` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    `name` VARCHAR(100) NOT NULL COMMENT '菜品名称',
    `description` TEXT COMMENT '菜品描述',
    `price` DECIMAL(10, 2) NOT NULL COMMENT '价格',
    `image_url` VARCHAR(255) COMMENT '图片地址',
    `category` VARCHAR(50) COMMENT '分类',
    `status` TINYINT DEFAULT 1 COMMENT '状态: 1-上架, 0-下架',
    `stock` INT DEFAULT 0 COMMENT '库存',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='菜品表';

-- 订单表
CREATE TABLE IF NOT EXISTS `orders` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    `order_no` VARCHAR(64) NOT NULL UNIQUE COMMENT '订单号',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `total_amount` DECIMAL(10, 2) NOT NULL COMMENT '总金额',
    `status` TINYINT DEFAULT 0 COMMENT '状态: 0-待支付, 1-已支付, 2-已完成, 3-已取消',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单详情表
CREATE TABLE IF NOT EXISTS `order_item` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键ID',
    `order_id` BIGINT NOT NULL COMMENT '订单ID',
    `dish_id` BIGINT NOT NULL COMMENT '菜品ID',
    `dish_name` VARCHAR(100) NOT NULL COMMENT '菜品名称',
    `price` DECIMAL(10, 2) NOT NULL COMMENT '单价',
    `quantity` INT NOT NULL COMMENT '数量',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单详情表';

-- 插入管理员账号 (密码: 123456)
INSERT INTO `user` (`username`, `password`, `nickname`, `role`) VALUES ('admin', '123456', '管理员', 'ADMIN');
