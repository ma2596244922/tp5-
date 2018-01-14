-- 2018-1-2
CREATE TABLE `hide_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `enabled` tinyint NOT NULL COMMENT '功能开启？(0/1)',
  `hide_by_ipaddr` tinyint NOT NULL COMMENT '启用IP限制？(0/1)',
  `hide_by_browser` tinyint NOT NULL COMMENT '启用浏览器限制？(0/1)',
  `hide_by_os` tinyint NOT NULL COMMENT '启用操作系统限制？(0/1)',
  `ipaddr_black_list` text NOT NULL COMMENT 'IP黑名单',
  `ipaddr_white_list` text NOT NULL COMMENT 'IP白名单',
  `target_page` tinyint NOT NULL COMMENT '目标页类型(0-默认页；10-自定义URL)',
  `target_page_url` varchar(255) NOT NULL COMMENT '目标页URL',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点的屏蔽配置表';
CREATE TABLE `hide_tracks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `ipaddr` int(10) unsigned NOT NULL COMMENT '访客IP',
  `ua` varchar(255) NOT NULL COMMENT 'UA',
  `path` varchar(100) NOT NULL COMMENT '受访页面',
  `hit` tinyint NOT NULL COMMENT '命中的策略(10-IP；20-浏览器；30-操作系统)',
  `created` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点屏蔽记录';
-- 2017-12-29
ALTER TABLE `enterprise_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_fr_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_pt_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_es_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_zh_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_ar_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_ru_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_el_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_id_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_th_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_uk_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_de_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_it_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_sq_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_sv_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_tr_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
ALTER TABLE `enterprise_ja_products` ADD COLUMN `embedded_video` text NOT NULL COMMENT '嵌入视频代码';
-- 2017-12-26
CREATE TABLE `oms_threatening_targets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '封禁目标ID',
  `email` varchar(100) NOT NULL COMMENT 'Email',
  `ip_addr` varchar(15) NOT NULL COMMENT 'IP地址',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_deleted` (`deleted`),
  KEY `idx_q1` (`email`),
  KEY `idx_q2` (`ip_addr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='封禁目标表';
-- 2017-12-17
CREATE TABLE `enterprise_index_keywords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '关键词ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `url` varchar(255) NOT NULL COMMENT 'URL',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首页关键词表';
-- 2017-12-14
CREATE TABLE `enterprise_pictures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `uri` varchar(100) NOT NULL COMMENT 'URI',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户图片表';
-- 2017-11-24
ALTER TABLE `enterprise_groups` ADD COLUMN `product_give_h1_to` tinyint NOT NULL COMMENT '优先使用H1标签（0-产品标题；1-型号）';
-- 2017-11-15
ALTER TABLE `enterprise_groups` ADD COLUMN `desc` text NOT NULL COMMENT '说明文本';
-- 2017-11-2
ALTER TABLE `blowjob_tasks` CHANGE COLUMN `details` `details` MEDIUMTEXT NOT NULL COMMENT '任务详情（JSON）' ;
-- 2017-11-1
ALTER TABLE `enterprise_groups`
   ADD COLUMN `html_title` text NOT NULL COMMENT 'T',
   ADD COLUMN `meta_keywords` text NOT NULL COMMENT 'K',
   ADD COLUMN `meta_description` text NOT NULL COMMENT 'D';
