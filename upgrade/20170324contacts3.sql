ALTER TABLE `enterprise_thumbnails`
  MODIFY `378x270` `t` mediumblob NOT NULL COMMENT 't',
  MODIFY `54x39` `m` mediumblob NOT NULL COMMENT 'm',
  MODIFY `140x100` `d` mediumblob NOT NULL COMMENT 'd',
  MODIFY `329x235` `c` mediumblob NOT NULL COMMENT 'c';

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
  `logo` int(10) unsigned NOT NULL COMMENT 'LOGO图片ID',
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
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司表';

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

CREATE TABLE `enterprise_sites` (
  `site_id` int(10) unsigned NOT NULL COMMENT '站点ID',
  `template` varchar(45) NOT NULL COMMENT '模板名称',
  `updated` datetime NOT NULL COMMENT '最近修改时间',
  `start_year` smallint unsigned NOT NULL COMMENT '起始年份',
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点表';

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
