-- 2018-1-24
CREATE TABLE `oms_translation_progresses` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `lang_code` char(2) NOT NULL DEFAULT 'en' COMMENT '语言代码',
  `status` tinyint NOT NULL COMMENT '进度状态',
  `initialized` tinyint NOT NULL COMMENT '已完成初始化？（0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`site_id`, `lang_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='翻译进度表';
ALTER TABLE `oms_sites` ADD COLUMN `enable_translator` tinyint NOT NULL COMMENT '启用翻译器？（0/1）';
-- 2018-1-14
ALTER TABLE `enterprise_sites` ADD COLUMN `translation_targets` text NOT NULL COMMENT '翻译目标语种清单（JSON）';
CREATE TABLE `enterprise_fr_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法语-待翻译产品表';
CREATE TABLE `enterprise_pt_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='葡语-待翻译产品表';
CREATE TABLE `enterprise_es_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='西班牙语-待翻译产品表';
CREATE TABLE `enterprise_zh_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='中文-待翻译产品表';
CREATE TABLE `enterprise_ar_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿拉伯语-待翻译产品表';
CREATE TABLE `enterprise_ru_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='俄语-待翻译产品表';
CREATE TABLE `enterprise_el_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='希腊语-待翻译产品表';
CREATE TABLE `enterprise_id_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='印尼语-待翻译产品表';
CREATE TABLE `enterprise_th_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='泰语-待翻译产品表';
CREATE TABLE `enterprise_uk_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='乌克兰语-待翻译产品表';
CREATE TABLE `enterprise_de_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='德语-待翻译产品表';
CREATE TABLE `enterprise_it_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='意大利语-待翻译产品表';
CREATE TABLE `enterprise_sq_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='阿尔巴尼亚语-待翻译产品表';
CREATE TABLE `enterprise_sv_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='瑞典语-待翻译产品表';
CREATE TABLE `enterprise_tr_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='土耳其语-待翻译产品表';
CREATE TABLE `enterprise_ja_pending_products` (
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `pending` tinyint NOT NULL COMMENT '待处理(0/1)',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`product_id`),
  KEY `idx_pending` (`pending`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日语-待翻译产品表';
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
-- 2017-6-21
CREATE TABLE `oms_operators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '运营人员ID',
  `name` varchar(45) NOT NULL COMMENT '用户名' UNIQUE,
  `password` char(32) NOT NULL COMMENT '密码（MD5）',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='运营人员表';
CREATE TABLE `oms_vpss` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'VPS ID',
  `alias` varchar(45) NOT NULL COMMENT '别名',
  `ip_addr` varchar(15) NOT NULL COMMENT 'IP地址',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VPS表';
-- 2017-6-13
CREATE TABLE `enterprise_fr_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法语-新闻表';
CREATE TABLE `enterprise_pt_news` (
  `news_id` int(10) unsigned NOT NULL COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`news_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='葡语-新闻表';
