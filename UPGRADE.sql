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