-- 2017-10-24
ALTER TABLE `enterprise_sites` ADD COLUMN `disable_group_dk` tinyint unsigned NOT NULL COMMENT '是否禁用分组页D/K(0/1)';
-- 2017-10-9
ALTER TABLE `enterprise_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_fr_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_pt_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_es_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_zh_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_ar_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_ru_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_el_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_id_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_th_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_uk_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_de_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_it_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_sq_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_sv_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_tr_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
ALTER TABLE `enterprise_ja_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
-- 2017-9-22
ALTER TABLE `oms_sites` ADD COLUMN `crawled` tinyint NOT NULL COMMENT '是否抓取站点（0/1）';
-- 2017-9-14
ALTER TABLE `enterprise_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_fr_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_pt_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_es_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_zh_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_ar_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_ru_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_el_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_id_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_th_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_uk_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_de_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_it_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_sq_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_sv_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_tr_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
ALTER TABLE `enterprise_ja_products` ADD KEY `idx_list` (`site_id`, `deleted`, `group_id`, `updated`);
-- 2017-9-8
ALTER TABLE `enterprise_sites` 
  ADD COLUMN `enable_floating_widget` tinyint unsigned NOT NULL COMMENT '是否启用漂浮框(0/1)',
  ADD COLUMN `floating_widget_url` varchar(45) NOT NULL COMMENT '漂浮框URL';
-- 2017-8-22
CREATE TABLE `enterprise_ja_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日语-公司表';
CREATE TABLE `enterprise_ja_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日语-用户自建分组表';
CREATE TABLE `enterprise_ja_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='日语-用户新发产品表';
CREATE TABLE `enterprise_ja_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日语-站点表';
CREATE TABLE `enterprise_ja_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日语-新闻表';
CREATE TABLE `enterprise_ja_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日语-用户赠言表';
-- 2017-8-21
CREATE TABLE `enterprise_sq_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿尔巴尼亚语-公司表';
CREATE TABLE `enterprise_sq_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿尔巴尼亚语-用户自建分组表';
CREATE TABLE `enterprise_sq_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='阿尔巴尼亚语-用户新发产品表';
CREATE TABLE `enterprise_sq_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿尔巴尼亚语-站点表';
CREATE TABLE `enterprise_sq_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿尔巴尼亚语-新闻表';
CREATE TABLE `enterprise_sq_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿尔巴尼亚语-用户赠言表';
CREATE TABLE `enterprise_sv_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='瑞典语-公司表';
CREATE TABLE `enterprise_sv_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='瑞典语-用户自建分组表';
CREATE TABLE `enterprise_sv_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='瑞典语-用户新发产品表';
CREATE TABLE `enterprise_sv_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='瑞典语-站点表';
CREATE TABLE `enterprise_sv_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='瑞典语-新闻表';
CREATE TABLE `enterprise_sv_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='瑞典语-用户赠言表';
CREATE TABLE `enterprise_tr_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='土耳其语-公司表';
CREATE TABLE `enterprise_tr_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='土耳其语-用户自建分组表';
CREATE TABLE `enterprise_tr_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='土耳其语-用户新发产品表';
CREATE TABLE `enterprise_tr_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='土耳其语-站点表';
CREATE TABLE `enterprise_tr_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='土耳其语-新闻表';
CREATE TABLE `enterprise_tr_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='土耳其语-用户赠言表';
-- 2017-8-15
CREATE TABLE `enterprise_it_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意大利语-公司表';
CREATE TABLE `enterprise_it_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意大利语-用户自建分组表';
CREATE TABLE `enterprise_it_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='意大利语-用户新发产品表';
CREATE TABLE `enterprise_it_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意大利语-站点表';
CREATE TABLE `enterprise_it_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意大利语-新闻表';
CREATE TABLE `enterprise_it_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意大利语-用户赠言表';
CREATE TABLE `enterprise_de_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德语-公司表';
CREATE TABLE `enterprise_de_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德语-用户自建分组表';
CREATE TABLE `enterprise_de_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='德语-用户新发产品表';
CREATE TABLE `enterprise_de_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德语-站点表';
CREATE TABLE `enterprise_de_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德语-新闻表';
CREATE TABLE `enterprise_de_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德语-用户赠言表';
-- 2017-8-14
CREATE TABLE `enterprise_uk_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乌克兰语-公司表';
CREATE TABLE `enterprise_uk_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乌克兰语-用户自建分组表';
CREATE TABLE `enterprise_uk_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='乌克兰语-用户新发产品表';
CREATE TABLE `enterprise_uk_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乌克兰语-站点表';
CREATE TABLE `enterprise_uk_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乌克兰语-新闻表';
CREATE TABLE `enterprise_uk_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乌克兰语-用户赠言表';
-- 2017-8-10
CREATE TABLE `enterprise_th_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='泰语-公司表';
CREATE TABLE `enterprise_th_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='泰语-用户自建分组表';
CREATE TABLE `enterprise_th_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='泰语-用户新发产品表';
CREATE TABLE `enterprise_th_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='泰语-站点表';
CREATE TABLE `enterprise_th_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='泰语-新闻表';
CREATE TABLE `enterprise_th_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='泰语-用户赠言表';
-- 2017-8-4
ALTER TABLE `enterprise_groups`
  ADD COLUMN `product_html_title` text NOT NULL COMMENT '产品页T',
  ADD COLUMN `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  ADD COLUMN `product_meta_description` text NOT NULL COMMENT '产品页D';