ALTER TABLE `enterprise_fr_sites` ADD COLUMN `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）';
ALTER TABLE `enterprise_pt_sites` ADD COLUMN `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）';
-- 2017-6-12
CREATE TABLE `oms_industries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '行业ID',
  `name` varchar(100) NOT NULL COMMENT '行业名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='行业表';
-- 2017-6-8
ALTER TABLE `enterprise_sites` ADD COLUMN `common_bg_image` int(10) unsigned NOT NULL COMMENT '默认背景图片ID';
-- 2017-6-6
CREATE TABLE `enterprise_fr_corporations` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法语-公司表';
CREATE TABLE `enterprise_pt_corporations` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='葡语-公司表';
-- 2017-6-5
CREATE TABLE `enterprise_fr_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法语-用户自建分组表';
CREATE TABLE `enterprise_pt_groups` (
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `name` varchar(255) NOT NULL COMMENT '分组名称',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `cnt` int(10) unsigned NOT NULL COMMENT '产品数量',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`group_id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='葡语-用户自建分组表';
-- 2017-6-2
CREATE TABLE `enterprise_main_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主推产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `label` varchar(100) NOT NULL COMMENT '关键词',
  `url` varchar(255) NOT NULL COMMENT 'URL',
  `target_product_id` int(10) unsigned NOT NULL COMMENT '目标产品ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主推产品表';
-- 2017-6-1
ALTER TABLE `enterprise_sites` ADD COLUMN `product_default_image` int(10) unsigned NOT NULL COMMENT '产品默认图片ID';
-- 2017-5-25
ALTER TABLE `enterprise_sites` ADD COLUMN `common_head_fragment` text NOT NULL COMMENT '通用HTML head代码片段';
CREATE TABLE `enterprise_fr_sites` (
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
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='法语-站点表';
-- 2017-5-24
CREATE TABLE `enterprise_pt_sites` (
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
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='葡语-站点表';
ALTER TABLE `enterprise_sites` ADD COLUMN `contact_content` text NOT NULL COMMENT '联系页替代正文';
-- 2017-5-21
CREATE TABLE `enterprise_pt_products` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='葡语-用户新发产品表';
-- 2017-5-19
CREATE TABLE `enterprise_fr_products` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED COMMENT='法语-用户新发产品表';
-- 2017-5-18
ALTER TABLE `enterprise_sites`
  ADD COLUMN `product_tdk_scope` tinyint NOT NULL COMMENT '产品页TDK有效半径（0-全站；>0-分组ID）',
  ADD COLUMN `product_html_title` text NOT NULL COMMENT '产品页T',
  ADD COLUMN `product_meta_keywords` text NOT NULL COMMENT '产品页K',
  ADD COLUMN `product_meta_description` text NOT NULL COMMENT '产品页D';
-- 2017-5-15
CREATE TABLE `enterprise_user_voices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠言ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `title` varchar(100) NOT NULL COMMENT '称谓',
  `voice` varchar(255) NOT NULL COMMENT '赠言',
  `avatar_image_id` int unsigned NOT NULL COMMENT '头像图ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户赠言表';
ALTER TABLE `enterprise_sites` ADD COLUMN `desc_4_inquiry_sender` text NOT NULL COMMENT '信息说明';
CREATE TABLE `enterprise_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '新闻ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `caption` varchar(255) NOT NULL COMMENT '新闻标题',
  `content` text NOT NULL COMMENT '新闻正文',
  `head_image_id` int unsigned NOT NULL COMMENT '新闻头图ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻表';
-- 2017-5-9
ALTER TABLE `enterprise_sites`
  ADD COLUMN `index_html_title` text NOT NULL COMMENT '首页T',
  ADD COLUMN `index_meta_keywords` text NOT NULL COMMENT '首页K',
  ADD COLUMN `index_meta_description` text NOT NULL COMMENT '首页D',
  ADD COLUMN `user_voices` text NOT NULL COMMENT '首页用户赠言（JSON）',
  ADD COLUMN `index_products` text NOT NULL COMMENT '首页推荐产品ID清单（JSON）';
-- 2017-4-16
ALTER TABLE `enterprise_images`
  ADD COLUMN `body_sum` binary(16) NOT NULL COMMENT '图片摘要',
  ADD KEY `idx_sum` (`body_sum`);
-- 2017-4-12
ALTER TABLE `enterprise_products`
  ADD COLUMN `path`text NOT NULL COMMENT '自定义路径',
  ADD COLUMN `path_sum` binary(16) NOT NULL COMMENT '自定义路径的摘要',
  ADD KEY `idx_lookup` (`site_id`, `path_sum`);
-- 2017-4-9
ALTER TABLE `enterprise_users` ADD COLUMN `advanced` tinyint NOT NULL COMMENT '可使用高级功能(0/1)';
ALTER TABLE `enterprise_sites` ADD COLUMN `product_cnt` int(10) unsigned NOT NULL COMMENT '产品总数';
ALTER TABLE `enterprise_inquiries`
  ADD COLUMN `deleted` tinyint NOT NULL COMMENT '已删除？',
  DROP KEY `idx_get_by_site`,
  ADD KEY `idx_get_by_site` (`site_id`, `deleted`);
-- 2017-4-6
ALTER TABLE `enterprise_products` ROW_FORMAT = COMPRESSED;
ALTER TABLE `enterprise_images` ROW_FORMAT = COMPRESSED;
ALTER TABLE `enterprise_thumbnails` ROW_FORMAT = COMPRESSED;
-- 2017-4-4
CREATE TABLE `enterprise_tracks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `ipv4` int(10) unsigned NOT NULL COMMENT '访客IP',
  `path` varchar(100) NOT NULL COMMENT '受访页面',
  `created` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `created`, `ipv4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户访问轨迹';
ALTER TABLE `enterprise_products`
  ADD COLUMN `html_title` text NOT NULL COMMENT 'T',
  ADD COLUMN `meta_keywords` text NOT NULL COMMENT 'K',
  ADD COLUMN `meta_description` text NOT NULL COMMENT 'D';
CREATE TABLE `enterprise_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `subject` varchar(100) NOT NULL COMMENT '标题',
  `message` text NOT NULL COMMENT '内容',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `issued_on` date  NOT NULL COMMENT '留言日期',
  `avatar` varchar(100) NOT NULL COMMENT '头像URI',
  `contact` varchar(45) NOT NULL COMMENT '留言者',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品留言表';
-- 2017-3-31
CREATE TABLE `oms_sites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `desc` varchar(45) NOT NULL COMMENT '描述',
  `guid` binary(16) NOT NULL COMMENT '全局唯一ID',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='（服务器级别）站点表';
CREATE TABLE `enterprise_site_mappings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `domain` varchar(45) NOT NULL COMMENT '完整根域（如：baidu.com）',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mutex` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点域名映射';
-- 2017-3-30
ALTER TABLE `enterprise_custom_pages`
  DROP KEY `idx_get_by_path`,
  DROP KEY `idx_get_by_site`,
  ADD KEY `idx_get_by_site` (`site_id`, `deleted`, `path`);
ALTER TABLE `enterprise_users` ADD COLUMN `email` varchar(100) NOT NULL COMMENT '通知用Email';
ALTER TABLE `enterprise_corporations` ADD COLUMN `slogan` varchar(100) NOT NULL COMMENT '口号';
-- 2017-3-29
ALTER TABLE `enterprise_sites`
  ADD COLUMN `common_fragment` text NOT NULL COMMENT '通用HTML代码片段',
  ADD COLUMN `contactnow_fragment` text NOT NULL COMMENT '询盘页HTML代码片段',
  ADD COLUMN `contactsave_fragment` text NOT NULL COMMENT '询盘成功页HTML代码片段';
CREATE TABLE `enterprise_custom_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `path` varchar(100) NOT NULL COMMENT '以/开头的页面路径',
  `desc` varchar(45) NOT NULL COMMENT '描述',
  `body` text NOT NULL COMMENT '页面内容',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_path` (`site_id`, `path`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自定义页面表';
ALTER TABLE `enterprise_products` ADD COLUMN `source_url` varchar(255) NOT NULL COMMENT '若产品是抓来的则保存原始URL';
-- 2017-3-27
ALTER TABLE `enterprise_inquiries` ADD COLUMN `target_product_id` int(10) unsigned NOT NULL COMMENT '目标产品ID';
-- 2017-3-21
CREATE TABLE `enterprise_banners` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `uri` varchar(100) NOT NULL COMMENT 'URI',
  `desc` varchar(45) NOT NULL COMMENT '描述',
  `link` varchar(100) NOT NULL COMMENT '链接',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自建横幅图片表';
-- 2017-3-20
ALTER TABLE `enterprise_thumbnails`
  CHANGE COLUMN `378x270` `t` mediumblob NOT NULL COMMENT 't',
  CHANGE COLUMN `54x39` `m` mediumblob NOT NULL COMMENT 'm',
  CHANGE COLUMN `140x100` `d` mediumblob NOT NULL COMMENT 'd',
  CHANGE COLUMN `329x235` `c` mediumblob NOT NULL COMMENT 'c';
CREATE TABLE `enterprise_certifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `uri` varchar(100) NOT NULL COMMENT 'URI',
  `standard` varchar(45) NOT NULL COMMENT 'Standard',
  `number` varchar(45) NOT NULL COMMENT 'Number',
  `issue_date` varchar(45) NOT NULL COMMENT 'Issue Date',
  `expiry_date` varchar(45) NOT NULL COMMENT 'Expiry Date',
  `scope_n_range` varchar(45) NOT NULL COMMENT 'Scope/Range',
  `issued_by` varchar(45) NOT NULL COMMENT 'Issued By',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户自建证书表';
-- 2017-3-19
ALTER TABLE `enterprise_sites` ADD COLUMN `start_year` smallint unsigned NOT NULL COMMENT '起始年份';
ALTER TABLE `enterprise_corporations`
  ADD COLUMN `qc_profile` text NOT NULL COMMENT 'QC Profile',
  ADD COLUMN `business_type` varchar(45) NOT NULL COMMENT 'Business Type',
  ADD COLUMN `main_market` varchar(45) NOT NULL COMMENT 'Main Market',
  ADD COLUMN `brands` varchar(45) NOT NULL COMMENT 'Brands',
  ADD COLUMN `no_of_employees` varchar(45) NOT NULL COMMENT 'No. of Employees',
  ADD COLUMN `annual_sales` varchar(45) NOT NULL COMMENT 'Annual Sales',
  ADD COLUMN `year_established` varchar(45) NOT NULL COMMENT 'Year Established',
  ADD COLUMN `export_p_c` varchar(45) NOT NULL COMMENT 'Export p.c',
  ADD COLUMN `introduction` text NOT NULL COMMENT 'Introduction',
  ADD COLUMN `history` text NOT NULL COMMENT 'History',
  ADD COLUMN `service` text NOT NULL COMMENT 'Service',
  ADD COLUMN `our_team` text NOT NULL COMMENT 'Our Team',
  ADD COLUMN `logo` int(10) unsigned NOT NULL COMMENT 'LOGO图片ID';
-- 2017-3-16
CREATE TABLE `blowjob_product_identities` (
  `identity` varchar(12) NOT NULL COMMENT '唯一标识',
  `product_id` int(10) unsigned NOT NULL COMMENT '产品ID',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  PRIMARY KEY (`identity`, `site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品唯一标识表';
ALTER TABLE `blowjob_tasks` ADD COLUMN `max_pages` tinyint NOT NULL COMMENT '最大页数';
CREATE TABLE `blowjob_tasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '分组ID',
  `target_url` varchar(255) NOT NULL COMMENT '目标URL',
  `status` tinyint(3) NOT NULL COMMENT '状态（0-待处理；10-进行中；100-已完成）',
  `deleted` tinyint NOT NULL COMMENT '已删除？',
  `created` datetime NOT NULL COMMENT '创建时间',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_get_by_site` (`site_id`, `deleted`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='抓取任务表';
-- 2017-3-13
CREATE TABLE `enterprise_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `template` varchar(45) NOT NULL COMMENT '模板名称',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点表';
ALTER TABLE `enterprise_corporations` COMMENT='公司表';
-- 2017-3-10
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
-- 2017-3-9
RENAME TABLE `enterprise_sites` TO `enterprise_corporations`;
ALTER TABLE `enterprise_corporations`
  CHANGE COLUMN `corporation_name` `name` varchar(100) NOT NULL COMMENT '公司名称',
  ADD COLUMN `address` varchar(100) NOT NULL COMMENT '地址',
  ADD COLUMN `factory_address` varchar(100) NOT NULL COMMENT '厂址',
  ADD COLUMN `worktime` varchar(100) NOT NULL COMMENT '工作时间',
  ADD COLUMN `tel_wt` varchar(100) NOT NULL COMMENT '电话（工作时间内）',
  ADD COLUMN `tel_nwt` varchar(100) NOT NULL COMMENT '电话（非工作时间内）',
  ADD COLUMN `fax` varchar(100) NOT NULL COMMENT '传真',
  ADD COLUMN `skype` varchar(45) NOT NULL COMMENT 'Skype',
  ADD COLUMN `email` varchar(45) NOT NULL COMMENT '电子邮件地址',
  ADD COLUMN `yahoo` varchar(45) NOT NULL COMMENT 'Yahoo';
-- 2017-3-8
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
-- 2017-3-7
CREATE TABLE `enterprise_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `corporation_name` varchar(100) NOT NULL COMMENT '公司名称',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点表';
-- 2017-2-24
ALTER TABLE `enterprise_inquiries`
  ADD COLUMN `domain` VARCHAR(45) NOT NULL COMMENT '完整根域（如：baidu.com）',
  ADD COLUMN `ip` VARCHAR(15) NOT NULL COMMENT 'IPv4地址';
