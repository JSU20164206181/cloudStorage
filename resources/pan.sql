/*
 Navicat Premium Data Transfer

 Source Server         : yunpan
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : 47.106.187.69:3306
 Source Schema         : pan

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 12/09/2019 15:57:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_inf
-- ----------------------------
DROP TABLE IF EXISTS `admin_inf`;
CREATE TABLE `admin_inf`  (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员标识',
  `admin_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员名称',
  `admin_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`admin_id`, `admin_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_inf
-- ----------------------------
INSERT INTO `admin_inf` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for directory_inf
-- ----------------------------
DROP TABLE IF EXISTS `directory_inf`;
CREATE TABLE `directory_inf`  (
  `directory_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件目录表主键',
  `directory_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '目录名',
  `parent_id` int(11) NOT NULL COMMENT '父目录ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_datetime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间（修改时间）',
  `directory_status` int(11) NOT NULL DEFAULT 1 COMMENT ' 1启用 2禁用 3删除（回收站）',
  PRIMARY KEY (`directory_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of directory_inf
-- ----------------------------
INSERT INTO `directory_inf` VALUES (1, '我的资源', 0, 1, '2019-09-10 15:01:27', 1);
INSERT INTO `directory_inf` VALUES (2, '手机', 1, 1, '2019-09-02 17:46:16', 2);
INSERT INTO `directory_inf` VALUES (3, 'QQ', 1, 1, '2019-08-29 09:27:02', 1);
INSERT INTO `directory_inf` VALUES (4, '微信', 1, 1, '2019-08-29 09:28:00', 1);
INSERT INTO `directory_inf` VALUES (5, 'QQ', 2, 3, '2019-08-29 09:28:29', 1);
INSERT INTO `directory_inf` VALUES (6, '电脑', 1, 1, '2019-09-08 16:11:00', 1);
INSERT INTO `directory_inf` VALUES (7, 'A', 6, 1, '2019-09-09 15:19:04', 1);
INSERT INTO `directory_inf` VALUES (8, 'B', 6, 1, '2019-09-08 16:35:20', 1);
INSERT INTO `directory_inf` VALUES (10, '123520190902-200919', 0, 1, '2019-09-02 20:09:20', 0);
INSERT INTO `directory_inf` VALUES (11, '图片', 0, 9, '2019-09-10 16:14:52', 0);
INSERT INTO `directory_inf` VALUES (15, '图片', 12, 9, '2019-09-10 16:14:58', 1);
INSERT INTO `directory_inf` VALUES (20, '图片', 0, 9, '2019-09-10 16:15:05', 1);
INSERT INTO `directory_inf` VALUES (24, '重命名文件夹', 0, 1, '2019-09-02 21:24:18', 0);
INSERT INTO `directory_inf` VALUES (26, '新建文件夹1', 1, 1, '2019-09-06 10:12:29', 0);
INSERT INTO `directory_inf` VALUES (53, '回收测试文件夹第一层', 0, 1, '2019-09-11 11:25:34', 1);
INSERT INTO `directory_inf` VALUES (54, '回收第二层1', 53, 1, '2019-09-10 21:26:51', 1);
INSERT INTO `directory_inf` VALUES (55, '回收第二层2', 53, 1, '2019-09-10 21:27:15', 1);
INSERT INTO `directory_inf` VALUES (56, '回收测试第三层', 55, 1, '2019-09-11 10:25:24', 1);
INSERT INTO `directory_inf` VALUES (57, 'mwy', 0, 1, '2019-09-11 18:24:53', 1);
INSERT INTO `directory_inf` VALUES (58, '1-1', 57, 1, '2019-09-11 18:25:34', 1);
INSERT INTO `directory_inf` VALUES (59, '1-2', 57, 1, '2019-09-11 18:25:39', 1);
INSERT INTO `directory_inf` VALUES (60, '2-1', 58, 1, '2019-09-11 18:26:03', 1);
INSERT INTO `directory_inf` VALUES (63, '新建文件夹', 0, 1, '2019-09-11 21:02:51', 1);
INSERT INTO `directory_inf` VALUES (64, '新建1', 0, 1, '2019-09-11 21:04:52', 1);
INSERT INTO `directory_inf` VALUES (65, '新建文件夹2', 0, 101, '2019-09-11 21:08:16', 1);
INSERT INTO `directory_inf` VALUES (66, '我的资源', 0, 7, '2019-09-11 22:08:46', 1);
INSERT INTO `directory_inf` VALUES (67, '云盘资源', 0, 7, '2019-09-11 22:08:58', 1);
INSERT INTO `directory_inf` VALUES (68, '2019', 66, 7, '2019-09-11 22:09:34', 1);
INSERT INTO `directory_inf` VALUES (69, '2018', 66, 7, '2019-09-11 22:09:41', 1);
INSERT INTO `directory_inf` VALUES (70, '5', 68, 7, '2019-09-11 22:09:48', 1);
INSERT INTO `directory_inf` VALUES (71, '6', 68, 7, '2019-09-11 22:09:52', 1);
INSERT INTO `directory_inf` VALUES (73, '2019', 72, 10001, '2019-09-11 22:50:24', 3);
INSERT INTO `directory_inf` VALUES (74, '2018', 72, 10001, '2019-09-11 22:50:29', 3);
INSERT INTO `directory_inf` VALUES (75, '5', 73, 10001, '2019-09-11 22:50:49', 3);
INSERT INTO `directory_inf` VALUES (76, '6', 73, 10001, '2019-09-11 22:50:40', 3);
INSERT INTO `directory_inf` VALUES (77, '我的资源', 0, 10001, '2019-09-11 23:08:06', 1);
INSERT INTO `directory_inf` VALUES (78, '2019', 77, 10001, '2019-09-11 23:08:17', 1);
INSERT INTO `directory_inf` VALUES (79, '2018', 77, 10001, '2019-09-11 23:08:22', 1);
INSERT INTO `directory_inf` VALUES (80, '9', 78, 10001, '2019-09-11 23:08:30', 1);
INSERT INTO `directory_inf` VALUES (81, '8', 78, 10001, '2019-09-11 23:08:34', 1);
INSERT INTO `directory_inf` VALUES (83, '测试文件夹一层1', 77, 10001, '2019-09-12 14:54:50', 1);
INSERT INTO `directory_inf` VALUES (84, '测试文件夹二层1', 83, 10001, '2019-09-12 13:13:50', 1);
INSERT INTO `directory_inf` VALUES (85, '测试文件夹二层2', 83, 10001, '2019-09-12 13:14:07', 1);
INSERT INTO `directory_inf` VALUES (86, '测试文件夹三层1', 84, 10001, '2019-09-12 13:17:13', 1);
INSERT INTO `directory_inf` VALUES (88, '测试文件夹二层1', 87, 10001, '2019-09-12 13:13:50', 3);
INSERT INTO `directory_inf` VALUES (89, '测试文件夹三层1', 88, 10001, '2019-09-12 13:17:13', 3);
INSERT INTO `directory_inf` VALUES (90, '测试文件夹二层2', 87, 10001, '2019-09-12 13:14:07', 3);
INSERT INTO `directory_inf` VALUES (92, '测试文件夹二层1', 91, 10001, '2019-09-12 13:13:50', 3);
INSERT INTO `directory_inf` VALUES (93, '测试文件夹三层1', 92, 10001, '2019-09-12 13:17:13', 3);
INSERT INTO `directory_inf` VALUES (94, '测试文件夹二层2', 91, 10001, '2019-09-12 13:14:07', 3);
INSERT INTO `directory_inf` VALUES (95, '我的', 0, 10001, '2019-09-12 14:51:54', 1);
INSERT INTO `directory_inf` VALUES (96, '我的', 77, 10001, '2019-09-12 14:51:54', 1);

-- ----------------------------
-- Table structure for file_chunk_inf
-- ----------------------------
DROP TABLE IF EXISTS `file_chunk_inf`;
CREATE TABLE `file_chunk_inf`  (
  `file_chunk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件分片上传表标识',
  `user_id` int(11) NOT NULL COMMENT '上传人ID',
  `file_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `chunks` int(11) NULL DEFAULT NULL COMMENT '文件被分解的总块数',
  `chunk` int(11) NOT NULL COMMENT '当前块数',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `file_md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件签名 md5码',
  `chunk_size` int(11) NULL DEFAULT NULL COMMENT '分块大小',
  `file_status` int(1) NOT NULL COMMENT '文件状态 1传输中 2传输完毕',
  `percentage` int(11) NOT NULL COMMENT '上传百分比',
  PRIMARY KEY (`file_chunk_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_chunk_inf
-- ----------------------------
INSERT INTO `file_chunk_inf` VALUES (20, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/10001', '91ba28e6b46de3537a685a6960a8f277', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (21, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/10001', '91ba28e6b46de3537a685a6960a8f277', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (22, 10001, '邪不压正.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/10001', '5631818ea7a1ac79d917693687e710fb', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (23, 10001, '邪不压正.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/10001', '06d6b3cb29829d24834a72abb6f085a2', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (24, 10001, '邪不压正.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/10001', '06d6b3cb29829d24834a72abb6f085a2', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (25, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (26, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (27, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (28, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (29, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (30, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (31, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (32, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '02567b580f461db2de13895bb01dd616', NULL, 1, 0);
INSERT INTO `file_chunk_inf` VALUES (33, 10001, '06-联系我们.mp4', NULL, 0, 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10', '91ba28e6b46de3537a685a6960a8f277', NULL, 1, 0);

-- ----------------------------
-- Table structure for file_inf
-- ----------------------------
DROP TABLE IF EXISTS `file_inf`;
CREATE TABLE `file_inf`  (
  `file_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件上传表标识',
  `user_id` int(11) NOT NULL COMMENT '上传人ID',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上传人名称',
  `upload_datetime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间（修改时间）',
  `upload_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '上传文件的IP',
  `file_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `file_size` int(11) NOT NULL COMMENT '文件大小 单位KB，不足1KB按1KB计算',
  `file_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件类型 1图片 2视频 3文档 4音乐 5种子 6其它 ',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `person_id` int(11) NOT NULL COMMENT '个人信息表ID',
  `directory_id` int(11) NOT NULL COMMENT '文件所在目录ID',
  `file_status` int(1) NOT NULL COMMENT '文件状态 1启用 2禁用 3删除（回收站）',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_inf
-- ----------------------------
INSERT INTO `file_inf` VALUES (1, 1, '1', '2019-09-06 10:47:54', '1', '图片.png', 1000, '1', '/cloudStorage/web/file/4.jpg', 1, 0, 1);
INSERT INTO `file_inf` VALUES (2, 1, '1', '2019-08-31 09:59:53', '1', '文档.txt', 69, '3', '1', 1, 0, 1);
INSERT INTO `file_inf` VALUES (3, 1, '1', '2019-08-31 09:59:53', '1', '3.mp4', 9626, '2', '/cloudStorage/web/file/3.mp4', 1, 0, 1);
INSERT INTO `file_inf` VALUES (4, 1, '1', '2019-08-31 09:59:53', '1', '2.mp3', 110, '4', '/cloudStorage/web/file/2.mp3', 1, 0, 1);
INSERT INTO `file_inf` VALUES (5, 9, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 7, 1);
INSERT INTO `file_inf` VALUES (7, 9, '1', '2019-08-31 09:59:53', '1', '使用图片1.png', 2049, '1', '1', 1, 0, 1);
INSERT INTO `file_inf` VALUES (8, 1, '1', '2019-08-31 09:59:53', '1', '禁用图片.png', 1024, '1', '1', 1, 0, 2);
INSERT INTO `file_inf` VALUES (10, 1, '1', '2019-09-11 14:21:10', '1', '回收测试图片第一层1.png', 2049, '1', '1', 1, 0, 1);
INSERT INTO `file_inf` VALUES (11, 1, '1', '2019-09-11 09:46:23', '1', '回收测试2层.png', 2049, '1', '1', 1, 53, 1);
INSERT INTO `file_inf` VALUES (12, 9, '1', '2019-09-10 14:50:28', '1', '图片管理.png', 2049, '1', '1', 1, 0, 1);
INSERT INTO `file_inf` VALUES (13, 1, '1', '2019-09-11 09:47:17', '1', '回收测试第三层.png', 2049, '1', '1', 1, 55, 1);
INSERT INTO `file_inf` VALUES (14, 1, '1', '2019-08-31 09:59:53', '1', '使用图片7.png', 2049, '1', '1', 1, 28, 3);
INSERT INTO `file_inf` VALUES (16, 1, '1', '2019-08-31 09:59:53', '1', 'B的图片9.png', 2049, '1', '1', 1, 8, 1);
INSERT INTO `file_inf` VALUES (17, 1, '1', '2019-08-31 09:59:53', '1', 'A的图片10.png', 2049, '1', '1', 1, 7, 1);
INSERT INTO `file_inf` VALUES (18, 1, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 8, 1);
INSERT INTO `file_inf` VALUES (20, 9, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 32, 1);
INSERT INTO `file_inf` VALUES (21, 1, '1', '2019-08-31 09:59:53', '1', 'A的图片10.png', 2049, '1', '1', 1, 32, 1);
INSERT INTO `file_inf` VALUES (22, 9, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 7, 3);
INSERT INTO `file_inf` VALUES (33, 1, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 48, 3);
INSERT INTO `file_inf` VALUES (34, 1, '1', '2019-08-31 09:59:53', '1', 'A的图片10.png', 2049, '1', '1', 1, 48, 3);
INSERT INTO `file_inf` VALUES (35, 9, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 48, 1);
INSERT INTO `file_inf` VALUES (36, 1, '1', '2019-08-31 09:59:53', '1', 'A的图片10.png', 2049, '1', '1', 1, 48, 3);
INSERT INTO `file_inf` VALUES (37, 1, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 51, 3);
INSERT INTO `file_inf` VALUES (38, 1, '1', '2019-08-31 09:59:53', '1', 'A的图片10.png', 2049, '1', '1', 1, 51, 3);
INSERT INTO `file_inf` VALUES (39, 1, '1', '2019-08-31 09:59:53', '1', '种子.torrent', 1024, '5', '1', 1, 51, 3);
INSERT INTO `file_inf` VALUES (40, 9, '1', '2019-08-31 09:59:53', '1', 'A的图片10.png', 2049, '1', '1', 1, 51, 1);
INSERT INTO `file_inf` VALUES (43, 1, '1', '2019-09-10 15:52:31', '1', '其他.zip', 1024, '6', '1', 1, 1, 1);
INSERT INTO `file_inf` VALUES (44, 9, '1', '2019-08-31 09:59:53', '1', '20190910_155309_其他.zip', 1024, '6', '1', 1, 1, 1);
INSERT INTO `file_inf` VALUES (49, 1, 'mwy', '2019-09-10 19:15:07', '127.0.0.1', 'HUI-master.zip', 2001, '6', 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10/abc14184703ba444f286ebbb180499b4.zip', 10001, 57, 1);
INSERT INTO `file_inf` VALUES (50, 1, 'mwy', '2019-09-10 19:44:19', '127.0.0.1', '06联系我们.mp4', 193224, '2', 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-10/02567b580f461db2de13895bb01dd616.mp4', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (51, 7, 'mwy123', '2019-09-11 20:58:25', '127.0.0.1', '06-联系我们.mp4', 193224, '2', 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/02567b580f461db2de13895bb01dd616.mp4', 1, 0, 1);
INSERT INTO `file_inf` VALUES (52, 7, 'mwy123', '2019-09-11 20:58:27', '127.0.0.1', 'HUI-master.zip', 2001, '6', 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/abc14184703ba444f286ebbb180499b4.zip', 1, 0, 1);
INSERT INTO `file_inf` VALUES (53, 7, 'mwy123', '2019-09-11 20:58:27', '127.0.0.1', '2016级UI设计期末考试素材（A卷）.zip', 30176, '6', 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/f7d29b6ce8eb11418e6eb542c5d753a0.zip', 1, 66, 1);
INSERT INTO `file_inf` VALUES (54, 7, 'mwy123', '2019-09-11 20:58:28', '127.0.0.1', 'shexd-batatas-master.zip', 7938, '6', 'G:\\JAVA\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/d0b2ece60ecf768a02751b2ec2f75373.zip', 1, 0, 1);
INSERT INTO `file_inf` VALUES (55, 1, 'hdq123', '2019-09-11 21:41:11', '127.0.0.1', '音乐.mp3', 110, '4', 'E:\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/214835989230018483774e7454ce8b42.mp3', 1, 0, 1);
INSERT INTO `file_inf` VALUES (56, 1, 'hdq123', '2019-09-11 21:41:44', '127.0.0.1', '头像.jpg', 18, '1', 'E:\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/547a11405c57dc8d5977914a02f04af3.jpg', 1, 0, 1);
INSERT INTO `file_inf` VALUES (57, 1, 'hdq123', '2019-09-11 21:47:04', '127.0.0.1', '头像2.jpg', 28, '1', 'E:\\apache-tomcat-8.0.26\\webapps\\cloudStorage\\../cloudUpload/2019-09-11/f7d5ed058c656fdca9737a81fc95384e.jpg', 1, 0, 1);
INSERT INTO `file_inf` VALUES (69, 10001, 'mwy123', '2019-09-11 23:07:12', '127.0.0.1', '公园.jpg', 54, '1', '../cloudUpload/2019-09-11/f90ef6f2edae7f6323b9b4720dd8e434.jpg', 10001, 77, 1);
INSERT INTO `file_inf` VALUES (71, 10001, 'mwy123', '2019-09-11 23:07:12', '127.0.0.1', '20190912_145350_山林雪景.jpg', 43, '1', '../cloudUpload/2019-09-11/0d35bff65118f08f9c0ac4c3eada7712.jpg', 10001, 77, 1);
INSERT INTO `file_inf` VALUES (73, 10001, 'mwy123', '2019-09-12 13:17:45', '127.0.0.1', '测试图片三层.jpg', 18, '1', '../cloudUpload/2019-09-11/547a11405c57dc8d5977914a02f04af3.jpg', 10001, 84, 1);
INSERT INTO `file_inf` VALUES (74, 10001, 'mwy123', '2019-09-11 23:07:13', '127.0.0.1', '视频测试.mp4', 9635, '2', '../cloudUpload/2019-09-11/04f95a3f9bceb9ee9371fa51cc56b684.mp4', 10001, 77, 1);
INSERT INTO `file_inf` VALUES (76, 10001, 'mwy123', '2019-09-11 23:11:02', '127.0.0.1', '1565885489517.jpg', 53, '1', '../cloudUpload/2019-09-11/4040db5278e7f88e07992572413c2333.jpg', 10001, 80, 1);
INSERT INTO `file_inf` VALUES (79, 10001, 'mwy123', '2019-09-11 23:11:03', '127.0.0.1', '2016级UI设计期末考试素材（A卷）.zip', 30176, '6', '../cloudUpload/2019-09-11/f7d29b6ce8eb11418e6eb542c5d753a0.zip', 10001, 79, 1);
INSERT INTO `file_inf` VALUES (81, 10001, 'mwy123', '2019-09-11 23:11:03', '127.0.0.1', '2016级UI设计期末考试素材（A卷）.zip', 30176, '6', '../cloudUpload/2019-09-11/f7d29b6ce8eb11418e6eb542c5d753a0.zip', 10001, 82, 3);
INSERT INTO `file_inf` VALUES (82, 10001, 'mwy123', '2019-09-12 13:18:27', '127.0.0.1', '测试图片二层.jpg', 18, '1', '../cloudUpload/2019-09-11/547a11405c57dc8d5977914a02f04af3.jpg', 10001, 83, 1);
INSERT INTO `file_inf` VALUES (86, 10001, 'mwy123', '2019-09-11 23:07:12', '127.0.0.1', '山林雪景.jpg', 43, '1', '../cloudUpload/2019-09-11/0d35bff65118f08f9c0ac4c3eada7712.jpg', 10001, 77, 1);
INSERT INTO `file_inf` VALUES (95, 10001, 'mwy123', '2019-09-11 23:07:12', '127.0.0.1', '20190912_145350_公园.jpg', 54, '1', '../cloudUpload/2019-09-11/f90ef6f2edae7f6323b9b4720dd8e434.jpg', 10001, 77, 1);
INSERT INTO `file_inf` VALUES (96, 10001, 'mwy123', '2019-09-11 23:07:13', '127.0.0.1', '视频测试.mp4', 9635, '2', '../cloudUpload/2019-09-11/04f95a3f9bceb9ee9371fa51cc56b684.mp4', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (99, 10001, 'mwy123', '2019-09-12 13:39:42', '127.0.0.1', '牵丝戏.mp3', 9350, '4', '../cloudUpload/2019-09-12/57a8d26df367b459ef6a52b2eb0894ed.mp3', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (101, 10001, 'mwy123', '2019-09-11 23:07:12', '127.0.0.1', '山林雪景.jpg', 43, '1', '../cloudUpload/2019-09-11/0d35bff65118f08f9c0ac4c3eada7712.jpg', 10001, 83, 1);
INSERT INTO `file_inf` VALUES (102, 10001, 'mwy123', '2019-09-11 23:07:12', '127.0.0.1', '公园.jpg', 54, '1', '../cloudUpload/2019-09-11/f90ef6f2edae7f6323b9b4720dd8e434.jpg', 10001, 83, 1);
INSERT INTO `file_inf` VALUES (103, 10001, 'mwy123', '2019-09-12 14:52:55', '127.0.0.1', '06-联系我们.mp4', 193224, '2', '../cloudUpload/2019-09-12/02567b580f461db2de13895bb01dd616.mp4', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (104, 10001, 'mwy123', '2019-09-12 14:52:58', '127.0.0.1', '1565885489517.jpg', 53, '1', '../cloudUpload/2019-09-12/4040db5278e7f88e07992572413c2333.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (105, 10001, 'mwy123', '2019-09-12 14:52:58', '127.0.0.1', '1565885489518.jpg', 45, '1', '../cloudUpload/2019-09-12/9e337df8b75b5096c52798cfd5d7830e.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (106, 10001, 'mwy123', '2019-09-12 14:52:58', '127.0.0.1', '1565885489520.jpg', 45, '1', '../cloudUpload/2019-09-12/9e337df8b75b5096c52798cfd5d7830e.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (107, 10001, 'mwy123', '2019-09-12 14:52:58', '127.0.0.1', '1565892190975.jpg', 36, '1', '../cloudUpload/2019-09-12/373985015981386b0bdb4ef731edaf58.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (108, 10001, 'mwy123', '2019-09-12 14:52:58', '127.0.0.1', '1565892190980.jpg', 67, '1', '../cloudUpload/2019-09-12/e54a87c4bf9c0d16084fd1fd2394f0b6.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (109, 10001, 'mwy123', '2019-09-12 14:52:58', '127.0.0.1', '1565892190982.jpg', 61, '1', '../cloudUpload/2019-09-12/a153f72343425077271ad8b77845ed3f.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (110, 10001, 'mwy123', '2019-09-12 14:53:00', '127.0.0.1', '2016级UI设计期末考试素材（A卷）.zip', 30176, '6', '../cloudUpload/2019-09-12/f7d29b6ce8eb11418e6eb542c5d753a0.zip', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (111, 10001, 'mwy123', '2019-09-11 23:07:13', '127.0.0.1', '20190912_145425_视频测试.mp4', 9635, '2', '../cloudUpload/2019-09-11/04f95a3f9bceb9ee9371fa51cc56b684.mp4', 10001, 77, 1);
INSERT INTO `file_inf` VALUES (112, 10001, 'mwy123', '2019-09-12 15:07:59', '127.0.0.1', '1565917874000.jpg', 24, '1', '../cloudUpload/2019-09-12/c47a138c29e894c2e680eb35ec7fd9a0.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (113, 10001, 'mwy123', '2019-09-12 15:12:34', '127.0.0.1', '1565885489517.jpg', 53, '1', '../cloudUpload/2019-09-12/4040db5278e7f88e07992572413c2333.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (114, 10001, 'mwy123', '2019-09-12 15:12:34', '127.0.0.1', '1565885489518.jpg', 45, '1', '../cloudUpload/2019-09-12/9e337df8b75b5096c52798cfd5d7830e.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (115, 10001, 'mwy123', '2019-09-12 15:12:35', '127.0.0.1', '1565892190975.jpg', 36, '1', '../cloudUpload/2019-09-12/373985015981386b0bdb4ef731edaf58.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (116, 10001, 'mwy123', '2019-09-12 15:16:49', '127.0.0.1', '1.txt', 0, '3', '../cloudUpload/2019-09-12/01af7d36c2832908fd4c92661f041af2.txt', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (117, 10001, 'mwy123', '2019-09-12 15:24:20', '127.0.0.1', '1565885489517.jpg', 53, '1', '../cloudUpload/2019-09-12/4040db5278e7f88e07992572413c2333.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (118, 10001, 'mwy123', '2019-09-12 15:24:20', '127.0.0.1', '1565885489518.jpg', 45, '1', '../cloudUpload/2019-09-12/9e337df8b75b5096c52798cfd5d7830e.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (119, 10001, 'mwy123', '2019-09-12 15:24:20', '127.0.0.1', '1565892190975.jpg', 36, '1', '../cloudUpload/2019-09-12/373985015981386b0bdb4ef731edaf58.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (120, 10001, 'mwy123', '2019-09-12 15:24:21', '127.0.0.1', '1565892190980.jpg', 67, '1', '../cloudUpload/2019-09-12/e54a87c4bf9c0d16084fd1fd2394f0b6.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (121, 10001, 'mwy123', '2019-09-12 15:24:21', '127.0.0.1', '1565892190982.jpg', 61, '1', '../cloudUpload/2019-09-12/a153f72343425077271ad8b77845ed3f.jpg', 10001, 0, 1);
INSERT INTO `file_inf` VALUES (122, 10001, 'mwy123', '2019-09-12 15:24:21', '127.0.0.1', '2016级UI设计期末考试素材（A卷）.zip', 30176, '6', '../cloudUpload/2019-09-12/f7d29b6ce8eb11418e6eb542c5d753a0.zip', 10001, 0, 1);

-- ----------------------------
-- Table structure for person_inf
-- ----------------------------
DROP TABLE IF EXISTS `person_inf`;
CREATE TABLE `person_inf`  (
  `person_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '个人信息表标识',
  `real_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人头像存放路径',
  `create_datetime` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间（修改时间）',
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int(2) NULL DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`person_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10006 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person_inf
-- ----------------------------
INSERT INTO `person_inf` VALUES (1, '韩东亲', '3464584902@qq.com', '15274436461', 'java', '../HeadImg/头像2.jpg', '2019-09-11 22:46:08', '男', 18);
INSERT INTO `person_inf` VALUES (8, NULL, NULL, NULL, NULL, 'web/images/defaultImg.jpg', '2019-09-10 16:53:37', '男', 56);
INSERT INTO `person_inf` VALUES (9, NULL, '1713789599@qq.com', '15274452830', '', 'web/images/defaultImg.jpg', '2019-09-12 14:30:59', '男', 18);
INSERT INTO `person_inf` VALUES (10, NULL, NULL, NULL, NULL, 'web/images/defaultImg.jpg', '2019-09-10 16:53:32', '男', 2);
INSERT INTO `person_inf` VALUES (11, 'hhh', '171378966@qq.com', '17774395604', 'RNG牛逼', '../HeadImg/摄图网_500687299.jpg', '2019-09-06 19:28:03', '女', 26);
INSERT INTO `person_inf` VALUES (102, 'mwy', '10422109861@qq.com', '15211111111', 'Java工程师', '../HeadImg/头像2.jpg', '2019-09-12 13:07:03', '女', 23);
INSERT INTO `person_inf` VALUES (104, 'hdq', '234564561@qq.com', '15211111111', 'java', '../HeadImg/头像2.jpg', '2019-09-12 14:49:14', '男', 23);
INSERT INTO `person_inf` VALUES (10001, 'ewqeqw', '1042210986@qq.com', '13322222222', '3213', '../HeadImg/1565445998074.jpg', '2019-09-11 22:45:01', '女', 23);
INSERT INTO `person_inf` VALUES (10002, NULL, '10422109861@qq.com', '15212444444', 'java', 'web/images/defaultImg.jpg', NULL, '男', 23);
INSERT INTO `person_inf` VALUES (10003, NULL, '1042210986@qq.com', '15212444444', '123', 'web/images/defaultImg.jpg', NULL, '男', 123);
INSERT INTO `person_inf` VALUES (10004, NULL, NULL, NULL, NULL, 'web/images/defaultImg.jpg', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for share_inf
-- ----------------------------
DROP TABLE IF EXISTS `share_inf`;
CREATE TABLE `share_inf`  (
  `share_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件分享表标识',
  `share_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分享文件对外地址',
  `share_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分享文件名称',
  `create_datetime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `valid_date` int(1) NOT NULL COMMENT '有效期 1:1天 2:7天 3:永久',
  `file_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件的idList',
  `directory_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件夹的idList',
  `user_id` int(11) NOT NULL COMMENT '分享人ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分享人名称',
  `person_id` int(11) NOT NULL COMMENT '个人信息ID',
  `share_status` int(1) NOT NULL COMMENT '文件分享类型 1公开 2加密',
  `share_command` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密文件提取码',
  PRIMARY KEY (`share_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of share_inf
-- ----------------------------
INSERT INTO `share_inf` VALUES (13, 'http://127.0.0.1:8080/cloudStorage/viewShare.action?url=13pbiH9wnQd', '图片等2个文件', '2019-09-12 10:21:16', 2, '7', '20', 9, 'yyyyyy', 9, 2, 'b88g');
INSERT INTO `share_inf` VALUES (17, 'http://127.0.0.1:8080/cloudStorage/viewShare.action?url=17KyDoo7LPn', '我的等3个文件', '2019-09-12 14:56:00', 2, '96,99', '95', 10001, 'mwy123', 10001, 1, NULL);
INSERT INTO `share_inf` VALUES (18, 'http://127.0.0.1:8080/cloudStorage/viewShare.action?url=18UULYWqkGJ', '我的等2个文件', '2019-09-12 14:56:40', 2, '99', '95', 10001, 'mwy123', 10001, 2, 'Mcsf');

-- ----------------------------
-- Table structure for user_inf
-- ----------------------------
DROP TABLE IF EXISTS `user_inf`;
CREATE TABLE `user_inf`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户表标识',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `user_password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `used_size` int(11) NOT NULL DEFAULT 0 COMMENT '已用空间大小 单位KB，不足1KB按1KB计算',
  `total_size` int(11) NOT NULL DEFAULT 524288000 COMMENT '总空间大小 单位KB，不足1KB按1KB计算 普通会员500GB，会员1TB，超级会员1.5TB',
  `create_datetime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `latest_login_datetime` timestamp(0) NULL DEFAULT NULL COMMENT '最后一次登录时间',
  `latest_login_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最后一次登录IP',
  `person_id` int(11) NULL DEFAULT NULL COMMENT '个人信息表ID',
  `user_status` int(1) NOT NULL COMMENT '状态 0未激活 1正常 2禁用 3删除',
  `member_order` int(1) NOT NULL COMMENT '会员等级 1普通用户 2会员 3超级会员',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `person_id`(`person_id`) USING BTREE,
  CONSTRAINT `person_id` FOREIGN KEY (`person_id`) REFERENCES `person_inf` (`person_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_inf
-- ----------------------------
INSERT INTO `user_inf` VALUES (1, 'hdq123', '123456', 819200, 1610612736, '2019-09-06 07:27:33', '2019-09-11 10:46:55', '192.168.21.222', 1, 1, 3);
INSERT INTO `user_inf` VALUES (9, 'yyyyyy123', '111111', 0, 524288000, '2019-08-29 10:17:06', '2019-09-12 11:08:33', '192.168.21.98', 9, 1, 1);
INSERT INTO `user_inf` VALUES (10, 'lslstyy', '111111', 0, 524288000, '2019-08-29 10:19:11', '2019-08-30 11:02:42', '192.168.21.180', 10, 3, 1);
INSERT INTO `user_inf` VALUES (11, 'longsen', '111111', 0, 524288000, '2019-08-29 10:22:36', '2019-09-02 07:03:21', '192.168.21.180', 11, 3, 1);
INSERT INTO `user_inf` VALUES (102, 'mwy100', '123456', 0, 1610612736, '2019-09-12 01:04:30', '2019-09-12 01:04:52', '192.168.21.167', 102, 0, 3);
INSERT INTO `user_inf` VALUES (103, 'hdq100', '123456', 0, 524288000, '2019-09-12 14:30:04', NULL, NULL, 10002, 1, 1);
INSERT INTO `user_inf` VALUES (104, 'mwy124', '123456', 0, 1610612736, '2019-09-12 02:48:06', '2019-09-12 02:48:26', '192.168.21.167', 104, 1, 3);
INSERT INTO `user_inf` VALUES (105, '好多钱23', '123456', 0, 524288000, '2019-09-12 15:02:14', NULL, NULL, 10003, 1, 3);
INSERT INTO `user_inf` VALUES (107, 'longsen111', '111111', 0, 524288000, '2019-09-12 03:49:58', NULL, NULL, 10004, 0, 1);
INSERT INTO `user_inf` VALUES (10001, 'mwy123', '123456', 0, 1610612736, '2019-08-28 09:22:55', '2019-09-12 02:51:31', '192.168.21.167', 10001, 1, 3);

-- ----------------------------
-- Triggers structure for table user_inf
-- ----------------------------
DROP TRIGGER IF EXISTS `t_afterdelete_on_user`;
delimiter ;;
CREATE TRIGGER `t_afterdelete_on_user` AFTER DELETE ON `user_inf` FOR EACH ROW begin
 
delete from person_inf where person_id = old.person_id;
 
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
