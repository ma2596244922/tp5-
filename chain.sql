/*
Navicat MySQL Data Transfer

Source Server         : apche
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : chain

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-10-09 17:46:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_audit
-- ----------------------------
DROP TABLE IF EXISTS `admin_audit`;
CREATE TABLE `admin_audit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `site` varchar(255) DEFAULT NULL,
  `type_id` int(10) DEFAULT NULL,
  `judge` char(3) DEFAULT NULL,
  `state` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_audit
-- ----------------------------
INSERT INTO `admin_audit` VALUES ('33', 'call', 'http://www.baidu.com', '2', '0', '0');
INSERT INTO `admin_audit` VALUES ('34', '23', 'https://www.baidu.com/', '1', '1', '0');
INSERT INTO `admin_audit` VALUES ('35', '231', 'http://789', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('36', 'fyull', 'http://www.baidu.com', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('37', '百度', 'http://www.baidu.com', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('38', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('39', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('40', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('41', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('42', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('43', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('44', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('45', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('46', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('47', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('48', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('49', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('50', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('51', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('52', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('53', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('54', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('55', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '1');
INSERT INTO `admin_audit` VALUES ('56', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '1');
INSERT INTO `admin_audit` VALUES ('57', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '1');
INSERT INTO `admin_audit` VALUES ('58', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '1');
INSERT INTO `admin_audit` VALUES ('59', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '1', '0', '1');
INSERT INTO `admin_audit` VALUES ('60', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '4', '0', '1');
INSERT INTO `admin_audit` VALUES ('61', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '4', '0', '1');
INSERT INTO `admin_audit` VALUES ('62', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '4', '0', '1');
INSERT INTO `admin_audit` VALUES ('63', 'full', 'http://www.w3school.com.cn/tags/att_a_target.asp', '4', '0', '1');
INSERT INTO `admin_audit` VALUES ('64', 'call', 'http://www.baidu.com', '4', '0', '1');
INSERT INTO `admin_audit` VALUES ('65', 'call', 'www.baidu.com', '4', '1', '0');
INSERT INTO `admin_audit` VALUES ('66', 'call', 'www.baidu.com', '4', '0', '0');
INSERT INTO `admin_audit` VALUES ('67', '23', 'www.baidu.com', '4', '0', '0');
INSERT INTO `admin_audit` VALUES ('68', 'call', 'http://www.baidu.com', '4', '1', '0');
INSERT INTO `admin_audit` VALUES ('69', 'call', 'http://www.baidu.com', '4', '0', '0');
INSERT INTO `admin_audit` VALUES ('71', 'call', 'www.baidu.com', '1', '0', '0');
INSERT INTO `admin_audit` VALUES ('73', '789', 'https://www.kancloud.cn/manual/thinkphp5/156576', '1', '0', null);
INSERT INTO `admin_audit` VALUES ('74', 'qwe', 'https://www.kancloud.cn/manual/thinkphp5/156576', '4', '0', null);

-- ----------------------------
-- Table structure for admin_login
-- ----------------------------
DROP TABLE IF EXISTS `admin_login`;
CREATE TABLE `admin_login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` char(25) DEFAULT NULL,
  `password` char(32) DEFAULT NULL,
  `permissions` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_login
-- ----------------------------
INSERT INTO `admin_login` VALUES ('1', 'admin', '202cb962ac59075b964b07152d234b70', '1');

-- ----------------------------
-- Table structure for admin_type
-- ----------------------------
DROP TABLE IF EXISTS `admin_type`;
CREATE TABLE `admin_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `state` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_type
-- ----------------------------
INSERT INTO `admin_type` VALUES ('1', '123', '0');
INSERT INTO `admin_type` VALUES ('4', '45', '1');
