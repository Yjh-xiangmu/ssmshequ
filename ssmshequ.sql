/*
 Navicat Premium Data Transfer

 Source Server         : yjh
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : ssmshequ

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 17/04/2026 17:08:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理员姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456', '超级管理员', '13800138001');

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '居民ID',
  `doctor_id` int NOT NULL COMMENT '医生ID',
  `appoint_date` date NOT NULL COMMENT '预约日期',
  `appoint_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '预约时段',
  `reason` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '就诊原因',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态 0待确认 1已确认 2已取消 3已完成',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '预约表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appointment
-- ----------------------------
INSERT INTO `appointment` VALUES (1, 1, 1, '2026-04-15', '上午 09:00-10:00', '感冒发烧', 3, '2026-04-14 08:00:00');
INSERT INTO `appointment` VALUES (2, 1, 2, '2026-04-15', '上午 08:00-09:00', 'emmmmm', 0, '2026-04-14 14:10:05');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `image_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片路径',
  `link_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `sort_order` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1启用 0禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '轮播图表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (3, '测试', '/upload/1776182453845_fe6eedc5-ce0d-4373-9336-a985f7a74071.png', '', 0, 1);

-- ----------------------------
-- Table structure for base_data
-- ----------------------------
DROP TABLE IF EXISTS `base_data`;
CREATE TABLE `base_data`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型 department/notice_category/appoint_type',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '基础数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of base_data
-- ----------------------------
INSERT INTO `base_data` VALUES (1, 'department', 'NEI', '内科', 1, 1);
INSERT INTO `base_data` VALUES (2, 'department', 'WAI', '外科', 2, 1);
INSERT INTO `base_data` VALUES (3, 'department', 'ER', '儿科', 3, 1);
INSERT INTO `base_data` VALUES (4, 'notice_category', 'ACTIVITY', '活动通知', 1, 1);
INSERT INTO `base_data` VALUES (5, 'notice_category', 'HEALTH', '健康科普', 2, 1);
INSERT INTO `base_data` VALUES (6, 'department', 'AA', '测试', 4, 1);
INSERT INTO `base_data` VALUES (7, 'drug_category', 'kangshengsu', '抗生素', 0, 1);
INSERT INTO `base_data` VALUES (8, 'drug_category', 'enen', '嗯嗯', 2, 1);

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `job_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工号',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `gender` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '科室',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `intro` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1在职 0离职',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医生表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (1, '10001', 'doctor01', '123456', '张医生1', '男', '13900139000', '内科', '主治医师', '从事内科临床工作10年', 1);
INSERT INTO `doctor` VALUES (2, '10002', '10002', '123456', '张医生2', '男', '10002', '内科', '副主任', '牛逼', 1);

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '药品名称',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类',
  `spec` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `stock` int NULL DEFAULT 0 COMMENT '库存数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `manufacturer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `expire_date` date NULL DEFAULT NULL COMMENT '有效期至',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `ingredients` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主要成分',
  `usage_info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用法用量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '药品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES (1, '阿莫西林胶囊', '抗生素', '0.25g*24粒', '盒', 100, 12.50, '华北制药', '2026-12-01', '常规抗菌消炎', NULL, NULL);
INSERT INTO `drug` VALUES (2, '布洛芬片', '嗯嗯', '0.1g*100片', '瓶', 80, 8.00, '上海医药', '2027-03-01', '退烧止痛', '', '');
INSERT INTO `drug` VALUES (3, '板蓝根', '抗生素', '5g', '包', 50, 3.00, '嘿嘿', '2026-04-14', '嘿嘿', '啊啊', '啊啊啊？？');

-- ----------------------------
-- Table structure for drug_favorite
-- ----------------------------
DROP TABLE IF EXISTS `drug_favorite`;
CREATE TABLE `drug_favorite`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `drug_id` int NOT NULL COMMENT '药品ID',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '居民药品收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug_favorite
-- ----------------------------
INSERT INTO `drug_favorite` VALUES (1, 2, 3, '2026-04-14 15:07:48');
INSERT INTO `drug_favorite` VALUES (2, 1, 3, '2026-04-16 00:40:22');

-- ----------------------------
-- Table structure for evaluation
-- ----------------------------
DROP TABLE IF EXISTS `evaluation`;
CREATE TABLE `evaluation`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '评价人ID',
  `doctor_id` int NOT NULL COMMENT '被评价医生ID',
  `score` int NOT NULL COMMENT '评分(1-5星)',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文字评价',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '医生评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of evaluation
-- ----------------------------
INSERT INTO `evaluation` VALUES (1, 1, 2, 5, '好a', '2026-04-14 14:36:53');
INSERT INTO `evaluation` VALUES (2, 1, 1, 5, '好！！！！！！！！！！！！！！\r\n', '2026-04-14 14:37:11');
INSERT INTO `evaluation` VALUES (3, 2, 2, 1, 'emmmmmmm', '2026-04-14 14:38:20');
INSERT INTO `evaluation` VALUES (4, 2, 2, 1, '？', '2026-04-14 14:38:36');

-- ----------------------------
-- Table structure for health_record
-- ----------------------------
DROP TABLE IF EXISTS `health_record`;
CREATE TABLE `health_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '居民ID',
  `record_date` date NOT NULL COMMENT '记录日期',
  `systolic_bp` int NULL DEFAULT NULL COMMENT '收缩压(高压 mmHg)',
  `diastolic_bp` int NULL DEFAULT NULL COMMENT '舒张压(低压 mmHg)',
  `blood_sugar` decimal(5, 2) NULL DEFAULT NULL COMMENT '空腹血糖(mmol/L)',
  `heart_rate` int NULL DEFAULT NULL COMMENT '心率(次/分)',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态: 0正常 1异常预警',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '健康体征记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of health_record
-- ----------------------------
INSERT INTO `health_record` VALUES (1, 1, '2026-04-14', 170, 90, 7.20, 110, 1, '2026-04-14 14:27:38');

-- ----------------------------
-- Table structure for medical_case
-- ----------------------------
DROP TABLE IF EXISTS `medical_case`;
CREATE TABLE `medical_case`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '患者ID',
  `doctor_id` int NOT NULL COMMENT '医生ID',
  `visit_date` date NOT NULL COMMENT '就诊日期',
  `chief_complaint` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '主诉',
  `diagnosis` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '诊断结果',
  `prescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '处方/治疗方案',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1正常 0已归档',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '病例表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of medical_case
-- ----------------------------
INSERT INTO `medical_case` VALUES (1, 1, 1, '2026-04-14', '头痛发热两天', '上呼吸道感染', '阿莫西林胶囊 0.5g tid po，布洛芬片退热', '注意休息多喝水', 1, '2026-04-01 10:30:00');
INSERT INTO `medical_case` VALUES (2, 1, 1, '2026-04-14', '写毕设要疯了啊', '脑子坏了', '刷会抖音就好了', 'ok', 1, '2026-04-14 13:22:56');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类',
  `is_top` tinyint NULL DEFAULT 0 COMMENT '是否置顶 1是 0否',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 1已发布 0草稿',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '社区公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '社区健康义诊活动通知', '本周六上午9点在社区广场举办义诊活动，欢迎居民参与。', '活动通知', 1, 1, '2026-04-10 09:00:00');
INSERT INTO `notice` VALUES (2, '新冠防控温馨提示', '请居民注意个人卫生，出入公共场所佩戴口罩。', '健康科普', 0, 1, '2026-04-12 10:00:00');
INSERT INTO `notice` VALUES (3, '测试', '测试用', '活动通知', 0, 1, '2026-04-14 10:11:54');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '居民用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 's26012671h', '123456', '去问问别人', '1008612');
INSERT INTO `user` VALUES (2, 'zhangsan', '123456', '张三', '111111');

SET FOREIGN_KEY_CHECKS = 1;
