-- 2017-10-9
ALTER TABLE `enterprise_pt_products` ADD KEY `idx_iteration` (`site_id`, `deleted`);
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
