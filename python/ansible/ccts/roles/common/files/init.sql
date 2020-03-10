CREATE DATABASE IF NOT EXISTS `authority_center` default charset utf8 COLLATE utf8_general_ci;

USE authority_center;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name       : dev_jmhb
password        : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/



/*
2.1 认证中心(ac)
*/

DROP TABLE IF EXISTS `ac_user`;
CREATE TABLE `ac_user` (
  `id` bigint(20)       not null auto_increment,
  `user_name` varchar(40)   not null,
  `nick_name` varchar(40),
  `email` varchar(40)     default null,
  `mobile_area_code`	varchar(10),
  `mobile` varchar(40)    default null,
  `password` char(32)     not null,
  `two_factor` char(1)    not null,
  `gtfa_token` varchar(40)  default null,
  `mutiple` char(1)     not null,
   remind char(1)     not null,
   pass_update_time datetime(6) not null,
   online_time  int     not null default 60,
  `status` char(1)      not null,
  `create_operator` bigint(20) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_operator` bigint(20) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  first_login bool NOT NULL default 1,
  user_type char(1) NOT NULL default 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.1.2  ac_user_login_log 登录日志

DROP TABLE IF EXISTS `ac_user_login_log`;
CREATE TABLE `ac_user_login_log` (
  `id` bigint(20) NOT NULL auto_increment,
  `token` char(255) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `ip_location`	varchar(40)  DEFAULT NULL,
  `auth_type` char(1) NOT NULL,
  `original` char(1) NOT NULL,
  `version` varchar(40) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `success` bool NOT NULL,
  `reason` varchar(10) DEFAULT NULL,
  `login_time` datetime(6) NOT NULL,
  `logoff_time` datetime(6) DEFAULT NULL,
  `logoff_reason` char(1) DEFAULT NULL,
  user_type char(1) NOT NULL default 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.1.3  ac_online_user 在线用户表

DROP TABLE IF EXISTS `ac_online_user`;
CREATE TABLE `ac_online_user` (
  `id` bigint(20) NOT NULL auto_increment,
  `token` char(255) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `ip_location`	varchar(40),
  `auth_type` char(1) NOT NULL,
  `original` char(1) NOT NULL,
  `multiple`	char(1) NOT NULL,
  `login_time` datetime(6) NOT NULL,
  `expire_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.1.4  ac_apps 子系统应用

DROP TABLE IF EXISTS `ac_apps`;
CREATE TABLE `ac_apps` (
  `key` char(32) NOT NULL,
  `token` char(32) NOT NULL,
  `name` varchar(40) NOT NULL,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2.1.5  ac_sys_config 系统配置

DROP TABLE IF EXISTS `ac_sys_config`;
CREATE TABLE `ac_sys_config` (
  `key` varchar(40) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


insert into ac_user (user_name, nick_name, email, mobile, password, two_factor, gtfa_token, mutiple, remind, pass_update_time, online_time, status, create_operator, create_time, version)
VALUES ('admin', null, null, null, '5eb8785e9803a708c1bd91ef09ed83a0', '0', null, '0', '0', '2019-06-05', 60, '1', null, '2019-06-06', 0);
CREATE DATABASE IF NOT EXISTS `sr` default charset utf8 COLLATE utf8_general_ci;

USE sr;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name			  : dev_jmhb
password			  : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/




/*
2.11	短信系统(sr)
*/


-- 2.11.1	sr_mail_subject  短信主题

DROP TABLE IF EXISTS `sr_mail_subject`;
CREATE TABLE `sr_mail_subject` (
	subject	varchar(32) NOT NULL,
	description	varchar(255) NOT NULL,
	variables	text NOT NULL,
	default_template	varchar(32) NOT NULL,
	PRIMARY KEY (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.11.2	sr_mail_template  短信模板

DROP TABLE IF EXISTS `sr_mail_template`;
CREATE TABLE `sr_mail_template` (
	subject	varchar(32) NOT NULL,
	lang	varchar(10) NOT NULL,
	title	varchar(512) NOT NULL,
	content	text NOT NULL,
	PRIMARY KEY (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `sr_mail_subject` VALUES ('SMS_VERIFY', '验证码', '验证', '验证码');
INSERT INTO `sr_mail_subject` VALUES ('Login', '登入通知', '登入通知', '登入通知');
INSERT INTO `sr_mail_subject` VALUES ('ForceCancel', '强撤通知', '强撤通知', '强撤通知');
INSERT INTO `sr_mail_subject` VALUES ('ForceClose', '强平通知', '强平通知', '强平通知');
INSERT INTO `sr_mail_subject` VALUES ('MarginCall', '追保通知', '追保通知', '追保通知');
INSERT INTO `sr_mail_subject` VALUES ('ForcePositionLowing', '自动减仓通知', '自动减仓通知', '自动减仓通知');
INSERT INTO `sr_mail_subject` VALUES ('DepositConfirm', '存款确认', '存款确认', '存款确认');
INSERT INTO `sr_mail_subject` VALUES ('WithdrawalsArrival', '提现完成', '提现完成', '提现完成');

INSERT INTO `sr_mail_template` VALUES ('SMS_VERIFY', 'zh', '验证码', '【CFEX】{token}，验证码5分钟内有效。请勿将此验证码泄漏给他人，以免造成不必要的损失。');

INSERT INTO `sr_mail_template` VALUES ('Login', 'zh-CN', '登入通知', '【CFEX】登入通知：您的账户在{currentDate}成功登入，如非本人操作，请及时联系客服。');
INSERT INTO `sr_mail_template` VALUES ('ForceCancel', 'zh-CN', '强撤通知', '【CFEX】强撤通知：您的账户在{currentDate}触发强撤，合约{contractId}的挂单{qty}张已被强制撤销。如有疑问，请联系客服。');
INSERT INTO `sr_mail_template` VALUES ('ForceClose', 'zh-CN', '强平通知', '【CFEX】强平通知：您的账户在{currentDate}触发强平，合约{contractId}的持仓{qty}张已被强制平仓。如有疑问，请联系客服。');
INSERT INTO `sr_mail_template` VALUES ('MarginCall', 'zh-CN', '追保通知', '【CFEX】追保通知：您的账户权益已低于初始保证金的50%，存在风险，请及时补充资金或自行平仓，以免触发强平。');
INSERT INTO `sr_mail_template` VALUES ('ForcePositionLowing', 'zh-CN', '自动减仓通知', '【CFEX】自动减仓通知：您账户下合约{contractId}的持仓已被自动减仓{qty}张，如有疑问，请联系客服。');
INSERT INTO `sr_mail_template` VALUES ('DepositConfirm', 'zh-CN', '存款确认', '【CFEX】存款确认：的账户在{currentDate}完成充币{currency} {amount}，账户余额{currency} {leftAmount}。');
INSERT INTO `sr_mail_template` VALUES ('WithdrawalsArrival', 'zh-CN', '提现完成', '【CFEX】提现完成：你的账户在{currentDate}已完成提币{currency} {amount}，账户余额{currency} {leftAmount}。');
CREATE DATABASE IF NOT EXISTS `cms` default charset utf8 COLLATE utf8_general_ci;

USE cms;
/*
Navicat MySQL Data Transfer

Source Server         : ccts-test
Source Server Version : 50726
Source Host           : 192.168.1.75:30290
Source Database       : cms

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-10-21 10:59:37
*/

SET FOREIGN_KEY_CHECKS=0;


-- ----------------------------
-- Table structure for `cms_category`
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ch_name` varchar(255) NOT NULL,
  `en_name` varchar(255) NOT NULL,
  `parent_id` int(11)  NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=713 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for `cms_article`
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_single` tinyint DEFAULT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `keyword` varchar(50) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `create_operator` bigint(20) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `update_operator` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for `cms_article_content`
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_content`;
CREATE TABLE `cms_article_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `locale` varchar(10) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT 0,
  `content` longtext,
  version	bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cms_article_content` FOREIGN KEY (`article_id`) REFERENCES `cms_article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;


/*
Navicat MySQL Data Transfer

Source Server         : ccts-test
Source Server Version : 50726
Source Host           : 192.168.1.75:30290
Source Database       : cms

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-10-21 10:59:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cms_article`
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `keyword` varchar(50) DEFAULT NULL,
  `create_operator` bigint(20) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `update_operator` bigint(20) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `is_single` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_article
-- ----------------------------
INSERT INTO `cms_article` VALUES ('1', '1', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('2', '1', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('3', '1', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('4', '1', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('11', '211', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('12', '211', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('13', '211', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('14', '211', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('21', '221', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('22', '221', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('23', '221', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('24', '221', 'tab', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('31', '3', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('32', '3', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('33', '3', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('40', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('41', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('42', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('43', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('44', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('45', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('46', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('47', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('48', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('49', '4', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('51', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('52', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('53', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('54', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('55', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('56', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('57', '5', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('61', '6', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('62', '6', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('71', '71', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('72', '71', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('81', '72', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('82', '72', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('83', '72', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('84', '72', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('91', '73', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('92', '73', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('93', '73', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('94', '73', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('101', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('102', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('103', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('104', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('105', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('106', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('107', '74', 'single', null, null, null, null, null);
INSERT INTO `cms_article` VALUES ('108', '74', 'single', null, null, null, null, null);


-- ----------------------------
-- Table structure for `cms_article_content`
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_content`;
CREATE TABLE `cms_article_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `locale` varchar(10) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` longtext NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_article_content
-- ----------------------------
-- 产品
-- 概览
INSERT INTO `cms_article_content` VALUES ('1', '1', 'zh-CN', '概览', '', 0);
INSERT INTO `cms_article_content` VALUES ('2', '1', 'en-US', 'Overview', '', 0);
-- 日续合约
INSERT INTO `cms_article_content` VALUES ('3', '2', 'zh-CN', '日续合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('4', '2', 'en-US', 'Daily Futures', '', 0);
-- SFD合约
INSERT INTO `cms_article_content` VALUES ('5', '3', 'zh-CN', 'SFD合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('6', '3', 'en-US', 'SFD Contract', '', 0);
-- 定期合约
INSERT INTO `cms_article_content` VALUES ('7', '4', 'zh-CN', '定期合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('8', '4', 'en-US', 'Futures', '', 0);

--  合约详情 -- > BTC结算市场 -- > BTC/USD
-- 现货标的
INSERT INTO `cms_article_content` VALUES ('11', '11', 'zh-CN', '现货标的', '', 0);
INSERT INTO `cms_article_content` VALUES ('12', '11', 'en-US', 'Underlyings', '', 0);
-- 日续合约
INSERT INTO `cms_article_content` VALUES ('13', '12', 'zh-CN', '日续合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('14', '12', 'en-US', 'Daily Futures', '', 0);
-- SFD合约
INSERT INTO `cms_article_content` VALUES ('15', '13', 'zh-CN', 'SFD合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('16', '13', 'en-US', 'SFD Contract', '', 0);
-- 定期合约
INSERT INTO `cms_article_content` VALUES ('17', '14', 'zh-CN', '定期合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('18', '14', 'en-US', 'Futures Contract', '', 0);

--  合约详情 -- > ETH结算市场 -- > ETH/USD
-- 现货标的
INSERT INTO `cms_article_content` VALUES ('21', '21', 'zh-CN', '现货标的', '', 0);
INSERT INTO `cms_article_content` VALUES ('22', '21', 'en-US', 'Underlyings', '', 0);
-- 日续合约
INSERT INTO `cms_article_content` VALUES ('23', '22', 'zh-CN', '日续合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('24', '22', 'en-US', 'Daily Futures', '', 0);
-- SFD合约
INSERT INTO `cms_article_content` VALUES ('25', '23', 'zh-CN', 'SFD合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('26', '23', 'en-US', 'SFD Contract', '', 0);
-- 定期合约
INSERT INTO `cms_article_content` VALUES ('27', '24', 'zh-CN', '定期合约', '', 0);
INSERT INTO `cms_article_content` VALUES ('28', '24', 'en-US', 'Futures Contract', '', 0);


-- 概览
-- 入门
INSERT INTO `cms_article_content` VALUES ('31', '31', 'zh-CN', '入门', '', 0);
INSERT INTO `cms_article_content` VALUES ('32', '31', 'en-US', 'QuickStart', '', 0);
-- 常见问题
INSERT INTO `cms_article_content` VALUES ('33', '32', 'zh-CN', '常见问题（FAQ）', '', 0);
INSERT INTO `cms_article_content` VALUES ('34', '32', 'en-US', 'FAQs', '', 0);
-- 术语表
INSERT INTO `cms_article_content` VALUES ('35', '33', 'zh-CN', '术语表（Glossary）', '', 0);
INSERT INTO `cms_article_content` VALUES ('36', '33', 'en-US', 'Glossary', '', 0);

-- 交易与结算
-- 保证金交易
INSERT INTO `cms_article_content` VALUES ('41', '41', 'zh-CN', '保证金交易', '', 0);
INSERT INTO `cms_article_content` VALUES ('42', '41', 'en-US', 'Margin Trading', '', 0);
-- 委托类型
INSERT INTO `cms_article_content` VALUES ('43', '42', 'zh-CN', '委托类型', '', 0);
INSERT INTO `cms_article_content` VALUES ('44', '42', 'en-US', 'Order Type', '', 0);
-- 撮合算法
INSERT INTO `cms_article_content` VALUES ('45', '43', 'zh-CN', '撮合算法', '', 0);
INSERT INTO `cms_article_content` VALUES ('46', '43', 'en-US', 'Matching Algorithm', '', 0);
-- 下单模式
INSERT INTO `cms_article_content` VALUES ('47', '44', 'zh-CN', '下单模式', '', 0);
INSERT INTO `cms_article_content` VALUES ('48', '44', 'en-US', 'Order Placing Pattern', '', 0);
-- 价格保护带
INSERT INTO `cms_article_content` VALUES ('49', '45', 'zh-CN', '价格保护带', '', 0);
INSERT INTO `cms_article_content` VALUES ('50', '45', 'en-US', 'Price Band', '', 0);
-- 每日结算
INSERT INTO `cms_article_content` VALUES ('51', '46', 'zh-CN', '每日结算', '', 0);
INSERT INTO `cms_article_content` VALUES ('52', '46', 'en-US', 'Daily Settlement', '', 0);
-- 到期结算
INSERT INTO `cms_article_content` VALUES ('53', '47', 'zh-CN', '到期结算', '', 0);
INSERT INTO `cms_article_content` VALUES ('54', '47', 'en-US', 'Final Settlement', '', 0);
-- 盈亏计算
INSERT INTO `cms_article_content` VALUES ('55', '48', 'zh-CN', '盈亏计算', '', 0);
INSERT INTO `cms_article_content` VALUES ('56', '48', 'en-US', 'Profit & Loss', '', 0);
-- （组合订单）
INSERT INTO `cms_article_content` VALUES ('57', '49', 'zh-CN', '（组合订单）', '', 0);
INSERT INTO `cms_article_content` VALUES ('58', '49', 'en-US', '(Combination Orders)', '', 0);
-- （期权交易）
INSERT INTO `cms_article_content` VALUES ('59', '40', 'zh-CN', '（期权交易）', '', 0);
INSERT INTO `cms_article_content` VALUES ('60', '40', 'en-US', '(Option Trading)', '', 0);

-- 风控
-- 实时盯市
INSERT INTO `cms_article_content` VALUES ('61', '51', 'zh-CN', '实时盯市', '', 0);
INSERT INTO `cms_article_content` VALUES ('62', '51', 'en-US', 'Real-Time MTM', '', 0);
-- 标记价格
INSERT INTO `cms_article_content` VALUES ('63', '52', 'zh-CN', '标记价格', '', 0);
INSERT INTO `cms_article_content` VALUES ('64', '52', 'en-US', 'Mark Price', '', 0);
-- 强制平仓
INSERT INTO `cms_article_content` VALUES ('65', '53', 'zh-CN', '强制平仓', '', 0);
INSERT INTO `cms_article_content` VALUES ('66', '53', 'en-US', 'Liquidation', '', 0);
-- 自动减仓
INSERT INTO `cms_article_content` VALUES ('67', '54', 'zh-CN', '自动减仓', '', 0);
INSERT INTO `cms_article_content` VALUES ('68', '54', 'en-US', 'Auto-Deleveraging', '', 0);
-- 熔断
INSERT INTO `cms_article_content` VALUES ('69', '55', 'zh-CN', '熔断', '', 0);
INSERT INTO `cms_article_content` VALUES ('70', '55', 'en-US', 'Circuit Breaker', '', 0);
-- 持仓限制
INSERT INTO `cms_article_content` VALUES ('71', '56', 'zh-CN', '持仓限制', '', 0);
INSERT INTO `cms_article_content` VALUES ('72', '56', 'en-US', 'Position Limit', '', 0);
-- 清算基金
INSERT INTO `cms_article_content` VALUES ('73', '57', 'zh-CN', '清算基金', '', 0);
INSERT INTO `cms_article_content` VALUES ('74', '57', 'en-US', 'Clearing Fund', '', 0);

-- 规则与费用
-- 规则
INSERT INTO `cms_article_content` VALUES ('75', '61', 'zh-CN', '规则', '', 0);
INSERT INTO `cms_article_content` VALUES ('76', '61', 'en-US', 'Trading Rules', '', 0);
-- 费用
INSERT INTO `cms_article_content` VALUES ('77', '62', 'zh-CN', '费用', '', 0);
INSERT INTO `cms_article_content` VALUES ('78', '62', 'en-US', 'Fees', '', 0);

--  技术 
-- APP
INSERT INTO `cms_article_content` VALUES ('83', '81', 'zh-CN', 'APP', '', 0);
INSERT INTO `cms_article_content` VALUES ('84', '81', 'en-US', 'APP', '', 0);
-- API
INSERT INTO `cms_article_content` VALUES ('85', '82', 'zh-CN', 'API', '', 0);
INSERT INTO `cms_article_content` VALUES ('86', '82', 'en-US', 'API', '', 0);
-- 安全性
INSERT INTO `cms_article_content` VALUES ('87', '83', 'zh-CN', '安全性', '', 0);
INSERT INTO `cms_article_content` VALUES ('88', '83', 'en-US', 'Security', '', 0);
-- 漏洞悬赏
INSERT INTO `cms_article_content` VALUES ('89', '84', 'zh-CN', '漏洞悬赏', '', 0);
INSERT INTO `cms_article_content` VALUES ('90', '84', 'en-US', 'Bug Bounty', '', 0);

-- 推广 
-- 模拟交易
INSERT INTO `cms_article_content` VALUES ('91', '91', 'zh-CN', '模拟交易', '', 0);
INSERT INTO `cms_article_content` VALUES ('92', '91', 'en-US', 'Mock Trading', '', 0);
-- 推荐人计划
INSERT INTO `cms_article_content` VALUES ('93', '92', 'zh-CN', '推荐人计划', '', 0);
INSERT INTO `cms_article_content` VALUES ('94', '92', 'en-US', 'Referral Program', '', 0);
-- 做市商计划
INSERT INTO `cms_article_content` VALUES ('95', '93', 'zh-CN', '做市商计划', '', 0);
INSERT INTO `cms_article_content` VALUES ('96', '93', 'en-US', 'Market Maker', '', 0);
-- 行业资讯
INSERT INTO `cms_article_content` VALUES ('97', '94', 'zh-CN', '行业资讯', '', 0);
INSERT INTO `cms_article_content` VALUES ('98', '94', 'en-US', 'Industrial News', '', 0);

-- 关于Coinfurex 
-- 公司简介
INSERT INTO `cms_article_content` VALUES ('101', '101', 'zh-CN', '公司简介', '', 0);
INSERT INTO `cms_article_content` VALUES ('102', '101', 'en-US', 'Profile', '', 0);
-- 服务条款
INSERT INTO `cms_article_content` VALUES ('103', '102', 'zh-CN', '服务条款', '', 0);
INSERT INTO `cms_article_content` VALUES ('104', '102', 'en-US', 'Terms of Service', '', 0);
-- 隐私保护
INSERT INTO `cms_article_content` VALUES ('105', '103', 'zh-CN', '隐私保护', '', 0);
INSERT INTO `cms_article_content` VALUES ('106', '103', 'en-US', 'Privacy Policy', '', 0);
-- 免责声明
INSERT INTO `cms_article_content` VALUES ('107', '104', 'zh-CN', '免责声明', '', 0);
INSERT INTO `cms_article_content` VALUES ('108', '104', 'en-US', 'Disclaimer', '', 0);
-- Cookie策略
INSERT INTO `cms_article_content` VALUES ('109', '105', 'zh-CN', 'Cookie策略', '', 0);
INSERT INTO `cms_article_content` VALUES ('110', '105', 'en-US', 'Cookie Policy', '', 0);
-- 工作机会
INSERT INTO `cms_article_content` VALUES ('111', '106', 'zh-CN', '工作机会', '', 0);
INSERT INTO `cms_article_content` VALUES ('112', '106', 'en-US', 'Career Opportunity', '', 0);
-- 联系我们
INSERT INTO `cms_article_content` VALUES ('113', '107', 'zh-CN', '联系我们', '', 0);
INSERT INTO `cms_article_content` VALUES ('114', '107', 'en-US', 'Contact us', '', 0);
-- 社交媒体
INSERT INTO `cms_article_content` VALUES ('115', '108', 'zh-CN', '社交媒体', '', 0);
INSERT INTO `cms_article_content` VALUES ('116', '108', 'en-US', 'Social Media', '', 0);


-- ----------------------------
-- Table structure for `cms_category`
-- ----------------------------
DROP TABLE IF EXISTS `cms_category`;
CREATE TABLE `cms_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zh_name` varchar(100) DEFAULT NULL,
  `en_name` varchar(100) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=713 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cms_category
-- ----------------------------
INSERT INTO `cms_category` VALUES ('1', '产品', 'Product', null);
INSERT INTO `cms_category` VALUES ('2', '合约详情', 'Contract Specifications', null);
INSERT INTO `cms_category` VALUES ('3', '概览', 'Overview', null);
INSERT INTO `cms_category` VALUES ('4', '交易与结算', 'Trading and Settlement', null);
INSERT INTO `cms_category` VALUES ('5', '风控', 'Risk Management', null);
INSERT INTO `cms_category` VALUES ('6', '规则与费用', 'Trading Rules & Fees', null);
INSERT INTO `cms_category` VALUES ('7', '支持', 'Support', null);
INSERT INTO `cms_category` VALUES ('21', 'BTC结算市场', 'BTC Settlement Market', '2');
INSERT INTO `cms_category` VALUES ('22', 'ETH结算市场', 'ETH Settlement Market', '2');
INSERT INTO `cms_category` VALUES ('71', '新闻与公告', 'News and Annoucements', '7');
INSERT INTO `cms_category` VALUES ('72', '技术', 'IT', '7');
INSERT INTO `cms_category` VALUES ('73', '推广', 'Promotion', '7');
INSERT INTO `cms_category` VALUES ('74', '关于Coinfurex', 'About CFEX', '7');
INSERT INTO `cms_category` VALUES ('211', 'BTC/USD', 'BTC/USD', '21');
INSERT INTO `cms_category` VALUES ('221', 'ETH/USD', 'ETH/USD', '22');
INSERT INTO `cms_category` VALUES ('711', '公告', 'Notice', '71');
INSERT INTO `cms_category` VALUES ('712', '新闻', 'Annoucements', '71');
CREATE DATABASE IF NOT EXISTS `assets_center` default charset utf8 COLLATE utf8_general_ci;

USE assets_center;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name       : dev_jmhb
password        : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/



/*
2.5 资产中心(as)
*/

-- 2.5.1  as_currency 币种

DROP TABLE IF EXISTS `as_currency`;
CREATE TABLE `as_currency` (
  currency  varchar(10) NOT NULL,
  name  varchar(20) DEFAULT NULL,
  unit  varchar(10) DEFAULT NULL,
  `limit` bigint NOT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.5.2  as_exchange_rate 汇率表

DROP TABLE IF EXISTS `as_exchange_rate`;
CREATE TABLE `as_exchange_rate` (
  currency  varchar(10) NOT NULL,
  exchange_currency varchar(10) NOT NULL,
  name  varchar(20) NOT NULL,
  unit  varchar(10) NOT NULL,
  exchange_rate decimal(30,13) NOT NULL,
  PRIMARY KEY (`currency`),
  CONSTRAINT `fk_as_exchange_rate` FOREIGN KEY (`exchange_currency`) REFERENCES `as_exchange_rate` (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.5.3  as_account 资金账户

DROP TABLE IF EXISTS `as_account`;
CREATE TABLE `as_account` (
  account_id  varchar(32) NOT NULL,
  customer_id varchar(20) NOT NULL,
  user_id bigint DEFAULT NULL,
  password  char(32)   DEFAULT NULL,
  pass_update_time  datetime DEFAULT NULL,
  withdrawalable  bool NOT NULL,
  is_master bool NOT NULL,
  parent_id varchar(32) DEFAULT NULL,
  can_login char(1) NOT NULL default '0',
  sub_account_limit int NOT NULL default '0',
  order_type  char(1) NOT NULL,
  status  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`account_id`),
  CONSTRAINT uk_as_account unique (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.4  as_account_asset 币种账户资金

DROP TABLE IF EXISTS `as_account_asset`;
CREATE TABLE `as_account_asset` (
  id  bigint NOT NULL auto_increment,
  account_id  varchar(32) NOT NULL,
  currency  varchar(10) NOT NULL,
  deposit_wallet  varchar(128) DEFAULT NULL,
  wallet_balance  decimal(30,13) NOT NULL default 0,
  available_balance decimal(30,13) NOT NULL default 0,
  position_margin decimal(30,13) NOT NULL default 0,
  order_margin  decimal(30,13) NOT NULL default 0,
  frz_withdrawal  decimal(30,13) NOT NULL default 0,
  position_premium  decimal(30,13) NOT NULL default 0,
  order_premium decimal(30,13) NOT NULL default 0,
  settled_balance decimal(30,13) NOT NULL DEFAULT 0,
  created_time  datetime(6) NOT NULL,
  status  char(1) NOT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_account_asset` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.7  as_wallet_record 充币钱包地址记录表

DROP TABLE IF EXISTS `as_wallet_record`;
CREATE TABLE `as_wallet_record` (
  id  bigint NOT NULL auto_increment,
  asset_id  bigint NOT NULL,
  account_id  varchar(32) NOT NULL,
  currency  varchar(10) NOT NULL,
  wallet  varchar(128) NOT NULL,
  wallet_key  varchar(128) DEFAULT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_wallet_record_cur` FOREIGN KEY (`asset_id`) REFERENCES `as_account_asset` (`id`),
  CONSTRAINT `fk_as_wallet_record_account` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.5.5 	as_account_setting  资金帐户设置

DROP TABLE IF EXISTS `as_account_setting`;
CREATE TABLE `as_account_setting` (
  id	bigint NOT NULL auto_increment,
  account_id	varchar(32) NOT NULL,
  type	char(1) NOT NULL,
  setting_key	varchar(32) NOT NULL,
  setting_value	varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_account_setting` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.6	as_account_notify 资金账户通知

DROP TABLE IF EXISTS `as_account_notify`;
CREATE TABLE `as_account_notify` (
  id	bigint NOT NULL auto_increment,
  account_id	varchar(32) NOT NULL,
  action	varchar(32) NOT NULL,
  content	text NOT NULL,
  is_read	tinyint(1) NOT NULL,
  create_time	Timestamp(6) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_account_notify` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.5.8  as_withdrawal_wallet 提款钱包地址

DROP TABLE IF EXISTS `as_withdrawal_wallet`;
CREATE TABLE `as_withdrawal_wallet` (
  id  bigint NOT NULL auto_increment,
  account_id  varchar(32) NOT NULL,
  currency  varchar(10) NOT NULL,
  withdrawal_wallet varchar(128) DEFAULT NULL,
  remark  varchar(255)  DEFAULT NULL,
  type  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_withdrawal_wallet` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.9  as_deposit_record 入金记录

DROP TABLE IF EXISTS `as_deposit_record`;
CREATE TABLE `as_deposit_record` (
  id  bigint NOT NULL auto_increment,
  account_id  varchar(32) NOT NULL,
  asset_id  bigint NOT NULL,
  currency  varchar(10) NOT NULL,
  amount  decimal(30,13) NOT NULL,
  wallet  varchar(128) DEFAULT NULL,
  wallet_from varchar(128) DEFAULT NULL,
  `type`  char(1) NOT NULL,
  status  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  invault_txn_time	varchar(20),
  invault_txn_id	varchar(70),
  invault_confirms	int,
  remark	varchar(255),
  version bigint NOT NULL,
  withdrawals_id  bigint  DEFAULT NULL,
  trade_id	varchar(64),
  sweep_flag	char(1),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_deposit_record` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.10  as_withdrawals_record 出金记录

DROP TABLE IF EXISTS `as_withdrawals_record`;
CREATE TABLE `as_withdrawals_record` (
  id  bigint NOT NULL auto_increment,
  account_id  varchar(32) NOT NULL,
  asset_id  bigint NOT NULL,
  currency  varchar(10) NOT NULL,
  amount  decimal(30,13) NOT NULL,
  wallet  varchar(128) DEFAULT NULL,
  wallet_market varchar(128) DEFAULT NULL,
  fee decimal(30,13) NOT NULL,
  trans_rate  varchar(20),
  `type`  char(1) NOT NULL,
  status  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  invault_trans_rate	varchar(20),
  invault_fee_mode	varchar(20),
  invault_txn_id	varchar(70),
  invault_confirms	int,
  invault_fee	decimal(30,13),
  invault_txn_time	varchar(20),
  remark	varchar(255),
  version bigint NOT NULL,
  trade_id	varchar(64),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_withdrawals_record` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.5.11  as_transfer_record 划转记录

DROP TABLE IF EXISTS `as_transfer_record`;
CREATE TABLE `as_transfer_record` (
  id  bigint NOT NULL auto_increment,
  payaccount_id varchar(32) NOT NULL,
  payasset_id bigint NOT NULL,
  recvaccount_id  varchar(32) NOT NULL,
  recvasset_id  bigint NOT NULL,
  currency  varchar(10) NOT NULL,
  amount  decimal(30,13) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_transfer_record_payaccount_id` FOREIGN KEY (`payaccount_id`) REFERENCES `as_account` (`account_id`),
  CONSTRAINT `fk_as_transfer_record_recvaccount_id` FOREIGN KEY (`recvaccount_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.5.12 as_running_account 流水账单

DROP TABLE IF EXISTS `as_running_account`;
CREATE TABLE `as_running_account` (
  id  bigint NOT NULL auto_increment,
  account_id  varchar(32) NOT NULL,
  asset_id  bigint NOT NULL,
  currency  varchar(10) NOT NULL,
  `type`  char(1) NOT NULL,
  amount  decimal(30,13) NOT NULL,
  wallet_balance  decimal(30,13) NOT NULL,
  create_time datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_as_running_account` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.13	as_account_api_key   资金账户密钥

DROP TABLE IF EXISTS `as_account_api_key`;
CREATE TABLE `as_account_api_key` (
	id	bigint NOT NULL auto_increment,
	account_id	varchar(32) NOT NULL,
	api_key	varchar(80) NOT NULL,
	api_secret	varchar(200) NOT NULL,
	ip_limit	varchar(100),
	permission	varchar(80) NOT NULL,
	frequency	int NOT NULL,
	remark	varchar(500),
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_as_account_api_key` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.14	as_fee_sweep_config 提币矿工费归集触发额配置表

DROP TABLE IF EXISTS `as_fee_sweep_config`;
CREATE TABLE `as_fee_sweep_config` (
	id	bigint NOT NULL auto_increment,
	currency	varchar(10) NOT NULL,
	fee_normal	decimal(30,13),
	fee_higher	decimal(30,13),
	fee_fastest	decimal(30,13),
	sweep_trigger_amt	decimal(30,13) default 0,
	status	char(1) NOT NULL,
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.5.15	as_sweep_address 归集地址维护表

DROP TABLE IF EXISTS `as_sweep_address`;
CREATE TABLE `as_sweep_address` (
	id	bigint NOT NULL auto_increment,
	currency	varchar(10),
	address	varchar(128),
	round	bigint NOT NULL default 0,
	status	char(1) NOT NULL,
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.5.16	as_sweep_record 归集记录汇总表

DROP TABLE IF EXISTS `as_sweep_record`;
CREATE TABLE `as_sweep_record` (
	id	bigint NOT NULL auto_increment,
	currency	varchar(10) NOT NULL,
	amount	decimal(30,13),
	sweep_address_to	varchar(128) NOT NULL,
	create_time	datetime(6) NOT NULL,
	invault_txn_time	varchar(20),
	invault_txn_id	varchar(70),
	invault_confirms	int,
	invault_fee	decimal(30,13),
	trade_id	varchar(64),
	status	char(1),
	remark	varchar(255),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.5.17	as_sweep_record_detail  归集记录明细表

DROP TABLE IF EXISTS `as_sweep_record_detail`;
CREATE TABLE `as_sweep_record_detail` (
	id	bigint NOT NULL auto_increment,
	rec_id	bigint NOT NULL,
	deposit_record_id	bigint NOT NULL,
	account_id	varchar(32) NOT NULL,
	currency	varchar(10) NOT NULL,
	amount	decimal(30,13),
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_as_sweep_record_detail_id` FOREIGN KEY (`rec_id`) REFERENCES `as_sweep_record` (`id`),
	CONSTRAINT `fk_as_sweep_record_deposit_record_id` FOREIGN KEY (`deposit_record_id`) REFERENCES `as_deposit_record` (`id`),
	CONSTRAINT `fk_as_sweep_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.18	as_open_request_address   开户地址申请表

DROP TABLE IF EXISTS `as_open_request_address`;
CREATE TABLE `as_open_request_address` (
	id	bigint NOT NULL auto_increment,
	currency	varchar(10),
	address	varchar(128),
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.5.19	as_manual_rec   手工调账表

DROP TABLE IF EXISTS `as_manual_rec`;
CREATE TABLE `as_manual_rec` (
	id	bigint NOT NULL auto_increment,
	account_id	varchar(32) NOT NULL,
	asset_id	bigint NOT NULL,
	currency	varchar(10) NOT NULL,
	amount	decimal(30,13) NOT NULL,
	status	char(1) NOT NULL,
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	approve_operator	bigint,
	approve_time	datetime(6),
	remark	varchar(255),
	version	bigint NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_as_manual_rec` FOREIGN KEY (`account_id`) REFERENCES `as_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO as_currency(`currency`, `name`,`unit`,`limit`) VALUES ('BTC','比特币','BTC','8');
INSERT INTO as_currency(`currency`, `name`,`unit`,`limit`) VALUES ('ETH','以太坊','ETH','8');
INSERT INTO as_currency(`currency`, `name`,`unit`,`limit`) VALUES ('USDT','泰达币','USDT','6');

CREATE DATABASE IF NOT EXISTS `customer_center` default charset utf8 COLLATE utf8_general_ci;

USE customer_center;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name       : dev_jmhb
password        : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/



/*
2.4 客户中心(cu)
*/

-- 2.4.1  cu_customer 客户信息

DROP TABLE IF EXISTS `cu_customer`;
CREATE TABLE `cu_customer` (
  id  varchar(20) NOT NULL,
  last_name varchar(20) NOT NULL,
  first_name  varchar(40) NOT NULL,
  nation  varchar(100) DEFAULT NULL,
  state varchar(20) DEFAULT NULL,
  city  varchar(20) DEFAULT NULL,
  street  varchar(100) DEFAULT NULL,
  address varchar(100) DEFAULT NULL,
  tel_area_code	varchar(10),
  tel varchar(20) DEFAULT NULL,
  mobile_area_code	varchar(10),
  mobile  varchar(40) DEFAULT NULL,
  email varchar(40) DEFAULT NULL,
  type  char(1) NOT NULL,
  kyc_flag  bool NOT NULL default '0',
  kind  char(1) NOT NULL default '3',
  level char(1) NOT NULL default '3',
  user_id bigint NOT NULL,
  invitation_code varchar(32) NOT NULL,
  status  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  CONSTRAINT uk_cu_broker_invitation_code unique (invitation_code),
  CONSTRAINT uk_cu_broker_user_id unique (user_id),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.1	cu_cust_id_seq   客户ID自增表

DROP TABLE IF EXISTS `cu_cust_id_seq`;
CREATE TABLE `cu_cust_id_seq` (
  id  bigint NOT NULL auto_increment,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.2  cu_broker 经纪人信息

DROP TABLE IF EXISTS `cu_broker`;
CREATE TABLE `cu_broker` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  customer_id varchar(20) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_cu_broker unique (customer_id),
  CONSTRAINT `fk_cu_broker_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `cu_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.3  cu_broker_customer 经纪人客户关系表

DROP TABLE IF EXISTS `cu_broker_customer`;
CREATE TABLE `cu_broker_customer` (
  id  bigint NOT NULL auto_increment,
  broker_id bigint NOT NULL,
  brokercustomer_id varchar(20) NOT NULL,
  customer_id varchar(20) NOT NULL  unique,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cu_broker_customer` FOREIGN KEY (`broker_id`) REFERENCES `cu_broker` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.4  cu_broker_draw 经纪人抽成

DROP TABLE IF EXISTS `cu_broker_draw`;
CREATE TABLE `cu_broker_draw` (
  id  bigint NOT NULL auto_increment,
  broker_id bigint NOT NULL,
  brokercustomer_id varchar(20) NOT NULL,
  seq varchar(1) NOT NULL,
  rate  decimal(30,13) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_cu_broker_draw unique (brokercustomer_id,seq),
  CONSTRAINT `fk_cu_broker_draw` FOREIGN KEY (`broker_id`) REFERENCES `cu_broker` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.5  cu_broker_draw_temp 经纪人抽成标准

DROP TABLE IF EXISTS `cu_broker_draw_temp`;
CREATE TABLE `cu_broker_draw_temp` (
  id  bigint NOT NULL auto_increment,
  seq varchar(1) NOT NULL,
  rate  decimal(30,13) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_cu_broker_draw_temp unique (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.6  cu_marketer市场人员信息

DROP TABLE IF EXISTS `cu_marketer`;
CREATE TABLE `cu_marketer` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  draw_rate decimal(30,13) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.4.7  cu_marketer_customer市场人员客户关系表

DROP TABLE IF EXISTS `cu_marketer_customer`;
CREATE TABLE `cu_marketer_customer` (
  id  bigint NOT NULL auto_increment,
  marketer_id bigint NOT NULL,
  customer_id varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_cu_marketer_customer unique (customer_id),
  CONSTRAINT `fk_cu_marketer_customer` FOREIGN KEY (`marketer_id`) REFERENCES `cu_marketer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;






INSERT INTO customer_center.`cu_broker_draw_temp`(`id`,`seq`,`rate`) VALUES (1,1,0);
INSERT INTO customer_center.`cu_broker_draw_temp`(`id`,`seq`,`rate`) VALUES (2,2,0);CREATE DATABASE IF NOT EXISTS `system_manager` default charset utf8 COLLATE utf8_general_ci;

USE system_manager;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name       : dev_jmhb
password        : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/




/*
2.2 系统管理(sm)
*/

-- 2.2.1  sm_admin管理员

DROP TABLE IF EXISTS `sm_admin`;
CREATE TABLE `sm_admin` (
  `id` bigint NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `email` varchar(40),
  `mobile_area_code` varchar(10),
  `mobile` varchar(40),
  `user_id` bigint NOT NULL,
  `status` char(1) NOT NULL,
  `create_operator` bigint DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_operator` bigint DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2.2.2  sm_role角色表

DROP TABLE IF EXISTS `sm_role`;
CREATE TABLE `sm_role` (
  `id` bigint NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `create_operator` bigint DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_operator` bigint DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2.2.3  sm_role_admin 管理员角色表

DROP TABLE IF EXISTS `sm_role_admin`;
CREATE TABLE `sm_role_admin` (
  `id` bigint NOT NULL auto_increment,
   admin_id bigint NOT NULL,
   role_id  bigint NOT NULL,
   PRIMARY KEY (`id`),
   CONSTRAINT `fk_sm_role_admin_admin_id` FOREIGN KEY (`admin_id`) REFERENCES `sm_admin` (`id`),
   CONSTRAINT `fk_sm_role_admin_role_id` FOREIGN KEY (`role_id`) REFERENCES `sm_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.2.4  sm_p_function   功能表

DROP TABLE IF EXISTS `sm_p_function`;
CREATE TABLE `sm_p_function` (
  `key` varchar(60) NOT NULL,
  name  varchar(30) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2.2.5  sm_p_menu 菜单表

DROP TABLE IF EXISTS `sm_p_menu`;
CREATE TABLE `sm_p_menu` (
  id  bigint NOT NULL  auto_increment,
  ui_name varchar(60) DEFAULT NULL,
  menu_name varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_sm_p_menu unique (`ui_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--  2.2.6 sm_p_menu_function  菜单功能表

DROP TABLE IF EXISTS `sm_p_menu_function`;
CREATE TABLE `sm_p_menu_function` (
  id  bigint NOT NULL auto_increment,
  menu_function_name  varchar(30) NOT NULL,
  menu_id bigint NOT NULL,
  `key` varchar(60) NOT NULL,
  description varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sm_p_menu_function_id` FOREIGN KEY (`menu_id`) REFERENCES `sm_p_menu` (`id`),
  CONSTRAINT `fk_sm_p_menu_function` FOREIGN KEY (`key`) REFERENCES `sm_p_function` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




--  2.2.7 sm_role_menu  角色菜单表

DROP TABLE IF EXISTS `sm_role_menu`;
CREATE TABLE `sm_role_menu` (
  id  bigint NOT NULL auto_increment,
  menu_id bigint NOT NULL,
  role_id bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sm_role_menu` FOREIGN KEY (`menu_id`) REFERENCES `sm_p_menu` (`id`),
  CONSTRAINT `fk_sm_role_menu_role` FOREIGN KEY (`role_id`) REFERENCES `sm_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



--  2.2.8 sm_role_menu_function  角色菜单功能表

DROP TABLE IF EXISTS `sm_role_menu_function`;
CREATE TABLE `sm_role_menu_function` (
  id  bigint NOT NULL auto_increment,
  menu_function_id  bigint NOT NULL,
  role_id bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sm_role_menu_function` FOREIGN KEY (`menu_function_id`) REFERENCES `sm_p_menu_function` (`id`),
  CONSTRAINT `fk_sm_role_menu_function_role` FOREIGN KEY (`role_id`) REFERENCES `sm_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





-- 2.2.9  sm_workflow   流程管理表

DROP TABLE IF EXISTS `sm_workflow`;
CREATE TABLE `sm_workflow` (
  `key` varchar(60)  NOT NULL,
  name  varchar(30)  NOT NULL,
  approval_open bool  NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.2.10 sm_operate_log 操作日志表

DROP TABLE IF EXISTS `sm_operate_log`;
CREATE TABLE `sm_operate_log` (
  id  bigint NOT NULL auto_increment,
  menu_function_id  bigint  NOT NULL,
  result  char(1) NOT NULL,
  remark  varchar(255) DEFAULT NULL,
  operator  bigint DEFAULT NULL,
  time  datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.2.11 sm_system_log系统日志表

DROP TABLE IF EXISTS `sm_system_log`;
CREATE TABLE `sm_system_log` (
  id  bigint NOT NULL auto_increment,
  type  char(2) NOT NULL default '0',
  remark  varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.2.13	sm_p_task  定时任务key

DROP TABLE IF EXISTS `sm_p_task`;
CREATE TABLE `sm_p_task` (
	task_key	varchar(30) NOT NULL,
	task_name	varchar(60) NOT NULL,
	description	varchar(128),
	PRIMARY KEY (`task_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.2.12	sm_task_setting   定时任务设置

DROP TABLE IF EXISTS `sm_task_setting`;
CREATE TABLE `sm_task_setting` (
	id	bigint NOT NULL auto_increment,
	setting_type	char(1) NOT NULL,
	task_key	varchar(30) NOT NULL,
	task_name	Varchar(100) NOT NULL,
	start_time datetime(6) NOT NULL,
	cron_expression varchar(60) NOT NULL,
	job_data	varchar(2048),
	setting_status	char(1) NOT NULL,
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_sm_task_setting_task_id` FOREIGN KEY (`task_key`) REFERENCES `sm_p_task` (`task_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.2.14	sm_task_running_log 任务运行日志

DROP TABLE IF EXISTS `sm_task_running_log`;
CREATE TABLE `sm_task_running_log` (
	id	bigint NOT NULL auto_increment,
	task_key	varchar(30) NOT NULL,
	task_name	varchar(100) NOT NULL,
	task_id		bigint NOT NULL,
	trigger_time	Timestamp(6) NOT NULL,
	task_result	char (1) NOT NULL,
	remark	varchar(255),
	end_time	Timestamp(6) NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_sm_task_running_log` FOREIGN KEY (`task_id`) REFERENCES `sm_task_setting` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO system_manager.sm_admin (name, user_id, status, create_operator, create_time, update_operator, update_time, version)
VALUES ('admin', 1, '1', null, '2019-05-09 08:13:47.000000', null, null, 0);

INSERT INTO system_manager.sm_role (name, create_operator, create_time, update_operator, update_time, version)
VALUES ('admin', 1, '2018-06-05 06:57:04.000000', null, null, 0);

INSERT INTO system_manager.sm_role_admin (admin_id, role_id) VALUES (1, 1);


INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-update','主资金账户修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-updateReview','主资金账户修改工作流审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-passwordReset','重置资金密码');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-passwordResetReview','重置资金密码工作流审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-user-restPs','重置登入密码');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-user-restPsReview','重置登入密码审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-subAccountAdd','子资金账户添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-subAccountAddReview','子资金账户添加工作流审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-subAccountUpdate','子资金账户修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-subAccountUpdateReview','子资金账户修改工作流审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-get','获取资金账户信息');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-page','资金账户分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-list','资金账户列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-frz','资金账户冻结');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-frzReview','资金账户冻结工作流审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-disable','资金账户注销');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-disableReview','资金账户注销批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-unfrz','资金账户解冻');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-unfrzReview','资金账户解冻批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-withdrawApprove','提币审核通过');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-withdrawApproveReview','提币审核通过批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-withdrawReject','提币审核驳回');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-withdrawRejectReview','提币审核驳回批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawRecord-page','提币记录分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-depositRecord-page','充币记录分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-transInMarketApprove','场内转账审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-transInMarketApproveReview','场内转账审核批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-transInMarketReject','场内转账审核驳回');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-account-transInMarketRejectReview','场内转账审核驳回批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-transInMarketRecord-page','场内转账记录分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-currency-list','币种列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-currency-page','币种分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-add','提币钱包地址添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-addReview','提币钱包地址添加批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-update','提币钱包地址修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-updateReview','提币钱包地址修改批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-delete','提币钱包地址删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-deleteReview','提币钱包地址删除批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-get','获取提币钱包地址信息');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-page','提币钱包地址分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-withdrawWallet-list','提币钱包地址列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-walletRecord-get','获取充币钱包地址信息');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-walletRecord-page','充币钱包地址分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-walletRecord-list','充币钱包地址列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-get','获取客户信息');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-list','客户账户列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-page','客户账户分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-client-openAccount','用户端开户');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-client-openAccountReview','用户端开户批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-admin-openAccount','管理端开户');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-admin-openAccountReview','管理端开户批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-update','客户账户修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-updateReview','客户账户修改批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-frz','客户账户冻结');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-frzReview','客户账户冻结批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-disable','客户账户注销');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-disableReview','客户账户注销批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-unfrz','客户账户解冻');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-customer-unfrzReview','客户账户解冻批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-add','添加管理员');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-update','修改管理员');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-delete','删除管理员');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-lock','锁定管理员');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-unLock','解锁管理员');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-addReview','添加管理员批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-updateReview','修改管理员批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-deleteReview','删除管理员批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-lockReview','锁定管理员批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-unLockReview','解锁管理员批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-restPs','重置登入密码');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-restPsReview','重置登入密码审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-getAdminsPages','管理员信息分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-add','添加角色');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-update','修改角色');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-delete','删除角色');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-addReview','添加角色批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-updateReview','修改角色批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-deleteReview','删除角色批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-role-getRoles','角色信息分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-roleB-admin','角色管理员绑定');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-roleB-adminReview','角色管理员绑定批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-roleU-admin','角色管理员解绑');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-roleU-adminReview','角色管理员解绑批准');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-getUnbindAdmins','未绑定该角色管理员查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-getBindAdmins','已绑定该角色管理员查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-activeTasks','个人可审核工作流分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-myTasks','个人发布工作流分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-page','板块集团分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-list','板块集团列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-add','板块集团添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-add-review','板块集团添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-modify','板块集团修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-modify-review','板块集团修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-delete','板块集团删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marketGroup-delete-review','板块集团删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-market-modify','板块修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-market-modify-review','板块修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-page','标的分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-list','标的列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-add','标的添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-add-review','标的添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-modify','标的修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-modify-review','标的修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-delete','标的删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-subject-delete-review','标的删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-page','产品分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-list','产品列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-add','产品添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-add-review','产品添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-modify','产品修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-modify-review','产品修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-delete','产品删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-product-delete-review','产品删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-page','交易时间策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-list','交易时间策略列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTimeItem-list','交易时间策略项列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-add','交易时间策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-add-review','交易时间策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-modify','交易时间策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-modify-review','交易时间策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-delete','交易时间策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingTime-delete-review','交易时间策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-page','保证金策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRulePhase-list','保证金策略阶段信息列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRuleStep-list','保证金策略阶梯信息列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-add','保证金策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-add-review','保证金策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-modify','保证金策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-modify-review','保证金策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-delete','保证金策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-delete-review','保证金策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-page','手续费策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-add','手续费策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-add-review','手续费策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-modify','手续费策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-modify-review','手续费策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-delete','手续费策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-delete-review','手续费策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-page','费率SFD策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-list','费率SFD策略表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-add','费率SFD策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-add-review','费率SFD策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-modify','费率SFD策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-modify-review','费率SFD策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-delete','费率SFD策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingSfd-delete-review','费率SFD策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-page','费率BS策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-list','费率BS策略列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-add','费率BS策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-add-review','费率BS策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-modify','费率BS策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-modify-review','费率BS策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-delete','费率BS策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingBs-delete-review','费率BS策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-page','交易权限策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-add','交易权限策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-add-review','交易权限策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-modify','交易权限策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-modify-review','交易权限策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-delete','交易权限策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-delete-review','交易权限策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-page','合约模板分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-add','合约模板添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-add-review','合约模板添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-modify','合约模板修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-modify-review','合约模板修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-delete','合约模板删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contractTemp-delete-review','合约模板删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-page','合约分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-add','合约添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-add-review','合约添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-modify','合约修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-modify-review','合约修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-delete','合约删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-contract-delete-review','合约删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingFeeRule-list','手续费策略列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-tradingPermission-list','交易权限策略列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-marginRule-list','保证金策略列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-page','账号策略组分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-list','账号策略组列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-add','账号策略组添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-add-review','账号策略组添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-modify','账号策略组修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-modify-review','账号策略组修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-delete','账号策略组删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-accountRule-delete-review','账号策略组删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-page','交易对冲策略分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-list','交易对冲策略列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-add','交易对冲策略添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-add-review','交易对冲策略添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-modify','交易对冲策略修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-modify-review','交易对冲策略修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-delete','交易对冲策略删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-hedgingRule-delete-review','交易对冲策略删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-page','交易状态变更分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-add','新增交易状态');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-add-review','新增交易状态审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-modify','修改交易状态');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-modify-review','修改交易状态审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-delete','删除交易状态');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-trading-status-change-delete-review','删除交易状态审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-getWorkFs','工作流分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-openWorkFlow','工作流开启');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-openWorkFlowReview','工作流开启审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-closeWorkFlow','工作流关闭');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-admin-closeWorkFlowReview','工作流关闭审核');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-page','定时任务分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-add','定时设置添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-update','定时设置修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-delete','定时设置删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-addReview','定时设置添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-updateReview','定时设置修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-deleteReview','定时设置删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-timingSet-runningLog-page','定时设置日志分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-add','经纪人添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-addReview','经纪人添加工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-update','经纪人修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-updateReview','经纪人修改工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-delete','经纪人删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-deleteReview','经纪人删除工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-page','经纪人分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-cust-bind','经纪人客户绑定');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-cust-bindReview','经纪人客户绑定工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-cust-unbind','经纪人客户解绑');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-cust-unbindReview','经纪人客户解绑工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-drawTempSave','经纪人抽成标准设置');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-drawTempSaveReview','经纪人抽成标准准设置工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-get','获取经纪人信息');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-list','经纪人列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-bindCust-page','经纪人绑定客户分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-unbindCust-page','经纪人未绑定客户分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-drawTemp-list','经纪人抽成标准列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-broker-unbindBrokers-page','未绑定经纪人分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-add','市场人员添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-addReview','市场人员添加工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-update','市场人员修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-updateReview','市场人员修改工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-delete','市场人员删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-deleteReview','市场人员删除工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-page','市场人员分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-cust-bind','市场人员客户绑定');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-cust-bindReview','市场人员客户绑定工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-cust-unbind','市场人员客户解绑');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-cust-unbindReview','市场人员客户解绑工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-get','获取市场人员信息');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-list','市场人员列表查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-bindCust-page','市场人员绑定客户分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cu-marketer-unbindCust-page','市场人员未绑定客户分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-account-page','资金查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-position-page','持仓查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-order-page','报单查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-fill-page','成交查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-deposit-page','充币记录查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-withdrawals-page','提币记录查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-transfer-page','资金划转记录查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-running-page','交易资金记录查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-positionReport-page','每日结算持仓查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-bsReport-page','每日结算BS查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-accountAssetReport-page','每日结算资金查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-page','清算基金查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-add','清算基金添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-update','清算基金修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-delete','清算基金删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-addReview','清算基金添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-updateReview','清算基金修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-clFund-deleteReview','清算基金删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-dayQuotation-page','每日行情查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-dayQuotationMarket-page','每日市场行情查询分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-page','现货指数指导价分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-add','现货指数指导价添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-update','现货指数指导价修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-delete','现货指数指导价删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-addReview','现货指数指导价添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-updateReview','现货指数指导价修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('mf-spotIndexConfig-deleteReview','现货指数指导价删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-getOnlineUserPage','在线用户分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-kickLogin','在线用户登出');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-kickLoginBatch','在线用户批量登出');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-kickLoginReview','在线用户登出审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-user-kickLoginBatchReview','在线用户批量登出审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-loginLogs-page','登录日志分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-operateLogs-page','操作日志分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-contents-page','文章管理分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-content-add','文章新增');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-content-add-review','文章新增审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-content-modify','文章修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-content-modify-review','文章修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-content-delete','文章删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('cms-content-delete-review','文章删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agreeDeal-page','协议开平换分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agree-open','协议开仓');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agree-openReview','协议开仓工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agree-close','协议平仓');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agree-closeReview','协议平仓工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agree-handover','协议换手');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-agree-handoverReview','协议换手工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-cancelOrder-page','强制撤单分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-cancelOrder','强制撤单');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-cancelOrderReview','强制撤单工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-closeOrder-page','强制平仓分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-closeOrder','强制平仓');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-closeOrderReview','强制平仓工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-reduceOrder-page','强制减仓分页');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-reduceOrder','强制减仓');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-force-reduceOrderReview','强制减仓工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-page','归集地址分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-add','归集地址添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-add-review','归集地址添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-start','归集地址开启');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-start-review','归集地址开启审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-stop','归集地址关闭');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepAddress-stop-review','归集地址关闭审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-sweepRecord-page','归集记录分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-page','币种参数设置分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-add','币种参数设置添加');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-add-review','币种参数设置添加审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-modify','币种参数设置修改');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-modify-review','币种参数设置修改审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-delete','币种参数设置删除');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-feeSweepConfig-delete-review','币种参数设置删除审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-brokerFeeReturn-page','每日经纪人返佣分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('sm-marketerFeeReturn-page','每日市场人返佣分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-page','手工调账分页查询');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-add','手工调账申请');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-addReview','手工调账申请工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-approve','手工调账审核通过');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-approveReview','手工调账审核通过工作流审批');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-reject','手工调账审核驳回');
INSERT INTO system_manager.sm_p_function(`key`, `name`) VALUES ('as-manualRec-rejectReview','手工调账审核驳回工作流审批');




-- sm_p_menu
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.account','资金账户');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.withdraw','提币审核');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.deposit','充币审核');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.transInMarket','场内转账审核');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.currency','币种查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.wallet','提币地址管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.depositWallet','充币地址管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.customer.manage','客户账户');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.administrator','管理员');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.role','角色和权限');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.roleadmin','管理员角色');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.account.center','任务中心');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.marketGroups','板块管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.subjects','标的管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.products','产品管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.tradetime','交易时间');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.depositTactics','保证金策略');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.tradeExpenses','手续费策略');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.sfd','费率SFD策略');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.bs','费率BS策略');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.tradePermission','交易权限策略');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.contractTemp','合约模板管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.contract','合约管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.tradeAccountRule','账号策略组');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.tradehedge','交易对冲策略');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.tradingStatusChanges','交易状态变更');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.workflow','工作流管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.clock','定时设置');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.clockLogs','定时设置日志');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.customer.drawtemp','抽成标准');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.customer.broker','经纪人');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.customer.marketer','市场人员');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atFund', '资金查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atPositions', '持仓查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atOrder', '报单查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atFill', '成交查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atDeposit','充币记录查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atWithdraw','提币记录查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atTransfer','资金划转记录');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaTrade.atRunnings','交易资金流水');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaSettlement.asPositions','每日结算持仓查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaSettlement.asAsset','每日结算资金查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaSettlement.asBS','每日结算BS查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaSettlement.brokerfeereturn','每日经纪人返佣查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaSettlement.marekterfeereturn','每日市场人返佣查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaStatistics.assClearing','清算基金');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaStatistics.assDailyContractQuo','每日行情查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.analysis.anaStatistics.assDailyMaketQuo','市场行情汇总查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.market.spotIndexConfig','现货指数指导价');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.online','在线用户');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.operateLogs','操作日志');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.loginLogs','登录日志');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.system.article','文章管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.risk.riskAgreement','协议开平换');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.risk.riskForce.rfCancel','强制撤单');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.risk.riskForce.rfClose','强制平仓');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.risk.riskForce.rfDeleverage','强制减仓');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.sweepAddress','归集地址管理');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.sweepRecord','归集记录查询');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.feeSweepConfig','币种参数设置');
INSERT INTO system_manager.`sm_p_menu`(`ui_name`,`menu_name`) VALUES ('menu.assets.manualRec','手工调账');




