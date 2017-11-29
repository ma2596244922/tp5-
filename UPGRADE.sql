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