-- 2017-8-3
ALTER TABLE `enterprise_inquiries` ADD COLUMN `updated` datetime NOT NULL COMMENT '最近修改时间';
-- 2017-7-31
CREATE TABLE `enterprise_fr_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法语-用户赠言表';
CREATE TABLE `enterprise_el_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='希腊语-公司表';
CREATE TABLE `enterprise_el_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='希腊语-用户自建分组表';
CREATE TABLE `enterprise_el_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='希腊语-用户新发产品表';
CREATE TABLE `enterprise_el_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='希腊语-站点表';
CREATE TABLE `enterprise_el_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='希腊语-新闻表';
CREATE TABLE `enterprise_el_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='希腊语-用户赠言表';
CREATE TABLE `enterprise_id_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印尼语-公司表';
CREATE TABLE `enterprise_id_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印尼语-用户自建分组表';
CREATE TABLE `enterprise_id_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='印尼语-用户新发产品表';
CREATE TABLE `enterprise_id_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印尼语-站点表';
CREATE TABLE `enterprise_id_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印尼语-新闻表';
CREATE TABLE `enterprise_id_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印尼语-用户赠言表';
-- 2017-7-27
CREATE TABLE `enterprise_ru_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='俄语-公司表';
CREATE TABLE `enterprise_ru_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='俄语-用户自建分组表';
CREATE TABLE `enterprise_ru_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='俄语-用户新发产品表';
CREATE TABLE `enterprise_ru_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='俄语-站点表';
CREATE TABLE `enterprise_ru_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='俄语-新闻表';
CREATE TABLE `enterprise_ru_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='俄语-用户赠言表';
-- 2017-7-25
CREATE TABLE `enterprise_ar_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿拉伯语-公司表';
CREATE TABLE `enterprise_ar_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿拉伯语-用户自建分组表';
CREATE TABLE `enterprise_ar_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='阿拉伯语-用户新发产品表';
CREATE TABLE `enterprise_ar_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿拉伯语-站点表';
CREATE TABLE `enterprise_ar_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿拉伯语-新闻表';
CREATE TABLE `enterprise_ar_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿拉伯语-用户赠言表';
-- 2017-7-12
ALTER TABLE `enterprise_groups` ADD COLUMN `purl_prefix` varchar(15) NOT NULL COMMENT '产品URL前缀';
-- 2017-7-19
ALTER TABLE `oms_tasks` ADD COLUMN `delay_until` datetime NOT NULL COMMENT '延迟至该时间启动';
-- 2017-7-18
CREATE TABLE `oms_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `status` tinyint(3) NOT NULL COMMENT '状态（0-待处理；10-进行中；100-已完成）',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `details` text NOT NULL COMMENT '任务详情（JSON）',
  PRIMARY KEY (`id`),
  KEY `idx_get_pending` (`deleted`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抓取任务表';
-- 2017-7-17
ALTER TABLE `enterprise_sites` ADD COLUMN `lang_codes` text NOT NULL COMMENT '语种清单（JSON）';
CREATE TABLE `enterprise_zh_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中文-公司表';
CREATE TABLE `enterprise_zh_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中文-用户自建分组表';
CREATE TABLE `enterprise_zh_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='中文-用户新发产品表';
CREATE TABLE `enterprise_zh_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中文-站点表';
CREATE TABLE `enterprise_zh_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中文-新闻表';
CREATE TABLE `enterprise_zh_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中文-用户赠言表';
-- 2017-7-14
ALTER TABLE `enterprise_sites` ADD COLUMN `default_lang_code` char(2) NOT NULL DEFAULT 'en' COMMENT '默认的语言代码';
-- 2017-7-11
ALTER TABLE `enterprise_sites` CHANGE COLUMN `enable_inquiry_checking` `enable_inquiry_checking` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '是否需要审核询盘(0/1)';
CREATE TABLE `enterprise_es_corporations` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(100) NOT NULL COMMENT '公司名称',
  `address` varchar(100) NOT NULL COMMENT '地址',
  `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  `brands` varchar(45) NOT NULL COMMENT 'Brands',
  `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  `introduction` text NOT NULL COMMENT 'Introduction',
  `history` text NOT NULL COMMENT 'History',
  `service` text NOT NULL COMMENT 'Service',
  `our_team` text NOT NULL COMMENT 'Our Team',
  `qc_profile` text NOT NULL COMMENT 'QC Profile',
  `slogan` varchar(100) NOT NULL COMMENT '口号',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='西班牙语-公司表';
CREATE TABLE `enterprise_es_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='西班牙语-用户自建分组表';
CREATE TABLE `enterprise_es_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '产品标题',
  `description` text NOT NULL COMMENT '产品描述',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `tags` varchar(255) NOT NULL COMMENT '关键词（逗号分隔）',
  `min_order_quantity` varchar(100) NOT NULL COMMENT '最小起订量',
  `delivery_time` varchar(100) NOT NULL COMMENT '发货期限',
  `packaging_details` varchar(100) NOT NULL COMMENT '常规包装',
  `specifications` text NOT NULL COMMENT '产品属性（JSON）',
  `source_url` text NOT NULL COMMENT '若产品是抓来的则保存原始URL',
  PRIMARY KEY (`product_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='西班牙语-用户新发产品表';
CREATE TABLE `enterprise_es_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数',
  `index_html_title` text NOT NULL COMMENT '首页T',
  `index_meta_keywords` text NOT NULL COMMENT '首页K',
  `index_meta_description` text NOT NULL COMMENT '首页D',
  `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明',
  `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  `product_html_title` text NOT NULL COMMENT '产品页T',
  `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  `product_meta_description` text NOT NULL COMMENT '产品页D',
  `contact_content` text NOT NULL COMMENT '联系页替代正文',
  `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='西班牙语-站点表';
CREATE TABLE `enterprise_es_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='西班牙语-新闻表';
CREATE TABLE `enterprise_es_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='西班牙语-用户赠言表';
-- 2017-7-10
ALTER TABLE `enterprise_sites` ADD COLUMN `favicon` mediumblob NOT NULL COMMENT '收藏夹小图标数据';
-- 2017-7-8
ALTER TABLE `enterprise_sites` 
  ADD COLUMN `purl_prefix` varchar(15) NOT NULL COMMENT '产品URL前缀',
  ADD COLUMN `gurl_prefix` varchar(15) NOT NULL COMMENT '产品分组URL前缀';
-- 2017-7-2
ALTER TABLE `blowjob_tasks`
  ADD COLUMN `type` tinyint NOT NULL COMMENT '任务类型（0-抓取任务；10-批量插入关键词）',
  ADD COLUMN `details` text NOT NULL COMMENT '任务详情（JSON）',
  DROP KEY `idx_get_by_site`,
  ADD KEY `idx_get_by_site` (`site_id`, `deleted`, `type`, `status`);
CREATE TABLE `enterprise_pt_user_voices` (
  `user_voice_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`user_voice_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='葡语-用户赠言表';
-- 2017-6-30
ALTER TABLE `oms_operators` ADD COLUMN `advanced` tinyint NOT NULL COMMENT '可使用高级功能(0/1)';
ALTER TABLE `enterprise_sites` CHANGE COLUMN `online` `offline` tinyint unsigned NOT NULL COMMENT '是否下线(0/1)';
ALTER TABLE `oms_sites` 
  ADD COLUMN `industry_id` int(10) unsigned NOT NULL COMMENT '行业ID',
  ADD COLUMN `type` tinyint NOT NULL COMMENT '网站类型（1-自营；2-赠送）';
-- 2017-6-27
CREATE TABLE `enterprise_pending_inquiries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `data` text NOT NULL COMMENT '提交的询盘数据（JSON）',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_pending` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待审核询盘表';
-- 2017-6-26
ALTER TABLE `enterprise_groups`
  ADD COLUMN `path`text NOT NULL COMMENT '自定义路径',
  ADD COLUMN `path_sum` binary(16) NOT NULL COMMENT '自定义路径的摘要',
  ADD KEY `idx_lookup` (`site_id`, `path_sum`);
ALTER TABLE `enterprise_inquiries`
  ADD COLUMN `type` tinyint NOT NULL COMMENT '询盘类型（0-自然询盘；1-匹配询盘）';
-- 2017-6-23
ALTER TABLE `enterprise_users`
  ADD COLUMN `deleted` tinyint NOT NULL COMMENT '已删除？';
-- 2017-6-22
ALTER TABLE `enterprise_sites`
  ADD COLUMN `enable_inquiry_checking` tinyint unsigned NOT NULL COMMENT '是否需要审核询盘(0/1)',
  ADD COLUMN `enable_mobile_sites` tinyint unsigned NOT NULL COMMENT '是否启用移动站(0/1)',
  ADD COLUMN `enable_https` tinyint unsigned NOT NULL COMMENT '是否启用HTTPS(0/1)',
  ADD COLUMN `online` tinyint unsigned NOT NULL COMMENT '是否上线(0/1)';
ALTER TABLE `oms_sites`
  ADD COLUMN `qq` VARCHAR(15) NOT NULL COMMENT 'QQ',
  ADD COLUMN `wechat` VARCHAR(45) NOT NULL COMMENT '微信',
  ADD COLUMN `name` VARCHAR(45) NOT NULL COMMENT '姓名',
  ADD COLUMN `tel` varchar(45) NOT NULL COMMENT '联系电话',
  ADD COLUMN `sex` tinyint unsigned NOT NULL COMMENT '性别（0-男；1-女）',
  ADD COLUMN `csr` text NOT NULL COMMENT 'CSR',
  ADD COLUMN `key` text NOT NULL COMMENT 'Key',
  ADD COLUMN `vps_id` int(10) unsigned NOT NULL COMMENT 'VPS ID';
