CREATE TABLE `enterprise_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `guid` binary(16) NOT NULL COMMENT '全局唯一ID',
  `body` mediumblob NOT NULL COMMENT '附件内容',
  `created` datetime NOT NULL COMMENT '上传日期（时间）',
  `content_type` varchar(30) NOT NULL COMMENT '内容类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mutex` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件表';

CREATE TABLE `enterprise_inquiries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `guid` binary(16) NOT NULL COMMENT '全局唯一ID',
  `subject` varchar(100) NOT NULL COMMENT '标题',
  `message` text NOT NULL COMMENT '内容',
  `courtesy_title` tinyint(3) unsigned NOT NULL COMMENT '联系人尊称(0-Mr.1-Mrs.2-Miss.3-Ms.)',
  `company` varchar(100) NOT NULL COMMENT '公司名称',
  `tel` varchar(45) NOT NULL COMMENT '联系电话',
  `fax` varchar(45) NOT NULL COMMENT '传真',
  `website` varchar(100) NOT NULL COMMENT '联系人网址',
  `country` char(2) NOT NULL COMMENT '国家代码',
  `contact` varchar(45) NOT NULL COMMENT '联系人姓名',
  `email` varchar(100) NOT NULL COMMENT 'E-Mail',
  `price_n_terms` tinyint(3) NOT NULL COMMENT 'Price & Terms',
  `payment` tinyint(3) NOT NULL COMMENT 'Payment',
  `initial_order` varchar(45) NOT NULL COMMENT 'Initial Order',
  `sample_terms` tinyint(3) NOT NULL COMMENT 'Sample Terms',
  `request_specifications` tinyint(3) unsigned NOT NULL COMMENT 'Request Specifications',
  `request_company_description` tinyint(3) unsigned NOT NULL COMMENT 'Request Company Description',
  `request_deliver_time` tinyint(3) unsigned NOT NULL COMMENT 'Request Deliver Time',
  `contact_within_24h` tinyint(3) unsigned NOT NULL COMMENT 'Please reply me within 24 hours',
  `email_me_updates` tinyint(3) unsigned NOT NULL COMMENT 'Email me twice a week updates on the latest Product and Supplier info.',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `attachments` text NOT NULL COMMENT '附件清单（JSON）',
  `created` datetime NOT NULL COMMENT '发布日期（时间）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mutex` (`guid`),
  KEY `idx_get_by_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='询盘表';

CREATE TABLE `enterprise_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(30) NOT NULL COMMENT '登录名',
  `password` char(32) NOT NULL COMMENT '密码（MD5）',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `last_log_in` datetime NOT NULL COMMENT '最近登录时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_log_in` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

CREATE TABLE `enterprise_groups` (
  `id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自建分组表';