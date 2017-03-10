CREATE TABLE `blowjob_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `target_url` varchar(255) NOT NULL COMMENT '目标URL',
  `max_pages` tinyint NOT NULL COMMENT '最大页数',
  `status` tinyint(3) NOT NULL COMMENT '状态（0-待处理；10-进行中；100-已完成）',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抓取任务表';

CREATE TABLE `blowjob_product_identities` (
  `identity` varchar(12) NOT NULL COMMENT '唯一标识',
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  PRIMARY KEY (`identity`, `site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品唯一标识表';

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
  `domain` VARCHAR(45) NOT NULL COMMENT '完整根域（如：baidu.com）',
  `ip` VARCHAR(15) NOT NULL COMMENT 'IPv4地址',
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
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自建分组表';

CREATE TABLE `enterprise_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `locale` varchar(20) NOT NULL COMMENT '语种名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `brand_name` varchar(100) NOT NULL COMMENT '品牌',
  `model_number` varchar(100) NOT NULL COMMENT '型号',
  `certification` varchar(100) NOT NULL COMMENT '认证证书',
  `place_of_origin` varchar(100) NOT NULL COMMENT '原产地',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `price` varchar(100) NOT NULL COMMENT '价格',
  `payment_terms` varchar(100) NOT NULL COMMENT '付款方式',
  `supply_ability` varchar(100) NOT NULL COMMENT '供货能力',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `head_image_id` int unsigned NOT NULL COMMENT '产品头图ID',
  `images` text NOT NULL COMMENT '产品图片（JSON）',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户新发产品表';

CREATE TABLE `enterprise_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `body` mediumblob NOT NULL COMMENT '图片内容',
  `created` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户新发图片表';

CREATE TABLE `enterprise_thumbnails` (
  `image_id` int(10) unsigned NOT NULL COMMENT '图片ID',
  `378x270` mediumblob NOT NULL COMMENT '378x270',
  `54x39` mediumblob NOT NULL COMMENT '54x39',
  `140x100` mediumblob NOT NULL COMMENT '140x100',
  `329x235` mediumblob NOT NULL COMMENT '329x235',
  `created` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户新发图片缩略图表';

CREATE TABLE `enterprise_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `worktime` varchar(100) NOT NULL COMMENT '工作时间',
  `tel_wt` varchar(100) NOT NULL COMMENT '电话（工作时间内）',
  `tel_nwt` varchar(100) NOT NULL COMMENT '电话（非工作时间内）',
  `fax` varchar(100) NOT NULL COMMENT '传真',
  `skype` varchar(45) NOT NULL COMMENT 'Skype',
  `email` varchar(45) NOT NULL COMMENT '电子邮件地址',
  `yahoo` varchar(45) NOT NULL COMMENT 'Yahoo',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点表';

CREATE TABLE `enterprise_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(45) NOT NULL COMMENT '姓名',
  `title` varchar(45) NOT NULL COMMENT '职务',
  `tel` varchar(45) NOT NULL COMMENT '电话',
  `skype` varchar(45) NOT NULL COMMENT 'Skype',
  `email` varchar(45) NOT NULL COMMENT '电子邮件地址',
  `yahoo` varchar(45) NOT NULL COMMENT 'Yahoo',
  `icq` varchar(45) NOT NULL COMMENT 'ICQ',
  `viber` varchar(45) NOT NULL COMMENT 'Viber',
  `whatsapp` varchar(45) NOT NULL COMMENT 'WhatsApp',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自建联系人表';

CREATE TABLE `enterprise_photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `uri` varchar(100) NOT NULL COMMENT 'URI',
  `desc` varchar(45) NOT NULL COMMENT '描述',
  `type` tinyint NOT NULL COMMENT '类型',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `type`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自建照片表';