-- sm_p_menu_function  菜单功能表

INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-update','主资金账户修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-updateReview','主资金账户修改工作流审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('重置资金密码',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-passwordReset','重置资金密码');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('重置资金密码审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-passwordResetReview','重置资金密码审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('添加子账户',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-subAccountAdd','子资金账户添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('添加资账户审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-subAccountAddReview','子资金账户添加工作流审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('子账户修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-subAccountUpdate','子资金账户修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('子帐户修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-subAccountUpdateReview','子资金账户修改工作流审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-page','资金账户分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('冻结',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-frz','资金账户冻结');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('冻结审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-frzReview','资金账户冻结工作流审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('注销',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-disable','资金账户注销');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('注销审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-disableReview','资金账户注销批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解冻',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-unfrz','资金账户解冻');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解冻审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-account-unfrzReview','资金账户解冻批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('重置登入密码',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-user-restPs','重置登入密码');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('重置登入密码审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.account'),'as-user-restPsReview','重置登入密码审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.withdraw'),'as-account-withdrawApprove','提币审核通过');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('审核审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.withdraw'),'as-account-withdrawApproveReview','提币审核通过批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('驳回',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.withdraw'),'as-account-withdrawReject','提币审核驳回');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('驳回审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.withdraw'),'as-account-withdrawRejectReview','提币审核驳回批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.withdraw'),'as-withdrawRecord-page','提币记录分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.deposit'),'as-depositRecord-page','充币记录分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.transInMarket'),'as-account-transInMarketApprove','场内转账审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('审核审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.transInMarket'),'as-account-transInMarketApproveReview','场内转账审核批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('驳回',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.transInMarket'),'as-account-transInMarketReject','场内转账审核驳回');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('驳回审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.transInMarket'),'as-account-transInMarketRejectReview','场内转账审核驳回批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.transInMarket'),'as-transInMarketRecord-page','场内转账记录分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.currency'),'as-currency-page','币种分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-add','提币钱包地址添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-addReview','提币钱包地址添加批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-update','提币钱包地址修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-updateReview','提币钱包地址修改批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-delete','提币钱包地址删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-deleteReview','提币钱包地址删除批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.wallet'),'as-withdrawWallet-page','提币钱包地址分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.depositWallet'),'as-walletRecord-page','充币钱包地址分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-page','客户账户分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('开户',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-admin-openAccount','管理端开户');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('开户审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-admin-openAccountReview','管理端开户批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-update','客户账户修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-updateReview','客户账户修改批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('冻结',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-frz','客户账户冻结');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('冻结审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-frzReview','客户账户冻结批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('注销',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-disable','客户账户注销');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('注销审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-disableReview','客户账户注销批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解冻',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-unfrz','客户账户解冻');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解冻审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.manage'),'cu-customer-unfrzReview','客户账户解冻批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-add','添加管理员');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-update','修改管理员');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-delete','删除管理员');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('锁定',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-lock','锁定管理员');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解锁',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-unLock','解锁管理员');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-addReview','添加管理员批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-updateReview','修改管理员批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-deleteReview','删除管理员批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('锁定审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-lockReview','锁定管理员批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解锁审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-unLockReview','解锁管理员批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('重置登入密码',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-user-restPs','重置登入密码');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('重置登入密码审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-user-restPsReview','重置登入密码审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.administrator'),'sm-admin-getAdminsPages','管理员信息分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.role'),'sm-role-add','添加角色');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.role'),'sm-role-update','修改角色');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.role'),'sm-role-delete','删除角色');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.role'),'sm-role-addReview','添加角色批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.role'),'sm-role-updateReview','修改角色批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.role'),'sm-role-deleteReview','删除角色批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.roleadmin'),'sm-roleB-admin','角色管理员绑定');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.roleadmin'),'sm-roleB-adminReview','角色管理员绑定批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解绑',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.roleadmin'),'sm-roleU-admin','角色管理员解绑');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解绑审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.roleadmin'),'sm-roleU-adminReview','角色管理员解绑批准');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-marketGroup-add','板块集团添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-marketGroup-add-review','板块集团添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-marketGroup-modify','板块集团修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-marketGroup-modify-review','板块集团修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-marketGroup-delete','板块集团删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-marketGroup-delete-review','板块集团删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-market-modify','板块修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.marketGroups'),'mf-market-modify-review','板块修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('分页查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-page','标的分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-add','标的添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-add-review','标的添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-modify','标的修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-modify-review','标的修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-delete','标的删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.subjects'),'mf-subject-delete-review','标的删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('分页查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-page','产品分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-add','产品添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-add-review','产品添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-modify','产品修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-modify-review','产品修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-delete','产品删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.products'),'mf-product-delete-review','产品删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('添加',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradetime'),'mf-tradingTime-add','交易时间策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('添加审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradetime'),'mf-tradingTime-add-review','交易时间策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradetime'),'mf-tradingTime-modify','交易时间策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradetime'),'mf-tradingTime-modify-review','交易时间策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradetime'),'mf-tradingTime-delete','交易时间策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradetime'),'mf-tradingTime-delete-review','交易时间策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.depositTactics'),'mf-marginRule-add','保证金策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.depositTactics'),'mf-marginRule-add-review','保证金策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.depositTactics'),'mf-marginRule-modify','保证金策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.depositTactics'),'mf-marginRule-modify-review','保证金策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.depositTactics'),'mf-marginRule-delete','保证金策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.depositTactics'),'mf-marginRule-delete-review','保证金策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeExpenses'),'mf-tradingFeeRule-add','手续费策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeExpenses'),'mf-tradingFeeRule-add-review','手续费策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeExpenses'),'mf-tradingFeeRule-modify','手续费策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeExpenses'),'mf-tradingFeeRule-modify-review','手续费策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeExpenses'),'mf-tradingFeeRule-delete','手续费策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeExpenses'),'mf-tradingFeeRule-delete-review','手续费策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('添加',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.sfd'),'mf-tradingSfd-add','费率SFD策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('添加审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.sfd'),'mf-tradingSfd-add-review','费率SFD策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.sfd'),'mf-tradingSfd-modify','费率SFD策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.sfd'),'mf-tradingSfd-modify-review','费率SFD策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.sfd'),'mf-tradingSfd-delete','费率SFD策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.sfd'),'mf-tradingSfd-delete-review','费率SFD策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-page','费率BS策略分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-add','费率BS策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-add-review','费率BS策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-modify','费率BS策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-modify-review','费率BS策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-delete','费率BS策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.bs'),'mf-tradingBs-delete-review','费率BS策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradePermission'),'mf-tradingPermission-add','交易权限策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradePermission'),'mf-tradingPermission-add-review','交易权限策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradePermission'),'mf-tradingPermission-modify','交易权限策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradePermission'),'mf-tradingPermission-modify-review','交易权限策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradePermission'),'mf-tradingPermission-delete','交易权限策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradePermission'),'mf-tradingPermission-delete-review','交易权限策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('分页查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-page','合约模板分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-add','合约模板添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-add-review','合约模板添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-modify','合约模板修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-modify-review','合约模板修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-delete','合约模板删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contractTemp'),'mf-contractTemp-delete-review','合约模板删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('分页查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-page','合约分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-add','合约添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-add-review','合约添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-modify','合约修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-modify-review','合约修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-delete','合约删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.contract'),'mf-contract-delete-review','合约删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeAccountRule'),'mf-accountRule-add','账号策略组添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeAccountRule'),'mf-accountRule-add-review','账号策略组添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeAccountRule'),'mf-accountRule-modify','账号策略组修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeAccountRule'),'mf-accountRule-modify-review','账号策略组修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeAccountRule'),'mf-accountRule-delete','账号策略组删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradeAccountRule'),'mf-accountRule-delete-review','账号策略组删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradehedge'),'mf-hedgingRule-add','交易对冲策略添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradehedge'),'mf-hedgingRule-add-review','交易对冲策略添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradehedge'),'mf-hedgingRule-modify','交易对冲策略修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradehedge'),'mf-hedgingRule-modify-review','交易对冲策略修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradehedge'),'mf-hedgingRule-delete','交易对冲策略删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradehedge'),'mf-hedgingRule-delete-review','交易对冲策略删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.workflow'),'sm-admin-getWorkFs','工作流分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('开启',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.workflow'),'sm-admin-openWorkFlow','工作流开启');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('开启审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.workflow'),'sm-admin-openWorkFlowReview','工作流开启审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('关闭',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.workflow'),'sm-admin-closeWorkFlow','工作流关闭');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('关闭审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.workflow'),'sm-admin-closeWorkFlowReview','工作流关闭审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-page','交易状态变更分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-add','新增交易状态');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-add-review','新增交易状态审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-modify','修改交易状态');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-modify-review','修改交易状态审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-delete','删除交易状态');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.tradingStatusChanges'),'mf-trading-status-change-delete-review','删除交易状态审核');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-page','定时任务分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-add','定时设置添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-update','定时设置修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-delete','定时设置删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-addReview','定时设置添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-updateReview','定时设置修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clock'),'sm-timingSet-deleteReview','定时设置删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.clockLogs'),'sm-timingSet-runningLog-page','定时设置日志分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atFund'),'sm-account-page','资金查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atPositions'),'sm-position-page','持仓查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atOrder'),'sm-order-page','报单查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atFill'),'sm-fill-page','成交查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atDeposit'),'sm-deposit-page','充币记录查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atWithdraw'),'sm-withdrawals-page','提币记录查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atTransfer'),'sm-transfer-page','资金划转记录查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaTrade.atRunnings'),'sm-running-page','交易资金记录查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaSettlement.asAsset'),'sm-accountAssetReport-page','每日结算资金查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaSettlement.asPositions'),'sm-positionReport-page','每日结算持仓查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaSettlement.asBS'),'sm-bsReport-page','每日结算BS查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaSettlement.brokerfeereturn'),'sm-brokerFeeReturn-page','每日经纪人返佣分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaSettlement.marekterfeereturn'),'sm-marketerFeeReturn-page','每日市场人返佣分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-page','清算基金查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-add','清算基金添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-update','清算基金修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-delete','清算基金删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-addReview','清算基金添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-updateReview','清算基金修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assClearing'),'sm-clFund-deleteReview','清算基金删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assDailyContractQuo'),'sm-dayQuotation-page','每日行情查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.analysis.anaStatistics.assDailyMaketQuo'),'sm-dayQuotationMarket-page','每日市场行情查询分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-add','经纪人添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-addReview','经纪人添加工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-update','经纪人修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-updateReview','经纪人修改工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-delete','经纪人删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-deleteReview','经纪人删除工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-page','经纪人分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定客户',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-cust-bind','经纪人客户绑定');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定客户审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-cust-bindReview','经纪人客户绑定工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解绑客户',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-cust-unbind','经纪人客户解绑');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解绑客户审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.broker'),'cu-broker-cust-unbindReview','经纪人客户解绑工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('设置',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.drawtemp'),'cu-broker-drawTempSave','经纪人抽成标准设置');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('设置审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.drawtemp'),'cu-broker-drawTempSaveReview','经纪人抽成标准准设置工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-add','市场人员添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-addReview','市场人员添加工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-update','市场人员修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-updateReview','市场人员修改工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-delete','市场人员删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-deleteReview','市场人员删除工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-page','市场人员分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定客户',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-cust-bind','市场人员客户绑定');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('绑定客户审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-cust-bindReview','市场人员客户绑定工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解绑客户',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-cust-unbind','市场人员客户解绑');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('解绑客户审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.customer.marketer'),'cu-marketer-cust-unbindReview','市场人员客户解绑工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-page','现货指数指导价分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-add','现货指数指导价添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-update','现货指数指导价修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-delete','现货指数指导价删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-addReview','现货指数指导价添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-updateReview','现货指数指导价修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.market.spotIndexConfig'),'mf-spotIndexConfig-deleteReview','现货指数指导价删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.online'),'sm-user-getOnlineUserPage','在线用户分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('登出',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.online'),'sm-user-kickLogin','在线用户登出');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('批量登出',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.online'),'sm-user-kickLoginBatch','在线用户批量登出');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('登出审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.online'),'sm-user-kickLoginReview','在线用户登出审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('批量登出审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.online'),'sm-user-kickLoginBatchReview','在线用户批量登出审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.loginLogs'),'sm-loginLogs-page','登录日志分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.operateLogs'),'sm-operateLogs-page','操作日志分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-contents-page','文章管理分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-content-add','文章新增');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-content-add-review','文章新增审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-content-modify','文章修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-content-modify-review','文章修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-content-delete','文章删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.system.article'),'cms-content-delete-review','文章删除审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agreeDeal-page','协议开平换分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('协议开仓',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agree-open','协议开仓');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('协议开仓审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agree-openReview','协议开仓工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('协议平仓',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agree-close','协议平仓');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('协议平仓审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agree-closeReview','协议平仓工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('协议换手',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agree-handover','协议换手');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('协议换手审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskAgreement'),'sm-agree-handoverReview','协议换手工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfCancel'),'sm-force-cancelOrder-page','强制撤单分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('强制撤单',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfCancel'),'sm-force-cancelOrder','强制撤单');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('强制撤单审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfCancel'),'sm-force-cancelOrderReview','强制撤单工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfClose'),'sm-force-closeOrder-page','强制平仓分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('强制平仓',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfClose'),'sm-force-closeOrder','强制平仓');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('强制平仓审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfClose'),'sm-force-closeOrderReview','强制平仓工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfDeleverage'),'sm-force-reduceOrder-page','强制减仓分页');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('强制减仓',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfDeleverage'),'sm-force-reduceOrder','强制减仓');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('强制减仓审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.risk.riskForce.rfDeleverage'),'sm-force-reduceOrderReview','强制减仓工作流审批');

INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-page','归集地址分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-add','归集地址添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-add-review','归集地址添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('开启',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-start','归集地址开启');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('开启审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-start-review','归集地址开启审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('关闭',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-stop','归集地址关闭');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('关闭审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepAddress'),'as-sweepAddress-stop-review','归集地址关闭审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.sweepRecord'),'as-sweepRecord-page','归集记录分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-page','币种参数设置分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-add','币种参数设置添加');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('新增审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-add-review','币种参数设置添加审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-modify','币种参数设置修改');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('修改审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-modify-review','币种参数设置修改审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-delete','币种参数设置删除');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('删除审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.feeSweepConfig'),'as-feeSweepConfig-delete-review','币种参数设置删除审批');

INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('查询',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-page','手工调账分页查询');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('申请',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-add','手工调账申请');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('申请审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-addReview','手工调账申请工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('审核',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-approve','手工调账审核通过');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('审核审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-approveReview','手工调账审核通过工作流审批');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('驳回',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-reject','手工调账审核驳回');
INSERT INTO system_manager.`sm_p_menu_function`(`menu_function_name`,`menu_id`,`key`,`description`) VALUES ('驳回审批',(SELECT id FROM sm_p_menu WHERE `ui_name`='menu.assets.manualRec'),'as-manualRec-rejectReview','手工调账审核驳回工作流审批');



INSERT INTO system_manager.sm_role_menu 
	(role_id,menu_id)
 	select a.id, b.id FROM sm_role a, sm_p_menu b WHERE a.name='admin';


INSERT INTO  system_manager.sm_role_menu_function
	(role_id,menu_function_id)
	SELECT  a.id,b.id FROM sm_role a,sm_p_menu_function b WHERE a.name='admin';
	
	
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-update','主资金账户修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-passwordReset','重置资金密码',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-subAccountAdd','子资金账户添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-subAccountUpdate','子资金账户修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-frz','资金账户冻结',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-user-restPs','重置资金账户登入密码',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-disable','资金账户注销',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-unfrz','资金账户解冻',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-transferForSelf','资金划转',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-withdrawApprove','提币审核通过',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-withdrawReject','提币审核驳回',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-transInMarketApprove','场内转账审核',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-account-transInMarketReject','场内转账审核驳回',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-withdrawWallet-add','提币钱包地址添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-withdrawWallet-update','提币钱包地址修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-withdrawWallet-delete','提币钱包地址删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-client-openAccount','用户端开户',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-admin-openAccount','管理端开户',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-customer-update','客户账户修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-customer-frz','客户账户冻结',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-customer-disable','客户账户注销',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-customer-unfrz','客户账户解冻',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-add','添加管理员',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-update','修改管理员',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-delete','删除管理员',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-lock','锁定管理员',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-unLock','解锁管理员',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-user-restPs','重置管理员登入密码',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-role-add','添加角色',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-role-update','修改角色',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-role-delete','删除角色',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-roleB-admin','角色管理员绑定',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-roleU-admin','角色管理员解绑',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-marketGroup-add','板块集团添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-marketGroup-modify','板块集团修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-marketGroup-delete','板块集团删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-market-modify','板块修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-subject-add','标的添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-subject-modify','标的修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-subject-delete','标的删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-product-add','产品添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-product-modify','产品修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-product-delete','产品删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingTime-add','交易时间策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingTime-modify','交易时间策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingTime-delete','交易时间策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-marginRule-add','保证金策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-marginRule-modify','保证金策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-marginRule-delete','保证金策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingFeeRule-add','手续费策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingFeeRule-modify','手续费策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingFeeRule-delete','手续费策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingSfd-add','费率SFD策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingSfd-modify','费率SFD策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingSfd-delete','费率SFD策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingBs-add','费率BS策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingBs-modify','费率BS策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingBs-delete','费率BS策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingPermission-add','交易权限策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingPermission-modify','交易权限策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-tradingPermission-delete','交易权限策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-contractTemp-add','合约模板添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-contractTemp-modify','合约模板修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-contractTemp-delete','合约模板删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-contract-add','合约添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-contract-modify','合约修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-contract-delete','合约删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-accountRule-add','账号策略组添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-accountRule-modify','账号策略组修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-accountRule-delete','账号策略组删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-hedgingRule-add','交易对冲策略添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-hedgingRule-modify','交易对冲策略修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-hedgingRule-delete','交易对冲策略删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-trading-status-change-add','新增交易状态',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-trading-status-change-modify','修改交易状态',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-trading-status-change-delete','删除交易状态',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-openWorkFlow','工作流开启',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-admin-closeWorkFlow','工作流关闭',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-timingSet-add','定时设置添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-timingSet-update','定时设置修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-timingSet-delete','定时设置删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-clFund-add','清算基金添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-clFund-update','清算基金修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-clFund-delete','清算基金删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-broker-add','经纪人添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-broker-update','经纪人修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-broker-delete','经纪人删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-broker-cust-bind','经纪人客户绑定',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-broker-cust-unbind','经纪人客户解绑',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-broker-drawTempSave','经纪人抽成标准设置',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-marketer-add','市场人员添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-marketer-update','市场人员修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-marketer-delete','市场人员删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-marketer-cust-bind','市场人员客户绑定',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cu-marketer-cust-unbind','市场人员客户解绑',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-spotIndexConfig-add','现货指数指导价添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-spotIndexConfig-update','现货指数指导价修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('mf-spotIndexConfig-delete','现货指数指导价删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-user-kickLogin','在线用户登出',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-user-kickLoginBatch','在线用批量户登出',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cms-content-add','文章新增',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cms-content-modify','文章修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('cms-content-delete','文章删除',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-agree-open','协议开仓',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-agree-close','协议平仓',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-agree-handover','协议换手',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-force-cancelOrder','强制撤单',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-force-closeOrder','强制平仓',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('sm-force-reduceOrder','强制减仓',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-sweepAddress-add','归集地址添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-sweepAddress-start','归集地址开启',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-sweepAddress-stop','归集地址关闭',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-feeSweepConfig-add','币种参数设置添加',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-feeSweepConfig-modify','币种参数设置修改',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-feeSweepConfig-delete','币种参数设置删除',1);

INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-manualRec-add','手工调账申请',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-manualRec-approve','手工调账审核通过',1);
INSERT INTO system_manager.`sm_workflow` (`key`, `name`, `approval_open`) values ('as-manualRec-reject','手工调账审核驳回',1);


INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('SettlementDaily', '每日结算','每日结算+到期交割结算+每日结算价+最后结算价(交割价格)');
INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('SettlementBS', '结算BS和手续费抽成','BS合约结算+基差互换历史+手续费抽成计算(经纪人返佣)');
INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('DailyQuotation', '每日行情数据统计','每日行情、每日市场数据统计');
INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('DailyTradeData', '每日交易数据统计','统计费用(当日手续费、当日SFD，当日平仓盈亏)');
INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('GeneratingContracts', '自动生成合约','当日如果有合约到期，会按照规则和合约模板自动生成新合约。保证任何时候存在2个季合约和2个月合约可交易');
INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('PaymentInCurrency', '定时触发提币划账','区块链转账');
INSERT INTO system_manager.`sm_p_task`(`task_key`,`task_name`,`description`) VALUES ('SweepPooling', '定时触发充币归集','区块链充币归集');
/*flowable框架相关的流程表*/

DROP TABLE IF EXISTS `ACT_EVT_LOG`;

CREATE TABLE `ACT_EVT_LOG` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;

CREATE TABLE `ACT_GE_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_HI_ACTINST`;

CREATE TABLE `ACT_HI_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;

CREATE TABLE `ACT_HI_ATTACHMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_HI_COMMENT`;

CREATE TABLE `ACT_HI_COMMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_HI_DETAIL`;

CREATE TABLE `ACT_HI_DETAIL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




DROP TABLE IF EXISTS `ACT_HI_ENTITYLINK`;

CREATE TABLE `ACT_HI_ENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `ACT_HI_IDENTITYLINK`;

CREATE TABLE `ACT_HI_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_HI_PROCINST`;

CREATE TABLE `ACT_HI_PROCINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT 1,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_HI_TASKINST`;

CREATE TABLE `ACT_HI_TASKINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `CLAIM_TIME_` datetime DEFAULT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `LAST_UPDATED_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




DROP TABLE IF EXISTS `ACT_HI_TSK_LOG`;

CREATE TABLE `ACT_HI_TSK_LOG` (
  `ID_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TIME_STAMP_` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_HI_VARINST`;

CREATE TABLE `ACT_HI_VARINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT 1,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_ID_BYTEARRAY`;

CREATE TABLE `ACT_ID_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_ID_GROUP`;

CREATE TABLE `ACT_ID_GROUP` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_ID_INFO`;

CREATE TABLE `ACT_ID_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob DEFAULT NULL,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_ID_PRIV`;

CREATE TABLE `ACT_ID_PRIV` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_ID_PRIV_MAPPING`;

CREATE TABLE `ACT_ID_PRIV_MAPPING` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`),
  KEY `ACT_IDX_PRIV_USER` (`USER_ID_`),
  KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `ACT_ID_PRIV` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_ID_PROPERTY`;

CREATE TABLE `ACT_ID_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




DROP TABLE IF EXISTS `ACT_ID_TOKEN`;

CREATE TABLE `ACT_ID_TOKEN` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATE_` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




DROP TABLE IF EXISTS `ACT_ID_USER`;

CREATE TABLE `ACT_ID_USER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DISPLAY_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;

CREATE TABLE `ACT_ID_MEMBERSHIP` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;

CREATE TABLE `ACT_RE_DEPLOYMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;

CREATE TABLE `ACT_GE_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob DEFAULT NULL,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;






DROP TABLE IF EXISTS `ACT_RE_MODEL`;

CREATE TABLE `ACT_RE_MODEL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;

CREATE TABLE `ACT_RE_PROCDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_VERSION_` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_PROCDEF_INFO`;

CREATE TABLE `ACT_PROCDEF_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_ACTINST`;

CREATE TABLE `ACT_RU_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT 1,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`),
  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`),
  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`),
  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`),
  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;






DROP TABLE IF EXISTS `ACT_RU_ENTITYLINK`;

CREATE TABLE `ACT_RU_ENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;








DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;

CREATE TABLE `ACT_RU_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
  `TASK_COUNT_` int(11) DEFAULT NULL,
  `JOB_COUNT_` int(11) DEFAULT NULL,
  `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
  `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;




DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;

CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT current_timestamp(),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `ACT_RU_DEADLETTER_JOB`;

CREATE TABLE `ACT_RU_DEADLETTER_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_HISTORY_JOB`;

CREATE TABLE `ACT_RU_HISTORY_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;









DROP TABLE IF EXISTS `ACT_RU_JOB`;

CREATE TABLE `ACT_RU_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_RU_SUSPENDED_JOB`;

CREATE TABLE `ACT_RU_SUSPENDED_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_RU_TASK`;

CREATE TABLE `ACT_RU_TASK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CLAIM_TIME_` datetime DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  `SUB_TASK_COUNT_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;

CREATE TABLE `ACT_RU_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



DROP TABLE IF EXISTS `ACT_RU_TIMER_JOB`;

CREATE TABLE `ACT_RU_TIMER_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;





DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;

CREATE TABLE `ACT_RU_VARIABLE` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`)
VALUES
	('cfg.execution-related-entities-count','true',1),
	('cfg.task-related-entities-count','true',1),
	('common.schema.version','6.4.1.3',1),
	('entitylink.schema.version','6.4.1.3',1),
	('identitylink.schema.version','6.4.1.3',1),
	('job.schema.version','6.4.1.3',1),
	('next.dbid','1',1),
	('schema.history','create(6.4.1.3)',1),
	('schema.version','6.4.1.3',1),
	('task.schema.version','6.4.1.3',1),
	('variable.schema.version','6.4.1.3',1);


INSERT INTO `ACT_ID_PROPERTY` (`NAME_`, `VALUE_`, `REV_`)
VALUES
	('schema.version','6.4.1.3',1);

commit;
CREATE DATABASE IF NOT EXISTS `market_future` default charset utf8 COLLATE utf8_general_ci;

USE market_future;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name       : dev_jmhb
password        : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/



/*
2.6 交易中心(tr)
*/

-- 2.6.1  tr_market_group 市场集团

DROP TABLE IF EXISTS `tr_market_group`;
CREATE TABLE `tr_market_group` (
  id  bigint NOT NULL auto_increment,
  group_name  varchar(20) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) DEFAULT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_market_group unique (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.7  tr_trading_time 交易时间

DROP TABLE IF EXISTS `tr_trading_time`;
CREATE TABLE `tr_trading_time` (
  id  bigint NOT NULL auto_increment,
  name  varchar(30) NOT NULL,
  `type`	char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) DEFAULT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_trading_time unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.2  tr_p_market 市场

DROP TABLE IF EXISTS `tr_p_market`;
CREATE TABLE `tr_p_market` (
  market_code char(3) NOT NULL,
  market_name varchar(20) NOT NULL,
  trading_time  bigint NOT NULL,
  group_id  bigint DEFAULT NULL,
  PRIMARY KEY (`market_code`),
  CONSTRAINT `fk_tr_p_market_trading_time` FOREIGN KEY (`trading_time`) REFERENCES `tr_trading_time` (`id`),
  CONSTRAINT `fk_tr_p_market_group_id` FOREIGN KEY (`group_id`) REFERENCES `tr_market_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.3  tr_trading_days 交易日

DROP TABLE IF EXISTS `tr_trading_days`;
CREATE TABLE `tr_trading_days` (
  market_code char(3) NOT NULL,
  open_day  char(8) NOT NULL,
  remark  varchar(255) DEFAULT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) DEFAULT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`market_code`,`open_day`),
  CONSTRAINT `fk_tr_trading_days` FOREIGN KEY (`market_code`) REFERENCES `tr_p_market` (`market_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.4  tr_subject 标的

DROP TABLE IF EXISTS `tr_subject`;
CREATE TABLE `tr_subject` (
  subject_code  varchar(20) NOT NULL,
  market_code char(3) NOT NULL,
  name  varchar(30) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`subject_code`),
  CONSTRAINT `fk_tr_subject` FOREIGN KEY (`market_code`) REFERENCES `tr_p_market` (`market_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;






-- 2.6.5  tr_product 产品

DROP TABLE IF EXISTS `tr_product`;
CREATE TABLE `tr_product` (
  product_code  varchar(20) NOT NULL,
  subject_code  varchar(20) NOT NULL,
  name  varchar(30) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`product_code`),
  CONSTRAINT `fk_tr_product` FOREIGN KEY (`subject_code`) REFERENCES `tr_subject` (`subject_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.6  tr_p_formula 通用计算公式

DROP TABLE IF EXISTS `tr_p_formula`;
CREATE TABLE `tr_p_formula` (
  formula_code  varchar(20) NOT NULL,
  formula_name  varchar(30) NOT NULL,
  description varchar(255) NOT NULL,
  argument  varchar(255) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) DEFAULT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`formula_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





-- 2.6.8  tr_trading_time_item 交易时间项

DROP TABLE IF EXISTS `tr_trading_time_item`;
CREATE TABLE `tr_trading_time_item` (
  id  bigint NOT NULL auto_increment,
  policy_id bigint NOT NULL,
  seq int NOT NULL default 0,
  start_time  char(4) NOT NULL default '0',
  end_time  char(4) NOT NULL default '0',
  status  char(1) NOT NULL default '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_trading_time_item` FOREIGN KEY (`policy_id`) REFERENCES `tr_trading_time` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.9  tr_margin_rule 保证金策略

DROP TABLE IF EXISTS `tr_margin_rule`;
CREATE TABLE `tr_margin_rule` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) DEFAULT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_margin_rule unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.10 tr_margin_rule_phase 保证金阶段

DROP TABLE IF EXISTS `tr_margin_rule_phase`;
CREATE TABLE `tr_margin_rule_phase` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  is_init bool NOT NULL,
  before_times  int NOT NULL default 0,
  unit  char(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_margin_rule_phase` FOREIGN KEY (`rule_id`) REFERENCES `tr_margin_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.11 tr_margin_rule_step 保证金阶梯

DROP TABLE IF EXISTS `tr_margin_rule_step`;
CREATE TABLE `tr_margin_rule_step` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  min_qty decimal(30,13) NOT NULL,
  type  char(1) NOT NULL,
  buy decimal(30,13) NOT NULL,
  sell  decimal(30,13) NOT NULL,
  price_type  char(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_margin_rule_step` FOREIGN KEY (`rule_id`) REFERENCES `tr_margin_rule_phase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.12 tr_trading_fee_rule 交易费策略

DROP TABLE IF EXISTS `tr_trading_fee_rule`;
CREATE TABLE `tr_trading_fee_rule` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  type  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_trading_fee_rule unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.13 tr_trading_fee_rule_item 交易费内容

DROP TABLE IF EXISTS `tr_trading_fee_rule_item`;
CREATE TABLE `tr_trading_fee_rule_item` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  item  char(2) NOT NULL,
  type  char(1) NOT NULL,
  value decimal(30,13) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_trading_fee_rule_item` FOREIGN KEY (`rule_id`) REFERENCES `tr_trading_fee_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.14 tr_trading_sfd 费率sfd策略

DROP TABLE IF EXISTS `tr_trading_sfd`;
CREATE TABLE `tr_trading_sfd` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_trading_sfd unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.15 tr_trading_sfd_item 费率sfd策略项

DROP TABLE IF EXISTS `tr_trading_sfd_item`;
CREATE TABLE `tr_trading_sfd_item` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  price_dif decimal(30,13) NOT NULL,
  value decimal(30,13) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_trading_sfd_item` FOREIGN KEY (`rule_id`) REFERENCES `tr_trading_sfd` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.16 tr_trading_bs 费率bs策略

DROP TABLE IF EXISTS `tr_trading_bs`;
CREATE TABLE `tr_trading_bs` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  trading_price_type  char(1) NOT NULL,
  trading_price_value decimal(30,13) NOT NULL,
  base_price_type char(1) NOT NULL,
  base_price_value  decimal(30,13) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_trading_bs unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.17 tr_trading_permission 交易权

DROP TABLE IF EXISTS `tr_trading_permission`;
CREATE TABLE `tr_trading_permission` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  max_qty decimal(30,13) NOT NULL,
  max_order_count decimal(30,13) NOT NULL,
  max_con_order_count decimal(30,13) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_trading_permission unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.18 tr_trading_permission_item 交易权限内容

DROP TABLE IF EXISTS `tr_trading_permission_item`;
CREATE TABLE `tr_trading_permission_item` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  item  char(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_trading_permission_item` FOREIGN KEY (`rule_id`) REFERENCES `tr_trading_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.20 tr_contract 合约

DROP TABLE IF EXISTS `tr_contract`;
CREATE TABLE `tr_contract` (
  contract_id varchar(60) NOT NULL,
  contract_name varchar(120) NOT NULL,
  product_code  varchar(20) NOT NULL,
  subject_code  varchar(20) NOT NULL,
  market_code char(3) NOT NULL,
  order_currency  varchar(10) NOT NULL,
  currency  varchar(10) NOT NULL,
  type  char(1) NOT NULL,
  status  char(1) DEFAULT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`contract_id`),
  CONSTRAINT uk_tr_contract unique (`contract_name`),
  CONSTRAINT `fk_tr_contract_product_code` FOREIGN KEY (`product_code`) REFERENCES `tr_product` (`product_code`),
  CONSTRAINT `fk_tr_contract_market_code` FOREIGN KEY (`market_code`) REFERENCES `tr_p_market` (`market_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.19 tr_contract_futures_temp 期货合约模板

DROP TABLE IF EXISTS `tr_contract_futures_temp`;
CREATE TABLE `tr_contract_futures_temp` (
  id  bigint NOT NULL auto_increment,
  cid_prefix  varchar(20),
  name_prefix varchar(40),
  product_code  varchar(20) NOT NULL,
  subject_code  varchar(20) NOT NULL,
  market_code char(3) NOT NULL,
  order_currency  varchar(10) NOT NULL,
  currency  varchar(10) NOT NULL,
  type  char(1) NOT NULL,
  init_price_type char(1) NOT NULL,
  init_price_value	decimal(30,13) NOT NULL,
  init_price_ratio	decimal(30,13) NOT NULL,
  settled_type  char(1) NOT NULL,
  begin_day_rule  char(1) NOT NULL,
  end_day_rule  char(1) NOT NULL,
  min_qty decimal(30,13) NOT NULL default 0,
  max_qty decimal(30,13) NOT NULL default 0,
  step  decimal(30,13) NOT NULL default 0,
  multiplier  decimal(30,13) NOT NULL default 0,
  mark_price_type char(1) NOT NULL,
  mark_price_type_value decimal(30,13) NOT NULL,
  settled_price_type  char(1)  NOT NULL,
  settled_price_value decimal(30,13) NOT NULL,
  balance_price char(1) NOT NULL,
  time_limit_type  char(1) NOT NULL,
  delivery_type char(1) NOT NULL,
  delivery_price_type  char(1) NOT NULL,
  delivery_price_value  decimal(30,13) NOT NULL,
  ffp_type  char(1) NOT NULL,
  ffp_value decimal(30,13) NOT NULL default 0,
  ffp_base_line char(1) NOT NULL,
  fuse_limit  decimal(30,13) NOT NULL default 0,
  per_fuse_time	int  NOT NULL, 
  fuse_time int  NOT NULL,
  fuse_price_type char(1) NOT NULL,
  first_up_limit  decimal(30,13) NOT NULL default 0,
  first_down_limit  decimal(30,13) NOT NULL default 0,
  up_limit  decimal(30,13) NOT NULL default 0,
  down_limit  decimal(30,13) NOT NULL default 0,
  last_up_limit decimal(30,13) NOT NULL default 0,
  last_down_limit decimal(30,13) NOT NULL default 0,
  first_trading_time  bigint DEFAULT NULL,
  trading_time  bigint NOT NULL,
  last_trading_time bigint DEFAULT NULL,
  margin_rule_id  bigint NOT NULL,
  trading_fee_rule_id bigint NOT NULL,
  trading_perm_rule_id  bigint NOT NULL,
  sfd_id  bigint DEFAULT NULL,
  bs_id bigint DEFAULT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_contract_futures_temp_product_code` FOREIGN KEY (`product_code`) REFERENCES `tr_product` (`product_code`),
  CONSTRAINT `fk_tr_contract_futures_temp_market_code` FOREIGN KEY (`market_code`) REFERENCES `tr_p_market` (`market_code`),
  CONSTRAINT `fk_tr_contract_futures_temp_trading_time` FOREIGN KEY (`trading_time`) REFERENCES `tr_trading_time` (`id`),
  CONSTRAINT `fk_tr_contract_futures_temp_margin_rule_id` FOREIGN KEY (`margin_rule_id`) REFERENCES `tr_margin_rule` (`id`),
  CONSTRAINT `fk_tr_contract_futures_temp_trading_fee_rule_id` FOREIGN KEY (`trading_fee_rule_id`) REFERENCES `tr_trading_fee_rule` (`id`),
  CONSTRAINT `fk_tr_contract_futures_temp_tradingpermrule` FOREIGN KEY (`trading_perm_rule_id`) REFERENCES `tr_trading_permission` (`id`),
  CONSTRAINT `fk_tr_contract_futures_temp_sfd_id` FOREIGN KEY (`sfd_id`) REFERENCES `tr_trading_sfd` (`id`),
  CONSTRAINT `fk_tr_contract_futures_temp_tr_trading_bs` FOREIGN KEY (`bs_id`) REFERENCES `tr_trading_bs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





--  2.6.21  tr_contract_futures 期货合约信息

DROP TABLE IF EXISTS `tr_contract_futures`;
CREATE TABLE `tr_contract_futures` (
  contract_id varchar(60) NOT NULL,
  `sequence`	bigint  NOT NULL auto_increment,
  contract_name varchar(120) NOT NULL,
  product_code  varchar(20) NOT NULL,
  subject_code  varchar(20) NOT NULL,
  market_code char(3) NOT NULL,
  order_currency  varchar(10) NOT NULL,
  currency  varchar(10) NOT NULL,
  type  char(1) NOT NULL,
  status  char(1) DEFAULT NULL,
  initprice decimal(30,13) NOT NULL,
  settled_type  char(1) NOT NULL,
  begin_day varchar(8) NOT NULL,
  end_day varchar(8) DEFAULT NULL,
  min_qty decimal(30,13) NOT NULL default 0,
  max_qty decimal(30,13) NOT NULL default 0,
  step  decimal(30,13) NOT NULL default 0,
  multiplier  decimal(30,13) NOT NULL default 0,
  mark_price_type char(1) NOT NULL,
  mark_price_type_value decimal(30,13) NOT NULL,
  settled_price_type  char(1)  NOT NULL,
  settled_price_value decimal(30,13) NOT NULL,
  balance_price char(1) NOT NULL,
  time_limit_type  char(1) NOT NULL,
  delivery_type char(1) NOT NULL,
  delivery_price_type char(1) NOT NULL,
  delivery_price_value  decimal(30,13) NOT NULL,
  ffp_type  char(1) NOT NULL,
  ffp_value decimal(30,13) NOT NULL default 0,
  ffp_base_line char(1) NOT NULL,
  fuse_limit  decimal(30,13) NOT NULL default 0,
  per_fuse_time	int  NOT NULL, 
  fuse_time int  NOT NULL,
  fuse_price_type char(1) NOT NULL,
  first_up_limit  decimal(30,13) NOT NULL default 0,
  first_down_limit  decimal(30,13) NOT NULL default 0,
  up_limit  decimal(30,13) NOT NULL default 0,
  down_limit  decimal(30,13) NOT NULL default 0,
  last_up_limit decimal(30,13) NOT NULL default 0,
  last_down_limit decimal(30,13) NOT NULL default 0,
  first_trading_time  bigint DEFAULT NULL,
  trading_time  bigint NOT NULL,
  last_trading_time bigint DEFAULT NULL,
  margin_rule_id  bigint NOT NULL,
  trading_fee_rule_id bigint NOT NULL,
  trading_perm_rule_id  bigint NOT NULL,
  sfd_id  bigint DEFAULT NULL,
  bs_id bigint DEFAULT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  CONSTRAINT uk_tr_contract_futures unique (`contract_id`),
  CONSTRAINT `uk_contract_futures_sequence` unique (`sequence`),
  CONSTRAINT uk_tr_contract_futures_contract_name unique (`contract_name`),
  CONSTRAINT `fk_tr_contract_futures_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `tr_contract` (`contract_id`),
  CONSTRAINT `fk_tr_contract_futures_product_code` FOREIGN KEY (`product_code`) REFERENCES `tr_product` (`product_code`),
  CONSTRAINT `fk_tr_contract_futures_market_code` FOREIGN KEY (`market_code`) REFERENCES `tr_p_market` (`market_code`),
  CONSTRAINT `fk_tr_contract_futures_first_trading_time` FOREIGN KEY (`first_trading_time`) REFERENCES `tr_trading_time` (`id`),
  CONSTRAINT `fk_tr_contract_futures_trading_time` FOREIGN KEY (`trading_time`) REFERENCES `tr_trading_time` (`id`),
  CONSTRAINT `fk_tr_contract_futures_last_trading_time` FOREIGN KEY (`last_trading_time`) REFERENCES `tr_trading_time` (`id`),
  CONSTRAINT `fk_tr_contract_futures_margin_rule_id` FOREIGN KEY (`margin_rule_id`) REFERENCES `tr_margin_rule` (`id`),
  CONSTRAINT `fk_tr_contract_futures_trading_fee_rule_id` FOREIGN KEY (`trading_fee_rule_id`) REFERENCES `tr_trading_fee_rule` (`id`),
  CONSTRAINT `fk_tr_contract_futures_trading_perm_rule_id` FOREIGN KEY (`trading_perm_rule_id`) REFERENCES `tr_trading_permission` (`id`),
  CONSTRAINT `fk_tr_contract_futures_sfd_id` FOREIGN KEY (`sfd_id`) REFERENCES `tr_trading_sfd` (`id`),
  CONSTRAINT `fk_tr_contract_futures_bs_id` FOREIGN KEY (`bs_id`) REFERENCES `tr_trading_bs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



--  2.6.22  tr_account 交易账户

DROP TABLE IF EXISTS `tr_account`;
CREATE TABLE `tr_account` (
  account_id  varchar(32) NOT NULL,
  status  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--  2.6.23  tr_account_rule 交易特殊策略

DROP TABLE IF EXISTS `tr_account_rule`;
CREATE TABLE `tr_account_rule` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_account_rule unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.24 tr_account_rule_item 交易特殊策略项

DROP TABLE IF EXISTS `tr_account_rule_item`;
CREATE TABLE `tr_account_rule_item` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  type  char(1) NOT NULL,
  type_value  varchar(60) NOT NULL,
  rule_type char(1) NOT NULL,
  rule_type_value bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tr_account_rule_item` FOREIGN KEY (`rule_id`) REFERENCES `tr_account_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.25 tr_account_rule_accounts 交易特殊策略和账户关系表

DROP TABLE IF EXISTS `tr_account_rule_accounts`;
CREATE TABLE `tr_account_rule_accounts` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  account_id  varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_account_rule_accounts unique (`rule_id`,`account_id`),
  CONSTRAINT `fk_tr_account_rule_accounts` FOREIGN KEY (`rule_id`) REFERENCES `tr_account_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.26 tr_hedging_rule 交易对冲策略

DROP TABLE IF EXISTS `tr_hedging_rule`;
CREATE TABLE `tr_hedging_rule` (
  id  bigint NOT NULL auto_increment,
  name  varchar(40) NOT NULL,
  type  char(1) NOT NULL,
  type_value  varchar(20) NOT NULL,
  rate  decimal(30,13) NOT NULL,
  effective_type  char(1) NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_hedging_rule unique (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.6.27 tr_hedging_rule_accounts 对冲策略和账户关系表

DROP TABLE IF EXISTS `tr_hedging_rule_accounts`;
CREATE TABLE `tr_hedging_rule_accounts` (
  id  bigint NOT NULL auto_increment,
  rule_id bigint NOT NULL,
  account_id  varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT uk_tr_hedging_rule_accounts unique (`rule_id`,`account_id`),
  CONSTRAINT `fk_tr_hedging_rule_accounts` FOREIGN KEY (`rule_id`) REFERENCES `tr_hedging_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.28 tr_trading_status 交易状态

DROP TABLE IF EXISTS `tr_trading_status`;
CREATE TABLE `tr_trading_status` (
  type  char(1) NOT NULL,
  value varchar(60) NOT NULL,
  state char(1) NOT NULL,
  pre_state char(1) DEFAULT NULL,
  resume_time timestamp,
  fuse_state  char(1) DEFAULT NULL,
  create_operator bigint DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  update_operator bigint DEFAULT NULL,
  update_time datetime(6) DEFAULT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.29	tr_trading_status_change  交易状态变更

DROP TABLE IF EXISTS `tr_trading_status_change`;
CREATE TABLE `tr_trading_status_change` (
	id	bigint NOT NULL auto_increment,
	`type`	char(1) NOT NULL,
	`value`	varchar(60) NOT NULL,
	`state`	char(1) NOT NULL,
	`start_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
	`end_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
	valid	char(1) NOT NULL,
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.30 tr_order 报单

DROP TABLE IF EXISTS `tr_order`;
CREATE TABLE `tr_order` (
  order_id  bigint NOT NULL,
  client_order_id varchar(20) DEFAULT NULL,
  price decimal(30,13) NOT NULL,
  quantity  decimal(30,13) NOT NULL,
  contract_id varchar(60) NOT NULL,
  product_code  varchar(30) NOT NULL,
  account_id  varchar(30) NOT NULL,
  side  bool NOT NULL,
  offset_flag char(1) NOT NULL,
  stp char(1) NOT NULL,
  price_type  char(1) NOT NULL,
  order_type  char(1) NOT NULL,
  order_flag	char(1) NOT NULL default '0',
  time_in_force char(1) NOT NULL,
  expire_time datetime(6),
  post_only bool NOT NULL default '0',
  stop  char(1) DEFAULT NULL,
  stop_price  decimal(30,13) DEFAULT NULL,
  stop_price_type char(1) DEFAULT NULL,
  hide_flag char(1) NOT NULL default '0',
  display_qty decimal(30,13) NOT NULL default '0',
  fill_fees decimal(30,13) NOT NULL default '0',
  frozen_fee decimal(30,13) NOT NULL default '0',
  balance decimal(30,13) NOT NULL default '0',
  filled  decimal(30,13) NOT NULL default '0',
  executed_value  decimal(30,13) NOT NULL default '0',
  margin_rate decimal(30,13) NOT NULL default '0',
  frozen  decimal(30,13) NOT NULL default '0',
  holds decimal(30,13) NOT NULL default '0',
  orignal char(1) NOT NULL,
  order_ip  varchar(20) NOT NULL,
  cancel_ip varchar(20) DEFAULT NULL,
  created_time  datetime(6) NOT NULL,
  cancel_time datetime(6) DEFAULT NULL,
  status  char(1) NOT NULL,
  setteled  char(1) NOT NULL default '0',
  create_operator bigint DEFAULT NULL,
  create_account_id   varchar(20) NOT NULL,
  cancel_operator	bigint,
  cancel_account_id	varchar(30),
  version bigint NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.31 tr_order_conditoin   条件报单

DROP TABLE IF EXISTS `tr_order_conditoin`;
CREATE TABLE `tr_order_conditoin` (
  condition_order_id  bigint NOT NULL auto_increment,
  client_order_id varchar(20) DEFAULT NULL,
  price decimal(30,13)  NOT NULL,
  quantity  decimal(30,13)  NOT NULL,
  contract_id varchar(60)  NOT NULL,
  product_code  varchar(30)  NOT NULL,
  account_id  varchar(30)  NOT NULL,
  side  bool  NOT NULL,
  offset_flag char(1)  NOT NULL,
  stp char(1)  NOT NULL,
  price_type  char(1)  NOT NULL,
  order_type  char(1)  NOT NULL,
  time_in_force char(1)  NOT NULL,
  expire_time datetime(6),
  post_only bool NOT NULL default 0,
  stop  char(1) NOT NULL default 0,
  stop_price  decimal(30,13)  NOT NULL,
  stop_price_type char(1)  NOT NULL,
  hide_flag char(1) NOT NULL default 0,
  display_qty decimal(30,13) NOT NULL default 0,
  orignal char(1)  NOT NULL,
  order_ip  varchar(20)  NOT NULL,
  cancel_ip varchar(20) DEFAULT NULL,
  created_time  datetime(6)  NOT NULL,
  cancel_time datetime(6) DEFAULT NULL,
  status  char(1)  NOT NULL,
  create_operator bigint DEFAULT NULL,
  create_account_id   varchar(20) NOT NULL,
  cancel_operator	bigint,
  cancel_account_id	varchar(30),
  version bigint  NOT NULL,
  active_quantity decimal(30,13) NOT NULL default 0,
  order_id  bigint,
  remark	varchar(255)  DEFAULT NULL,
  PRIMARY KEY (`condition_order_id`,`side`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.32 tr_fill 成交记录

DROP TABLE IF EXISTS `tr_fill`;
CREATE TABLE `tr_fill` (
  fill_id bigint NOT NULL,
  side  bool  NOT NULL,
  order_id  bigint NOT NULL,
  contract_id varchar(60) NOT NULL,
  product_code  varchar(30) NOT NULL,
  account_id  varchar(30) NOT NULL,
  price decimal(30,13) NOT NULL,
  quantity  decimal(30,13) NOT NULL,
  fill_flag char(1)  NOT NULL default '0',
  offset_flag char(1) NOT NULL,
  liquidity char(1) NOT NULL,
  fee decimal(30,13) NOT NULL default 0,
  margin  decimal(30,13) NOT NULL default 0,
  open_cost decimal(30,13) NOT NULL,
  position_cost decimal(30,13) NOT NULL,
  balance decimal(30,13) NOT NULL,
  opp_order_id  bigint NOT NULL,
  created_time  datetime(6) NOT NULL,
  order_price decimal(30,13) DEFAULT NULL,
  order_quantity  decimal(30,13) DEFAULT NULL,
  order_filled  decimal(30,13) DEFAULT NULL,
  order_price_type  char(1) DEFAULT NULL,
  sfd_price_spread  decimal(30,13)  NOT NULL,
  sfd_amount  decimal(30,13)  NOT NULL,
  PRIMARY KEY (`fill_id`,`side`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.6.33 tr_position 持仓

DROP TABLE IF EXISTS `tr_position`;
CREATE TABLE `tr_position` (
  position_id bigint NOT NULL,
  contract_id varchar(60) NOT NULL,
  product_code  varchar(30) NOT NULL,
  account_id  varchar(30) NOT NULL,
  side  bool NOT NULL,
  open_cost decimal(30,13) NOT NULL default 0,
  position_cost decimal(30,13) NOT NULL default 0,
  qty decimal(30,13) NOT NULL default 0,
  avalible_qty  decimal(30,13) NOT NULL default 0,
  close_fronzen decimal(30,13) NOT NULL default 0,
  margin  decimal(30,13) NOT NULL default 0,
  settled_time  datetime(6) NOT NULL,
  version bigint NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.6.34	tr_spot_index_config   现货指数人工介入

DROP TABLE IF EXISTS `tr_spot_index_config`;
CREATE TABLE `tr_spot_index_config` (
	id	bigint NOT NULL auto_increment,
	subject_code	varchar(20) NOT NULL,
	spot_price	decimal(30,13) NOT NULL default 0,
	status	char(1) NOT NULL,
	remark	varchar(500),
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_tr_spot_index_config` FOREIGN KEY (`subject_code`) REFERENCES `tr_subject` (`subject_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO tr_trading_time(`name`,`type`, `create_time`,`version`) VALUES ('市场交易时间','1',' 2019-06-06','0');

INSERT INTO tr_trading_time_item(`policy_id`, `seq`,`start_time`,`end_time`,`status`) VALUES ((SELECT id FROM tr_trading_time WHERE `name`='市场交易时间'),' 1','0800','0800','4');

INSERT INTO tr_p_market(`market_code`, `market_name`,`trading_time`) VALUES ('001',' 加密货币市场', (SELECT id FROM tr_trading_time WHERE `name`='市场交易时间'));CREATE DATABASE IF NOT EXISTS `nc` default charset utf8 COLLATE utf8_general_ci;

USE nc;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name       : dev_jmhb
password        : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/




/*
2.3 通知和公告(nc)
*/


DROP TABLE IF EXISTS `nc_notice`;
CREATE TABLE `nc_notice` (
  id  bigint NOT NULL auto_increment,
  customer_id varchar(20) NOT NULL,
  title varchar(60) NOT NULL,
  content varchar(255) DEFAULT NULL,
  create_time datetime(6) NOT NULL,
  isread  bool NOT NULL default '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;







CREATE DATABASE IF NOT EXISTS `cl` default charset utf8 COLLATE utf8_general_ci;

USE cl;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name			  : dev_jmhb
password			  : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/



/*
2.7	结算中心(cl)
*/

-- 2.7.1	cl_position_report 每日结算持仓报表

DROP TABLE IF EXISTS `cl_position_report`;
CREATE TABLE `cl_position_report` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	currency	varchar(10) NOT NULL,
	product_code	varchar(30) NOT NULL,
	account_id	varchar(30) NOT NULL,
	side	bool NOT NULL,
	open_cost	decimal(30,13) NOT NULL default 0,
	position_cost	decimal(30,13) NOT NULL default 0,
	qty	decimal(30,13) NOT NULL default 0,
	margin	decimal(30,13) NOT NULL default 0,
	settled_price	decimal(30,13) NOT NULL default 0,
	last_settled_price	decimal(30,13) NOT NULL default 0,
	settled_balance	decimal(30,13) NOT NULL default 0,
	settled_fee	decimal(30,13) NOT NULL default 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.7.2	cl_bs_report 每日结算bs报表

DROP TABLE IF EXISTS `cl_bs_report`;
CREATE TABLE `cl_bs_report` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	currency varchar(10) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	product_code	varchar(30) NOT NULL,
	account_id	varchar(30) NOT NULL,
	side	bool  NOT NULL,
	qty	decimal(30,13) NOT NULL default 0,
	bs_spot_price	decimal(30,13) NOT NULL default 0,
	bs_trade_price	decimal(30,13) NOT NULL default 0,
	bs	decimal(30,13) NOT NULL default 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 2.7.3	cl_account_asset_report 每日资金报表

DROP TABLE IF EXISTS `cl_account_asset_report`;
CREATE TABLE `cl_account_asset_report` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	account_id	varchar(32) NOT NULL,
	cur_account_id	bigint NOT NULL,
	currency	varchar(10) NOT NULL,
	wallet_balance	decimal(30,13) NOT NULL DEFAULT 0,
	settled_balance	decimal(30,13) NOT NULL DEFAULT 0,
	daily_fee	decimal(30,13) NOT NULL DEFAULT 0,
	daily_balance	decimal(30,13) NOT NULL DEFAULT 0,
	daily_sfd  decimal(30,13) NOT NULL DEFAULT 0,
	trade_running_id	bigint NOT NULL DEFAULT 0,
	settled_running_id	bigint NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.7.4	cl_settled_price 每日结算价

DROP TABLE IF EXISTS `cl_settled_price`;
CREATE TABLE `cl_settled_price` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	currency	varchar(10) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	settled_price	decimal(30,13) NOT NULL DEFAULT 0,
	per_settled_price	decimal(30,13) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.7.5	cl_settled_bs_price 每日bs结算价格

DROP TABLE IF EXISTS `cl_settled_bs_price`;
CREATE TABLE `cl_settled_bs_price` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	currency	varchar(10) NOT NULL,
	spot_price	decimal(30,13) NOT NULL DEFAULT 0,
	trade_price	decimal(30,13) NOT NULL DEFAULT 0,
	price_diff	decimal(30,13) NOT NULL DEFAULT 0,
	price_diff_rate	decimal(30,13) NOT NULL DEFAULT 0,
	change_point	decimal(30,13) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.7.6	cl_settled_fill_flag  每日结算成交单标识

DROP TABLE IF EXISTS `cl_settled_fill_flag`;
CREATE TABLE `cl_settled_fill_flag` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	currency	varchar(10) NOT NULL,
	fill_id	bigint NOT NULL,
	last_fill_id	bigint NOT NULL,
	risk_fill_id	bigint NOT NULL DEFAULT 0,
	last_risk_fill_id	bigint NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.7.7	cl_settled_dev_price  到期交割结算价

DROP TABLE IF EXISTS `cl_settled_dev_price`;
CREATE TABLE `cl_settled_dev_price` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	end_day	char(8) NOT NULL,
	delivery_price	decimal(30,13) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




-- 2.7.8	cl_daily_contract_quo 每日合约行情统计

DROP TABLE IF EXISTS `cl_daily_contract_quo`;
CREATE TABLE `cl_daily_contract_quo` (
	id	bigint NOT NULL AUTO_INCREMENT,
	`time`	datetime(6) NOT NULL,
	market_code	char(3) NOT NULL,
	contract_id	varchar(60) NOT NULL,
	currency	varchar(10) NOT NULL,
	subject_code	varchar(20) NOT NULL,
	`open`	decimal(30,13) NOT NULL DEFAULT 0,
	high	decimal(30,13) NOT NULL DEFAULT 0,
	low	decimal(30,13) NOT NULL DEFAULT 0,
	`close`	decimal(30,13) NOT NULL DEFAULT 0,
	settled_price	decimal(30,13) NOT NULL DEFAULT 0,
	per_settled_price	decimal(30,13) NOT NULL DEFAULT 0,
	settled_change_point	decimal(30,13) NOT NULL DEFAULT 0,
	fill_qtt	decimal(30,13) NOT NULL DEFAULT 0,
	fill_amount	decimal(30,13) NOT NULL DEFAULT 0,
	position_qtt	decimal(30,13) NOT NULL DEFAULT 0,
	settled_position_value	decimal(30,13) NOT NULL DEFAULT 0,
	position_diff	decimal(30,13) NOT NULL DEFAULT 0,
	spot_price	decimal(30,13) NOT NULL DEFAULT 0,
	mark_price	decimal(30,13) NOT NULL DEFAULT 0,
	multiplier	decimal(30,13) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.7.9	cl_daily_market_quo  每日市场行情统计

DROP TABLE IF EXISTS `cl_daily_market_quo`;
CREATE TABLE `cl_daily_market_quo` (
	id	bigint NOT NULL AUTO_INCREMENT,
	time	datetime(6) NOT NULL,
	market_code	char(3) NOT NULL,
	currency	varchar(10) NOT NULL,
	subject_code	varchar(20) NOT NULL,
	spot_price	decimal(30,13) NOT NULL DEFAULT 0,
	legal_cur_fill_amount	decimal(30,13) NOT NULL DEFAULT 0,
	position_amount	decimal(30,13) NOT NULL DEFAULT 0,
	fill_qtt	decimal(30,13) NOT NULL DEFAULT 0,
	fill_amount	decimal(30,13) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.7.10	cl_broker_fee_return   每日经纪人返佣

DROP TABLE IF EXISTS `cl_broker_fee_return`;
CREATE TABLE `cl_broker_fee_return` (
	id	bigint NOT NULL AUTO_INCREMENT,
	settled_time	datetime(6) NOT NULL,
	currency	varchar(10) NOT NULL,
	account_id	varchar(30) NOT NULL,
	broker_id	bigint NOT NULL,
	name	varchar(40) NOT NULL,
	amount	decimal(30,13) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.7.11	cl_clearing_fund   清算基金

DROP TABLE IF EXISTS `cl_clearing_fund`;
CREATE TABLE `cl_clearing_fund` (
	id	bigint NOT NULL AUTO_INCREMENT,
	`time`	datetime(6) NOT NULL,
	currency	varchar(10) NOT NULL,
	day_increase	decimal(30,13) NOT NULL DEFAULT 0,
	day_use	decimal(30,13) NOT NULL DEFAULT 0,
	balance	decimal(30,13) NOT NULL DEFAULT 0,
	remark	varchar(500) DEFAULT 0,
	create_operator	bigint,
	create_time	datetime(6) NOT NULL,
	update_operator	bigint,
	update_time	datetime(6),
	version	bigint NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.7.12	cl_account_profit  每日盈利排名

DROP TABLE IF EXISTS `cl_account_profit`;
CREATE TABLE `cl_account_profit` (
	id	bigint NOT NULL AUTO_INCREMENT,
	`time`	datetime(6) NOT NULL,
	currency	varchar(10) NOT NULL,
	account_id	varchar(32) NOT NULL,
	cur_account_id	bigint NOT NULL,
	name	varchar(40) NOT NULL,
	profit_amount	decimal(30,13) NOT NULL DEFAULT 0,
	profit_rate	decimal(30,13) NOT NULL DEFAULT 0,
	total_profit	decimal(30,13) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.7.13	cl_marketer_fee_return  每日经纪人返佣

DROP TABLE IF EXISTS `cl_marketer_fee_return`;
CREATE TABLE `cl_marketer_fee_return` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `settled_time` datetime(6) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `market_id` bigint(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `amount` decimal(30,13) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;CREATE DATABASE IF NOT EXISTS `ri` default charset utf8 COLLATE utf8_general_ci;

USE ri;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name			  : dev_jmhb
password			  : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/





/*
2.8	风控中心(ri)
*/




CREATE DATABASE IF NOT EXISTS `qu` default charset utf8 COLLATE utf8_general_ci;

USE qu;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name			  : dev_jmhb
password			  : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/




/*
2.9	行情(qu)
*/





CREATE DATABASE IF NOT EXISTS `mr` default charset utf8 COLLATE utf8_general_ci;

USE mr;
/*
navicat mysql data transfer

source server         : 虚拟货币
source server version : 50630
source host           : 192.168.1.41:3306
source database       : devjmhb
user_name			  : dev_jmhb
password			  : dev_jmhb

target server type    : mysql
target server version : 50630
file encoding         : 65001

date: 2019-04-23 10:25:02
*/




/*
2.10	邮件系统(mr)
*/


-- 2.10.1	mr_settings  系统设置

DROP TABLE IF EXISTS `mr_settings`;
CREATE TABLE `mr_settings` (
	mail_key	varchar(32) NOT NULL,
	mail_value	varchar(255) NOT NULL,
	description	varchar(255) NOT NULL,
	PRIMARY KEY (`mail_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- 2.10.2	mr_mail_subject 邮件主题

DROP TABLE IF EXISTS `mr_mail_subject`;
CREATE TABLE `mr_mail_subject` (
	subject	varchar(32) NOT NULL,
	description	varchar(255) NOT NULL,
	variables	TEXT NOT NULL,
	default_template	varchar(32) NOT NULL,
	PRIMARY KEY (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2.10.3	mr_mail_template 邮件模板

DROP TABLE IF EXISTS `mr_mail_template`;
CREATE TABLE `mr_mail_template` (
	subject	varchar(32) NOT NULL,
	lang	varchar(10) NOT NULL,
	title	varchar(512) NOT NULL,
	content	TEXT NOT NULL,
	PRIMARY KEY (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;







INSERT INTO `mr_mail_subject` VALUES ('EMAIL_VERIFY', '验证码', '验证', '验证码');
INSERT INTO `mr_mail_subject` VALUES ('Login', '登入通知', '登入通知', '登入通知');
INSERT INTO `mr_mail_subject` VALUES ('ForceCancel', '强撤通知', '强撤通知', '强撤通知');
INSERT INTO `mr_mail_subject` VALUES ('ForceClose', '强平通知', '强平通知', '强平通知');
INSERT INTO `mr_mail_subject` VALUES ('MarginCall', '追保通知', '追保通知', '追保通知');
INSERT INTO `mr_mail_subject` VALUES ('ForcePositionLowing', '自动减仓通知', '自动减仓通知', '自动减仓通知');
INSERT INTO `mr_mail_subject` VALUES ('DepositConfirm', '存款确认', '存款确认', '存款确认');
INSERT INTO `mr_mail_subject` VALUES ('WithdrawalsArrival', '提现完成', '提现完成', '提现完成');


INSERT INTO `mr_mail_template` VALUES ('EMAIL_VERIFY', 'zh', '验证码', '本次验证码：{token}。');

INSERT INTO `mr_mail_template` VALUES ('Login', 'zh-CN', '登入通知', '【Coinfurex】登入通知：您的账户在{currentDate}成功登入，如非本人操作，请及时联系客服。');
INSERT INTO `mr_mail_template` VALUES ('ForceCancel', 'zh-CN', '强撤通知', '【Coinfurex】强撤通知：您的账户在{currentDate}触发强撤，合约{contractId}的{side}方向,价格{price}的挂单{qty}张已被强制撤销。如有疑问，请联系客服。');
INSERT INTO `mr_mail_template` VALUES ('ForceClose', 'zh-CN', '强平通知', '【Coinfurex】强平通知：您的账户在{currentDate}触发强平，合约{contractId}的{side}方向持仓{qty}张已被强制平仓。如有疑问，请联系客服。');
INSERT INTO `mr_mail_template` VALUES ('MarginCall', 'zh-CN', '追保通知', '【Coinfurex】追保通知：您的{currency}账户权益已低于初始保证金的50%，存在风险，请及时补充资金或自行平仓，以免触发强平。');
INSERT INTO `mr_mail_template` VALUES ('ForcePositionLowing', 'zh-CN', '自动减仓通知', '【Coinfurex】自动减仓通知：您的账户下合约{contractId}的{side}方向,价格{price}的持仓已被自动减仓{qty}张，如有疑问，请联系客服。');
INSERT INTO `mr_mail_template` VALUES ('DepositConfirm', 'zh-CN', '存款确认', '【Coinfurex】存款确认：您的的账户在{currentDate}完成充币{currency}+{amount}，账户余额{currency}:{leftAmount}。');
INSERT INTO `mr_mail_template` VALUES ('WithdrawalsArrival', 'zh-CN', '提现完成', '【Coinfurex】提现完成：你的账户在{currentDate}已完成提币{currency}+{amount}，账户余额{currency}:{leftAmount}。');

INSERT INTO `mr_settings` VALUES ('password', 'Qumo@20181207', 'password');
INSERT INTO `mr_settings` VALUES ('smtphost', 'smtp', 'smtphost');
INSERT INTO `mr_settings` VALUES ('smtpport', '25', 'smtpport');
INSERT INTO `mr_settings` VALUES ('username', 'noreply@thecfex.com', 'username');

