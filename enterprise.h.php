<?php
/**
 * 项目公用函数库
 *
 * @package timandes\enterprise
 */

/** @var string Pattern of Product Pic */
define('PATTERN_PRODUCT_PIC', '/^\/pic-([0-9]+)\.html$/');
/** @var string Pattern of Detailed Product */
define('PATTERN_DETAILED_PRODUCT', '/^\/sell-detail-([0-9]+)((-[0-9a-z]+)+)?\.html$/');
/** @var string Pattern of Product Index */
define('PATTERN_PRODUCT_INDEX', '/^\/products(-([0-9]+))?\.html$/');
/** @var string Pattern of Product Search */
define('PATTERN_PRODUCT_SEARCH', '/^\/s((-[0-9a-z]+)+)?\.html$/');
/** @var string Pattern of Product Directory */
define('PATTERN_PRODUCT_DIRECTORY', '/^\/directory(-([0-9]+))?\.html$/');
/** @var string Pattern of News List */
define('PATTERN_NEWS_LIST', '/^\/news(-([0-9]+))?$/');
/** @var string Pattern of News Page */
define('PATTERN_NEWS_PAGE', '/^\/news-([0-9]+)((-[0-9a-z]+)+)?\.html$/');
/** @var string Pattern of Keywords List */
define('PATTERN_KEYWORDS_LIST', '/^\/words-([A-Z]|number)(-([0-9]+))?\.html$/');

/** @var string Fields of Product for List */
define('ENTERPRISE_PRODUCT_FIELDS_FOR_LIST', '`id`, `caption`, `head_image_id`, `group_id`, `brand_name`, `model_number`, `certification`, `place_of_origin`, `min_order_quantity`, `price`, `payment_terms`, `supply_ability`, `delivery_time`, `packaging_details`, `path`');
define('ENTERPRISE_LANG_PRODUCT_FIELDS_FOR_LIST', 'ep.`id`, elp.`caption`, ep.`head_image_id`, elp.`group_id`, ep.`brand_name`, ep.`model_number`, ep.`certification`, ep.`place_of_origin`, elp.`min_order_quantity`, ep.`price`, ep.`payment_terms`, ep.`supply_ability`, elp.`delivery_time`, elp.`packaging_details`, ep.`path`');
/** @var string Fields of Custom Page for List */
define('ENTERPRISE_CUSTOM_PAGE_FIELDS_FOR_LIST', '`id`, `path`, `desc`, `created`, `updated`');
/** @var int Max Urls per File */
define('ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE', 5000);

/** @var string Fields of News for info */
define('ENTERPRISE_NEWS_FIELDS_FOR_INFO', 'n.`id`, ln.`caption`, n.`head_image_id`, ln.`created`, ln.`updated`, ln.`content`');

/** @var int 存在Blob中的图片ID长度阀值 */
define('ENTERPRISE_IMAGE_ID_IN_BLOB_LEN_THRESHOLD', 20);

/* {{{ ENTERPRISE_PLATFORM_* */
/** @var int PC端 */
define('ENTERPRISE_PLATFORM_PC', 10);
/** @var int 移动端 */
define('ENTERPRISE_PLATFORM_MOBILE', 20);
/* }}} */

/* {{{ ENTERPRISE_PRODUCT_PAGE_TYPE_* */
/** @var int 默认产品页 */
define('ENTERPRISE_PRODUCT_PAGE_TYPE_DEFAULT', 10);
/** @var int 移动端专属的详情页 */
define('ENTERPRISE_PRODUCT_PAGE_TYPE_DETAILED', 20);
/** @var int PC端专属的大图页 */
define('ENTERPRISE_PRODUCT_PAGE_TYPE_PIC', 30);
/* }}} */

/** @var int 最大允许的首页产品数 */
define('ENTERPRISE_MAX_INDEX_PRODUCTS', 20);

/** @var array Product Desc Mapping */
$productDescMapping = array(// Key 'label' is deprecated.
        'place_of_origin' => array(
                'label' => 'Place of Origin',
                'default' => '',
            ),
        'brand_name' => array(
                'label' => 'Brand Name',
                'default' => '',
                ''
            ),
        'certification' => array(
                'label' => 'Certification',
                'default' => '',
            ),
        'model_number' => array(
                'label' => 'Model Number',
                'default' => '',
            ),
        'min_order_quantity' => array(
                'label' => 'Min.Order Quantity',
                'default' => '1 Piece',
            ),
        'price' => array(
                'label' => 'Price',
                'default' => 'Negotiable',
            ),
        'packaging_details' => array(
                'label' => 'Packaging Details',
                'default' => '',
            ),
        'delivery_time' => array(
                'label' => 'Delivery Time',
                'default' => '',
            ),
        'payment_terms' => array(
                'label' => 'Payment Terms',
                'default' => '',
            ),
        'supply_ability' => array(
                'label' => 'Supply Ability',
                'default' => '',
            ),
    );

/** @var array Contact Desc Mapping */
$contactDescMapping = array(
        'name' => 'contact_person',
        'title' => 'job_title',
        'tel' => 'business_phone',
        'skype' => 'Skype',
        'email' => 'Email',
        'yahoo' => 'Yahoo',
        'icq' => 'ICQ',
        'viber' => 'Viber',
        'whatsapp' => 'WhatsApp',
    );


/* {{{ Common */

/**
 * 构建移动端域名
 */
function enterprise_build_alternate_mobile_host($langCode, $rootDomain)
{
    $subdomain = '';
    if ($langCode != $GLOBALS['gsDefaultLangCode'])
        $subdomain = $langCode . '.';
    return 'm.' . $subdomain . $rootDomain;
}

/**
 * 构建PC端域名
 */
function enterprise_build_canonical_host($langCode, $rootDomain)
{
    if ($langCode == $GLOBALS['gsDefaultLangCode'])
        $subdomain = 'www.';
    else
        $subdomain = $langCode . '.';
    return $subdomain . $rootDomain;
}

/**
 * 从Host中分离出语言类型和域名
 */
function enterprise_extract_locale_n_domain($host)
{
    $meta = enterprise_extract_host_meta($host);
    return array($meta['locale'], $meta['root_domain']);
}

function enterprise_decide_locale_by_subdomain($subdomain)
{
    $retval = ($subdomain=='www'||$subdomain=='m'?$GLOBALS['gsDefaultLocale']:$subdomain);
    if (strlen($retval) == 2) {
        $iso639 = new Matriphe\ISO639\ISO639();
        $retval = $iso639->languageByCode1($retval);
    }
    return $retval;
}

function enterprise_decide_platform_by_subdomain($subdomain)
{
    return (($subdomain == 'm')?ENTERPRISE_PLATFORM_MOBILE:ENTERPRISE_PLATFORM_PC);
}

/**
 * 从Host中分离出信息元
 */
function enterprise_extract_host_meta($host)
{
    $pslManager = new Pdp\PublicSuffixListManager();
    $parser = new Pdp\Parser($pslManager->getList());
    $hostObj = $parser->parseHost($host);

    $currentDomainSuffix = $hostObj->registerableDomain;
    $subdomain = $hostObj->subdomain;
    if (strpos($subdomain, '.') === false) {
        $locale = enterprise_decide_locale_by_subdomain($subdomain);
        $platform = enterprise_decide_platform_by_subdomain($subdomain);
    } else {
        $a = explode('.', $subdomain);
        if ($a[0] == 'origin')
            array_shift($a);
        if (count($a) > 1)
            $locale = enterprise_decide_locale_by_subdomain($a[1]);
        else
            $locale = enterprise_decide_locale_by_subdomain($a[0]);
        $platform = enterprise_decide_platform_by_subdomain($a[0]);
    }

    return array(
            'locale' => $locale,
            'root_domain' => $currentDomainSuffix,
            'platform' => $platform,
            'subdomain' => $subdomain,
        );
}

/**
 * 获取站点基本信息
 */
function enterprise_extract_site_infos()
{
    global $siteInfo;

    $hostMeta = enterprise_extract_host_meta($_SERVER['HTTP_HOST']);
    $locale = $hostMeta['locale'];
    $currentDomainSuffix = $hostMeta['root_domain'];
    $platform = $hostMeta['platform'];
    $subdomain = $hostMeta['subdomain'];

    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    $condition = "`domain`='" . $siteMappingDAO->escape($currentDomainSuffix) . "'";
    $siteMapping = $siteMappingDAO->getOneBy($condition);
    if (!$siteMapping)
        throw new HttpException(403);

    $siteId = $siteMapping['site_id'];

    if (!isset($siteInfo[$siteId])
            || !is_array($siteInfo[$siteId]))
        $originalDomainSuffix = '';
    else
        $originalDomainSuffix = $siteInfo[$siteId]['original_domain_prefix'];

    $langCode = '';
    if ($locale) {
        $iso639 = new Matriphe\ISO639\ISO639();
        $langCode = $iso639->code1ByLanguage($locale);
        if (!$langCode)
            throw new HttpException(404, 'Unsupported locale');
    }

    return array(
            $siteId, $platform, $locale, $langCode, $originalDomainSuffix, $currentDomainSuffix, $subdomain
        );
}

function enterprise_remove_parameter_dbg($requestUri)
{
    $uri = new GuzzleHttp\Psr7\Uri($requestUri);
    $uri = GuzzleHttp\Psr7\Uri::withoutQueryValue($uri, 'dbg');
    return $uri->__toString();
}

function enterprise_match_ipaddr_with_wildcard($needle, $haystack)
{
    if (!$haystack)
        return false;

    $prefix = str_replace('.*', '', $haystack);
    return (strpos($needle, $prefix) === 0);
}

/**
 * Generate GUID
 *
 * @deprecated timandes_generate_guid()
 */
function enterprise_generate_guid()
{
    return md5(uniqid(mt_rand(), true), true);
}

function enterprise_filter_response($content, $originalDomainSuffix, $currentDomainSuffix)
{
    $content = str_replace('<script type=text/javascript src="/webim/webim.js"></script>', '', $content);
    $content = str_replace($originalDomainSuffix, $currentDomainSuffix, $content);
    $content = str_replace('//www.google-analytics.com/analytics.js', '', $content);
    return $content;
}

function enterprise_print_cnzz($meta)
{
    if (!isset($meta['id'])
            || !$meta['id'])
        return;

    $paramShow = '';
    if (isset($meta['pic'])
            && $meta['pic'])
        $paramShow = '%26show%3Dpic' . $meta['pic'];

    echo <<<EOT
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_{$meta['id']}'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/z_stat.php%3Fid%3D{$meta['id']}{$paramShow}' type='text/javascript'%3E%3C/script%3E"));</script>
EOT;
}

function enterprise_output_cnzz($currentDomainSuffix)
{
    global $domainInfo;

    if (isset($domainInfo[$currentDomainSuffix]['cnzz'])
            && is_array($domainInfo[$currentDomainSuffix]['cnzz']))
        enterprise_print_cnzz($domainInfo[$currentDomainSuffix]['cnzz']);
}

/**
 * 标准化处理可能出现在URL中的短语
 *  源自：china.cn
 */
function enterprise_standardize_url_key($s)
{
    return strtolower(preg_replace('/[\s]+/',' ',str_replace(array('?','!',',',':',';','|','-','(',')','[',']','{','}','<','>','/','\\','@','#','$','%','^','&','*','+','`','"',"'",'~'),' ',$s)));
}

/**
 * 处理url中的关键字
 *  源自：china.cn
 */
function enterprise_generate_url_key($str)
{
    return trim(preg_replace('/([\s]|[^0-9a-zA-Z])+/', '-', enterprise_standardize_url_key($str)), '-');
}

/**
 * URL关键词 => 关键词
 *
 * @return string
 */
function enterprise_extract_url_key($urlKey)
{
    return str_replace('-', ' ', ltrim($urlKey, '-'));
}

/**
 * 计算分页关键参数
 *
 * @return array
 */
function enterprise_pager_calculate_key_infos($total, $size, $cur)
{
    $pagesEachSlice = 7;
    $retval = array();
    $retval['pages'] = (int)($total / $size) + (($total % $size)?1:0);
    $retval['first_page'] = (($cur > 1)?1:null);
    $retval['prev_page'] = (($cur > 1)?($cur - 1):null);
    $retval['min_page'] = (($cur - 3 <= 0)?1:($cur - 3));
    $retval['max_page'] = min($retval['pages'], $retval['min_page'] + ($pagesEachSlice - 1));
    $retval['next_page'] = (($cur < $retval['pages'])?($cur + 1):null);
    $retval['last_page'] = (($cur < $retval['pages'])?$retval['pages']:null);
    return $retval;
}

/**
 * 返回DAO对象
 *
 * @return \crawler\daos\AbstractDAO
 */
function enterprise_dao($alias)
{
    switch ($alias) {
        case 'corporation':
            return new \enterprise\daos\Corporation();
    }

    return null;
}

function enterprise_define_url_pattern_constants($site)
{
    $gUrlPrefix = ($site['gurl_prefix']?$site['gurl_prefix']:'factory');
    $GLOBALS['gaUrlPrefixes']['group'] = $gUrlPrefix;

    $pUrlPrefix = ($site['purl_prefix']?$site['purl_prefix']:'sell');
    $GLOBALS['gaUrlPrefixes']['product'] = $pUrlPrefix;

    $GLOBALS['gaUrlPatterns']['group'] = '/^\/' . $GLOBALS['gaUrlPrefixes']['group'] . '-([0-9]+)(p([0-9]+))?((-[0-9a-z]+)+)?$/';
}

function enterprise_set_default_lang_code($langCode)
{
    $GLOBALS['gsDefaultLangCode'] = $langCode;
    $iso639 = new Matriphe\ISO639\ISO639();
    $GLOBALS['gsDefaultLocale'] = $iso639->languageByCode1($langCode);
}

/* }}} */

/* {{{ Sitemap */

/**
 * 展示Sitemap Index页面
 */
function enterprise_action_sitemap_index_proc($siteId, $omsSite, $platform, $langCode, $currentDomainSuffix)
{
    $translationDAO = new \crawler\daos\Translation();
    $sitemapIndex = new \Thepixeldeveloper\Sitemap\SitemapIndex(); 
    $translations = $translationDAO->getBySite($siteId);

    // Core Pages
    $loc = enterprise_url_sitemap($currentDomainSuffix, 'core');
    $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
    $sitemapIndex->addSitemap($sitemap);

    // Crawled pages
    if (is_array($translations)
            && $translations) foreach ($translations as $translation) {
        $loc = $_SERVER['REQUEST_SCHEME'] . '://www.' . $currentDomainSuffix . '/sitemap/' . $translation['locale'] . '.xml';
        $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
        $sitemapIndex->addSitemap($sitemap);
    }

    {
        // Products
        $site = enterprise_get_site_info($siteId, $langCode);
        $productCnt = (int)$site['product_cnt'];
        $productsPerFile = ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE;
        $sitemapFiles = (int)($productCnt / $productsPerFile) + (($productCnt % $productsPerFile)?1:0);
        for ($i=1; $i<=$sitemapFiles; ++$i) {
            $loc = enterprise_url_sitemap($currentDomainSuffix, 'product', $i);
            $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
            $sitemapIndex->addSitemap($sitemap);
        }
    }

    // Groups
    $loc = enterprise_url_sitemap($currentDomainSuffix, 'group');
    $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
    $sitemapIndex->addSitemap($sitemap);

    // Keyword List
    if (!$omsSite
                || !$omsSite['crawled']) {// 非爬取
        foreach (KEYWORD_ALPHABET as $char => $v) {
            $loc = enterprise_url_sitemap($currentDomainSuffix, 'keywords-' . $char);
            $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
            $sitemapIndex->addSitemap($sitemap);
        }
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($sitemapIndex);
    exit(0);
}

/**
 * 展示Sitemap页面
 */
function enterprise_action_sitemap_proc($siteId, $originalDomainSuffix, $currentDomainSuffix, $locale)
{
    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 

    // All crawled pages
    $skippingPages = array(
        '/contactnow.html',
        '/contactsave.html',
    );
    $pageDAO = new \crawler\daos\Page();
    $curId = 0;
    do {
        $pages = $pageDAO->getBySite($siteId, $locale, $curId);
        if (!$pages)
            break;

        foreach ($pages as $page) {
            $curId = max($curId, $page['id']);

            $urlPath = parse_url($page['url'], PHP_URL_PATH);
            if (in_array($urlPath, $skippingPages))
                continue;

            $loc = str_replace($originalDomainSuffix, $currentDomainSuffix, $page['url']);
            $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
            $urlSet->addUrl($url);
        }
    } while(true);

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}

/**
 * 展示Sitemap页面
 */
function enterprise_action_sitemap_proc_2($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $no = 1)
{
    $site = enterprise_get_site_info($siteId, $langCode);
    enterprise_define_url_pattern_constants($site);

    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 

    $products = enterprise_product_iteration($siteId, $langCode, $no, ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE);
    if ($products) foreach ($products as $product) {
        $loc = enterprise_url_product($product);
        $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
        $urlSet->addUrl($url);
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}

function enterprise_get_keywords_generator($userSiteId, $langCode, $alphabet)
{
    $curKeywordId = 0;
    do {
        //if ($langCode == 'en')
            $keywords = enterprise_get_keyword_list($userSiteId, $langCode, $alphabet, 1, 100, "`id`>{$curKeywordId}", '`id` ASC');
        //else {
            //$keywords = enterprise_get_keyword_list($userSiteId, $langCode, $alphabet, 1, 100, "elp.`keyword_id`>{$curKeywordId}", 'elp.`keyword_id` ASC', enterprise_keyword_transform_field_list_for_lang_site($extraFieldList));
        //}
        if (!$keywords)
            break;

        foreach ($keywords as $keyword) {
            yield $keyword;

            $curKeywordId = $keyword['id'];
        }
    } while(true);
}

/**
 * 展示Sitemap页面
 */
function enterprise_action_sitemap_keyword_proc($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $firstChar, $no = 1)
{
    $site = enterprise_get_site_info($siteId, $langCode);
    enterprise_define_url_pattern_constants($site);

    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset();

    $alphabet = (array_key_exists($firstChar, KEYWORD_ALPHABET)?KEYWORD_ALPHABET[$firstChar]:0);
    $keywords = enterprise_get_keyword_list($siteId, $langCode, $alphabet, $no, ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE, null, '`id` ASC');
    if ($keywords) foreach ($keywords as $keyword) {
        $loc = enterprise_url_product_search($keyword['keyword']);
        $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
        $urlSet->addUrl($url);
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}

/**
 * 以Sitemap格式输出全部分组的URL
 */
function enterprise_action_sitemap_group_proc($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 

    // groups
    $curGroupId = 0;
    $max = 100;
    do {
        if ($langCode == 'en')
            $groups = enterprise_get_group_list($siteId, $langCode, $max, "`id`>{$curGroupId}");
        else
            $groups = enterprise_get_group_list($siteId, $langCode, $max, "lg.`group_id`>{$curGroupId}");
        if (!$groups)
            break;

        foreach ($groups as $group) {
            $curGroupId = max($curGroupId, $group['id']);

            if ($group['cnt'] > 0) {
                $loc = enterprise_url_product_list($group);
                $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
                $urlSet->addUrl($url);
            }
        }
    } while(true);

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}


/**
 * 以Sitemap格式输出核心页面的URL
 */
function enterprise_action_sitemap_core_proc($siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 

    foreach (['/', '/products.html', '/aboutus.html', '/quality.html', '/contactus.html'] as $path) {
        $loc = enterprise_url_prefix() . $path;
        $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
        $urlSet->addUrl($url);
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}
/* }}} */

function enterprise_output_image_body($imageId)
{
    $imageDAO = new \enterprise\daos\Image();
    for ($i=0; $i<5; ++$i) {
        $image = $imageDAO->get($imageId);
        if (!$image) {
            http_response_code(404, 'No that image');
            exit;
        }
        if (strlen($image['body']) > ENTERPRISE_IMAGE_ID_IN_BLOB_LEN_THRESHOLD)
            break;
        $imageId = (int)$image['body'];
    }

    header('Content-Type: image/jpeg');
    echo $image['body'];
}

/**
 * 展示用户新发图片
 */
function enterprise_action_uploaded_image_proc($char, $imageId)
{
    if (!$imageId) {
        http_response_code(400);
        exit;
    }

    if ($char) {
        $field = $char;

        $thumbnailDAO = new \enterprise\daos\Thumbnail();
        for ($i=0; $i<5; ++$i) {
            $condition = "`image_id`=" . (int)$imageId;
            $thumbnail = $thumbnailDAO->getOneBy($condition);
            if (!$thumbnail
                    || !$thumbnail[$field]) {
                enterprise_output_image_body($imageId);
                exit;
            }
            if (strlen($thumbnail[$field]) > ENTERPRISE_IMAGE_ID_IN_BLOB_LEN_THRESHOLD)
                break;
            $imageId = (int)$thumbnail[$field];
        }

        header('Content-Type: image/jpeg');
        header('Cache-Control: max-age=3600');
        echo $thumbnail[$field];
    } else {
        enterprise_output_image_body($imageId);
    }
    exit;
}

/**
 * 从字符串中解析出产品标签数组
 *
 * @return array
 */
function enterprise_extract_product_tags($tagsString)
{
    $productTags = array();
    $a = explode(',', $tagsString);
    foreach ($a as $tag) {
        $t = trim($tag);
        if (!$t)
            continue;
        $productTags[] = $t;
    }
    return $productTags;
}

function enterprise_assign_action_product_detail($smarty, $siteId, $langCode, $productId)
{
    $product = enterprise_get_product_info($productId, $langCode);
    if (!$product) 
        throw new HttpException(404, 'No that product');
    if ($product['deleted'])
        throw new HttpException(404, 'No that product#2');
    $smarty->assign('product', $product);

    // Tags
    $productTags = ($product['tags']?enterprise_extract_product_tags($product['tags']):array());
    $smarty->assign('product_tags', $productTags);

    // Images
    $productImages = array();
    if ($product['images']) {
        $productImages = json_decode($product['images'], true);
    }
    $smarty->assign('product_images', $productImages);

    // Specifications
    $productSpecifications = array();
    if ($product['specifications']) {
        $productSpecifications = json_decode($product['specifications'], true);
    }
    $smarty->assign('product_specifications', $productSpecifications);

    // Groups
    $groups = enterprise_assign_group_list_ex($smarty, 'groups', $siteId, $langCode);

    // Product Group
    foreach ($groups as $group) {
        $groupId = $group['id']??$group['group_id'];
        if ($groupId == $product['group_id']) {
            $smarty->assign('group', $group);
            $smarty->assign('product_group', $group);
            break;
        }
    }

    // New Products
    enterprise_assign_product_list($smarty, 'new_products', $siteId, $langCode, $product['group_id']);
}

/**
 * Product Detail
 */
function enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId)
{
    if (!$productId)
        throw new HttpException(404, 'Illegal ID');

    enterprise_assign_action_product_detail($smarty, $siteId, 'en', $productId);

    $tplPath = 'sites/' . $siteId . '/product_detail.tpl';
    if (!$smarty->templateExists($tplPath))
        throw new HttpException(404, 'No that template');

    $response = $smarty->fetch($tplPath);
    echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_output_cnzz($currentDomainSuffix);
}

function enterprise_assign_action_product_list($smarty, $siteId, $langCode = 'en', $groupId = null, $pageNo = 1, $pageSize = 10)
{
    // Product list
    $condition = enterprise_assign_product_list($smarty, 'products', $siteId, $langCode, $groupId, $pageNo, $pageSize);

    // Total products
    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = new \enterprise\daos\LangProduct($langCode);
    $totalProducts = $productDAO->countBy($condition);
    $totalPages = (int)($totalProducts / $pageSize) + (($totalProducts % $pageSize)?1:0);
    $smarty->assign('total_products', $totalProducts);
    $smarty->assign('page_size', $pageSize);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);
    $pagerInfo = timandes_pager_calculate_key_infos($totalProducts, $pageSize, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    // Group info
    if ($groupId
            && is_numeric($groupId)) {
        enterprise_assign_group_info($smarty, 'group', $groupId, $langCode);
        $group = $smarty->getTemplateVars('group');
        if (!$group) 
            throw new HttpException(404, 'No that group');
        if ($group['deleted'])
            throw new HttpException(404, 'No that group#2');
    }

    // All groups
    enterprise_assign_group_list_ex($smarty, 'groups', $siteId, $langCode);
}

/**
 * Product List
 */
function enterprise_action_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId = null, $pageNo = 1)
{
    if (!$groupId)
        throw new HttpException(404, 'Illegal group ID');

    $pageSize = enterprise_site_info_get_product_list_page_size($siteId);
    if (!$pageSize)
        $pageSize = 10;

    enterprise_assign_action_product_list($smarty, $siteId, 'en', $groupId, $pageNo, $pageSize);

    // Filter
    $tplPath = 'sites/' . $siteId . '/product_list.tpl';
    if (!$smarty->templateExists($tplPath))
        throw new HttpException(404, 'No that list template');

    $response = $smarty->fetch($tplPath);
    echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_output_cnzz($currentDomainSuffix);
}

/**
 * XSS Clean
 *
 * @return string
 */
function xss_clean($s)
{
    $antiXss = new voku\helper\AntiXSS();
    $antiXss->removeEvilAttributes(array('style'));
    return $antiXss->xss_clean($s);
}

/**
 * Remove \n N \r
 *
 * @return string
 */
function remove_n_r($s)
{
    $retval = $s;
    $retval = str_replace("\n", '', $retval);
    $retval = str_replace("\r", '', $retval);
    return $retval;
}

function enterprise_upload_attachments_from_post_data()
{
    $attachmentDAO = new \enterprise\daos\Attachment();
    $attachments = array();
    foreach ($_FILES as $meta) {
        if ($meta['error'])
            continue;
        $body = file_get_contents($meta['tmp_name']);
        $contentType = $meta['type'];
        $guid = enterprise_generate_guid();
        $values = array(
                'guid' => $guid,
                'body' => $body,
                'content_type' => $contentType,
                'created' => date('Y-m-d H:i:s'),
            );
        $id = $attachmentDAO->insert($values);
        $attachments[] = bin2hex($guid);
    }
    return $attachments;
}

function enterprise_in_threatening_targets($email, $remoteAddr = null)
{
    if (!$remoteAddr)
        $remoteAddr = timandes_get_remote_addr();

    $threateningTargetDAO = new \oms\daos\ThreateningTarget();
    $condition = "`email`='" . $threateningTargetDAO->escape($email) . "'";
    $tt = $threateningTargetDAO->getOneBy($condition);
    if ($tt
            && !$tt['deleted'])
        return true;

    $condition = "`ip_addr`='" . $threateningTargetDAO->escape($remoteAddr) . "'";
    $tt = $threateningTargetDAO->getOneBy($condition);
    if ($tt
            && !$tt['deleted'])
        return true;

    return false;
}

/**
 * 从POST表单获取数据保存至询盘表
 *
 * @return array (subject, message, email)
 */
function enterprise_save_inquiry_from_post_data($site, $currentDomainSuffix, $type = null, $ipAddr = null, $created = null, $targetProductId = null)
{
    $siteId = $site['site_id'];

    $subject = timandes_get_post_data('subject');
    $message = timandes_get_post_data('message', 'trim, xss_clean');
    $email = timandes_get_post_data('email');

    // Ignore Threatening Targets
    $r = enterprise_in_threatening_targets($email);
    if ($r)
        throw new \RuntimeException("Forbidden #1", 111);

    $messageType = timandes_get_post_data('message_type');
    if ($messageType == 'text/plain')
        $message = nl2br($message);

    if ($type === null)
        $type = \enterprise\daos\Inquiry::TYPE_NATURAL;
    if (!$created)
        $created = date('Y-m-d H:i:s');
    if (!$ipAddr)
        $ipAddr = timandes_get_remote_addr();
    if ($targetProductId === null)
        $targetProductId = (int)timandes_get_post_data('target_product_id');

    // Validation
    if (!$subject)
        throw new \RuntimeException("Please input subject");
    if (!$message)
        throw new \RuntimeException("Please input message");
    if (!$email)
        throw new \RuntimeException("Please input email");

    // Upload files
    $attachments = enterprise_upload_attachments_from_post_data();

    // Create inquiry
    $values = array(
            'subject' => $subject,
            'message' => $message,
            'courtesy_title' => timandes_get_post_data('gender'),
            'company' => timandes_get_post_data('company'),
            'tel' => timandes_get_post_data('tel'),
            'fax' => timandes_get_post_data('fax'),
            'website' => timandes_get_post_data('senderwebsite'),
            'country' => timandes_get_post_data('country'),
            'contact' => timandes_get_post_data('name'),
            'email' => $email,
            'price_n_terms' => timandes_get_post_data('incoterm'),
            'payment' => timandes_get_post_data('payment'),
            'initial_order' => timandes_get_post_data('order'),
            'sample_terms' => timandes_get_post_data('sample'),
            'request_specifications' => timandes_get_post_data('othersc'),
            'request_company_description' => timandes_get_post_data('othercd'),
            'request_deliver_time' => timandes_get_post_data('otherscdt'),
            'contact_within_24h' => timandes_get_post_data('iscontact'),
            'email_me_updates' => timandes_get_post_data('newsletter'),
            'site_id' => $siteId,
            'attachments' => $attachments,
            'created' => $created,
            'domain' => $currentDomainSuffix,
            'ip' => $ipAddr,
            'target_product_id' => $targetProductId,
            'type' => $type,
        );
    if ($site['enable_inquiry_checking']) {// 需要审核
        $values = array(
                'data' => $values,
            );
        $pendingInquiryDAO = new \enterprise\daos\PendingInquiry();
        $pendingInquiryDAO->insert($values);
    } else {
        $values['guid'] = enterprise_generate_guid();
        $inquiryDAO = new \enterprise\daos\Inquiry();
        $inquiryDAO->insert($values);
    }

    return array(
            $subject, $message, $email,
        );
}

function enterprise_get_site_mapping_list($siteId = null)
{
    $siteMappingDAO = new \enterprise\daos\SiteMapping();
    if ($siteId)
        $condition = "sm.`site_id`={$siteId}";
    else
        $condition = null;
    return $siteMappingDAO->getMultiInOrderBy($condition, 'sm.`id`, os.`id` AS `site_id`, os.`created`, os.`updated`, os.`type`, es.`offline`, sm.`domain`, es.`lang_codes`', 'sm.`domain` ASC');
}

/**
 * 向站内的第一个用户发送询盘邮件
 */
function enterprise_send_inquiry_email_to_user($siteId, $inquirySubject, $inquiryMessage, $inquiryEmail)
{
    $siteMappings = enterprise_get_site_mapping_list($siteId);
    $domainDesc = '';
    $adminDesc = '网站后台';
    if (isset($siteMappings[0])
            && is_array($siteMappings[0])
            && isset($siteMappings[0]['domain'])
            && $siteMappings[0]['domain']) {
        $domainDesc = '（' . $siteMappings[0]['domain'] . '）';
        $adminDesc = '<a href="http://www.' . $siteMappings[0]['domain'] . '/admin/" target="_blank">网站后台</a>';
    }

    $mailSubject = '您的网站' . $domainDesc . '收到一封询盘';
    $mailBody = '<p>亲爱的外贸人：</p><p>　　你的网站' . $domainDesc . '来询盘啦！快登录' . $adminDesc . '跟进啦！祝你出单顺利！</p>';

    $userDAO = new \enterprise\daos\User();
    $condition = "`site_id`=" . (int)$siteId;
    $user = $userDAO->getOneBy($condition);
    if ($user
            && $user['email']
            && Nette\Utils\Validators::is($user['email'], 'email')) {
        $mailDomain = 'mail.50u50.com';
        $from = 'no-reply@' . $mailDomain;
        $mail = timandes_initialize_mail_message($user['email'], $from, $inquiryEmail, $mailSubject, $mailBody);
        $mailer = new Nette\Mail\SmtpMailer(array(
                'host' => $mailDomain,
            ));
        $mailer->send($mail);
    }
}


/**
 * 保存询盘
 */
function enterprise_action_save_inquiry_proc($smarty, $siteId, $platform, $originalDomainSuffix, $currentDomainSuffix, $fakeRequestURL)
{
    $site = enterprise_get_site_info($siteId);
    $tplPath = enterprise_decide_template_path($smarty, $site, $platform, '/contactsave.tpl');
    if ($tplPath) {
        // Site
        $smarty->assign('site', $site);

        // Corporation
        enterprise_assign_corporation_info($smarty, 'corporation', $siteId);

        // Groups
        $groups = enterprise_assign_group_list($smarty, 'groups', $siteId, 2, true, true, 5);

        // Domain suffix
        $smarty->assign('site_root_domain', $currentDomainSuffix);
    }

    $threateningSource = false;// 危险源
    try {
        list($subject, $message, $email) = enterprise_save_inquiry_from_post_data($site, $currentDomainSuffix);
    } catch (\RuntimeException $e) {
        if ($e->getCode() == 111) 
            $threateningSource = true;
        else {
            header('Location: /contactnow.html');
            exit(0);
        }
    } catch (\Exception $e) {
        header('Location: /contactnow.html');
        exit(0);
    }

    // Send Email
    if (!$threateningSource
            && !$site['enable_inquiry_checking']) {// 不需要审核
        enterprise_send_inquiry_email_to_user($siteId, $subject, $message, $email);
    }

    // Response HTML
    if (!$tplPath) {
        $fakeRequestURLSum = md5($fakeRequestURL, true);
        enterprise_response_crawled_page($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $fakeRequestURLSum);// Terminated when page exists
        $tplPath = 'inquiry_sent.tpl';// Use default tpl
    }

    $smarty->display($tplPath);
}

/**
 * robots.txt
 */
function enterprise_action_robots_txt($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    header('Content-Type: text/plain');
    $smarty->display('robots.tpl');
}

/** 
 * 尝试匹配产品页URL
 */
function enterprise_match_url_product($requestPath, &$productId = null, &$pageNo = null, $langCode = null, $site = null)
{
    $r = preg_match($GLOBALS['gaUrlPatterns']['product'], $requestPath, $matches);
    if (!$r)
        return false;

    $prefix = $matches[1];
    $productId = $matches[2];

    if (isset($matches[4])
            && $matches[4])
        $pageNo = (int)$matches[4];
    else
        $pageNo = 1;

    $prefixMatched = false;

    // group.purl_prefix
    if ($langCode) {
        $product = enterprise_get_product_info($productId, $langCode);
        if ($product
                && $product['group']
                && $product['group']['purl_prefix']) {
            if ($prefix != $product['group']['purl_prefix'])
                return false;
            else
                $prefixMatched = true;
        }
    }

    // site.purl_prefix
    if (!$prefixMatched
            && $site
            && $site['purl_prefix']) {
        if ($prefix != $site['purl_prefix'])
            return false;
        else
            $prefixMatched = true;
    }

    // sell-
    if (!$prefixMatched
            && $prefix != 'sell')
        return false;

    return $r;
}

/**
 * Router
 */
function enterprise_route($smarty, $siteId, $platform, $originalDomainSuffix, $currentDomainSuffix, $fakeRequestURL)
{
    $requestPath = parse_url($fakeRequestURL, PHP_URL_PATH);

    if ($requestPath == '/contactsave.html') {
        return enterprise_action_save_inquiry_proc($smarty, $siteId, $platform, $originalDomainSuffix, $currentDomainSuffix, $fakeRequestURL);
    } elseif(enterprise_match_url_product($requestPath, $productId)) {
        return enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId);
    } elseif ($requestPath == '/robots.txt') {
        return enterprise_action_robots_txt($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(preg_match($GLOBALS['gaUrlPatterns']['group'], $requestPath, $matches)) {
        $groupId = $matches[1];
        if ($matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        return enterprise_action_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId, $pageNo);
    }

    throw new HttpException(404, 'V1 routing fails');
}

/**
 * 移动跳转
 */
function enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode = 'en')
{
    if ($userAgent->isMobile()
            && $platform == ENTERPRISE_PLATFORM_PC) {
        $host = enterprise_build_alternate_mobile_host($langCode, $currentDomainSuffix);
        header('Location: ' . $_SERVER['REQUEST_SCHEME'] . '://' . $host . $_SERVER['REQUEST_URI']);
        exit(1);
    }
}

/**
 * 加载预设翻译
 */
function enterprise_load_preset_translations($langCode)
{
    $path = __DIR__ . '/locale/' . $langCode . '.php';
    if (!file_exists($path))
        throw new \DomainException("Unsupported lang {$langCode}");

    include $path;
    return $presetTranslations;
}

/**
 * Assign预设翻译
 */
function enterprise_get_preset_translations($smarty, $langCode)
{
    $untranslatedEntryPrefix = '';
    $presetTranslations = $presetEnTranslations = enterprise_load_preset_translations('en');
    if ($langCode != 'en') {
        $presetLangTranslations = enterprise_load_preset_translations($langCode);
        foreach ($presetEnTranslations as $key => $pt) {
            if (isset($presetLangTranslations[$key]))
                $presetTranslations[$key] = $presetLangTranslations[$key];
            else
                $presetTranslations[$key] = $untranslatedEntryPrefix . $pt;
        }
    }

    return $presetTranslations;
}

/**
 * Assign预设翻译
 */
function enterprise_assign_preset_translations($smarty, $langCode)
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $smarty->assign('preset_translations', $presetTranslations);
}


function enterprise_get_hide_site_info($siteId)
{
    $hideSiteDAO = new \hide\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    return $hideSiteDAO->getOneBy($condition);
}

function enterprise_assign_hide_site_info($smarty, $var, $siteId)
{
    $hideSite = enterprise_get_hide_site_info($siteId);
    $smarty->assign($var, $hideSite);
}


function enterprise_iparea_get_info_from_addr($ipv4Addr)
{
    $db = \DbFactory::create('crawler');

    $ipv4AddrLong = ip2long($ipv4Addr);
    if (!$ipv4Addr)
        return false;

    $sql = "SELECT * FROM `enterprise_iparea` WHERE `ip`<{$ipv4AddrLong} ORDER BY `ip` DESC LIMIT 1";
    $r = $db->query($sql);
    if (!$r)
        return false;

    $retval = $r->fetch_assoc();
    $r->free();

    return $retval;
}

/**
 * Router V2
 *
 * @return string Response
 */
function enterprise_route_2($smarty, $omsSite, $site, $userAgent, $siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $requestURL, $requestPath, $requestPathSum)
{
    // Non-pages
    if (preg_match('/^\/attachments\/([0-9a-f]{32})$/', $requestPath, $matches)) {
        $guidHex = $matches[1];
        return enterprise_action_attachment_proc($guidHex);
    }

    enterprise_assign_hide_site_info($smarty, 'hide_site', $siteId);

    if ($requestPath == '/') {
        return enterprise_action_sets_home_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix);
    }// Skip 'Common queries'

    // Common queries
    enterprise_action_sets_common_proc($smarty, $site, $langCode, $currentDomainSuffix);

    if ($requestPath == '/contactus.html') {
        return enterprise_action_sets_contactus_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix);
    } elseif ($requestPath == '/aboutus.html') {
        return enterprise_action_sets_aboutus_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(enterprise_match_url_product($requestPath, $productId, $pageNo, $langCode, $site)) {
        return enterprise_action_sets_product_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $productId, ENTERPRISE_PRODUCT_PAGE_TYPE_DEFAULT, $pageNo);
    } elseif(preg_match(PATTERN_PRODUCT_PIC, $requestPath, $matches)) {
        $productId = $matches[1];
        return enterprise_action_sets_product_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $productId, ENTERPRISE_PRODUCT_PAGE_TYPE_PIC);
    } elseif(preg_match(PATTERN_DETAILED_PRODUCT, $requestPath, $matches)) {
        $productId = $matches[1];
        return enterprise_action_sets_product_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $productId, ENTERPRISE_PRODUCT_PAGE_TYPE_DETAILED);
    } elseif(preg_match($GLOBALS['gaUrlPatterns']['group'], $requestPath, $matches)) {
        $groupId = $matches[1];
        if (isset($matches[3])
                && $matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        return enterprise_action_sets_product_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $groupId, $pageNo);
    } elseif(preg_match(PATTERN_PRODUCT_SEARCH, $requestPath, $matches)) {
        $urlKey = $matches[1];
        $pageNo = (int)enterprise_get_query_by_server_request('p');
        if ($pageNo <= 0)
            $pageNo = 1;
        return enterprise_action_sets_product_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, array('url_key' => $urlKey), $pageNo);
    } elseif(preg_match(PATTERN_PRODUCT_INDEX, $requestPath, $matches)) {
        if (isset($matches[2])
                && $matches[2])
            $pageNo = (int)$matches[2];
        else
            $pageNo = 1;
        return enterprise_action_sets_product_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, null, $pageNo);
    } elseif ($requestPath == '/quality.html') {
        return enterprise_action_sets_quality_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix);
    } elseif ($requestPath == '/contactnow.html') {
        return enterprise_action_sets_contactnow_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(preg_match(PATTERN_PRODUCT_DIRECTORY, $requestPath, $matches)) {
        if (isset($matches[2])
                && $matches[2])
            $pageNo = (int)$matches[2];
        else
            $pageNo = 1;
        return enterprise_action_sets_product_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, null, $pageNo, 'product_directory.tpl', 50);
    } elseif(preg_match(PATTERN_NEWS_LIST, $requestPath, $matches)) {
        if (isset($matches[2])
                && $matches[2])
            $pageNo = (int)$matches[2];
        else
            $pageNo = 1;
        return enterprise_action_sets_news_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $pageNo);
    } elseif(preg_match(PATTERN_NEWS_PAGE, $requestPath, $matches)) {
        $newsId = $matches[1];
        return enterprise_action_sets_news_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $newsId);
    } elseif(preg_match('/^\/attachments\/([0-9a-f]{32})$/', $requestPath, $matches)) {
        $guidHex = $matches[1];
        return enterprise_action_attachment_proc($guidHex);
    } elseif ($requestPath == '/sitemap/group.xml') {
        enterprise_action_sitemap_group_proc($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, 1);// Terminated
    } elseif ($requestPath == '/sitemap/index.xml') {
        enterprise_action_sitemap_index_proc($siteId, $omsSite, $platform, $langCode, $currentDomainSuffix);// Terminated
    } elseif (preg_match('/^\/sitemap\/product(-([0-9]+))?\.xml$/', $requestPath, $matches)) {
        if (isset($matches[2]))
            $no = (int)$matches[2];
        else
            $no = 1;
        enterprise_action_sitemap_proc_2($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $no);// Terminated
    } elseif (preg_match('/^\/sitemap\/keywords-([A-Z]|number)(-([0-9]+))?\.xml$/', $requestPath, $matches)) {
        $firstChar = $matches[1];
        if (isset($matches[3]))
            $no = (int)$matches[3];
        else
            $no = 1;
        enterprise_action_sitemap_keyword_proc($siteId, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $firstChar, $no);// Terminated
    } elseif ($requestPath == '/favicon.ico') {
        header('Content-Type: image/x-icon');
        if ($site['favicon'])
            return $site['favicon'];
        else
            return file_get_contents(__DIR__ . '/favicon.ico');
    } elseif(preg_match(PATTERN_KEYWORDS_LIST, $requestPath, $matches)) {
        if (isset($matches[3])
                && $matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        $firstChar = $matches[1];
        return enterprise_action_sets_keyword_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $firstChar, $pageNo);
    }

    $langProductDAO = (($langCode&&$langCode!='en')?new \enterprise\daos\LangProduct($langCode):null);

    // 用户自发布产品的自定义路径
    if ($langCode == 'en')
        $productDAO = new \enterprise\daos\Product();
    else
        $productDAO = $langProductDAO;
    $productId = $productDAO->getIdByIdxLookup($siteId, $requestPathSum);
    if ($productId) {
        return enterprise_action_sets_product_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $productId);
    }

    // 用户自建分组的自定义路径
    if ($langCode == 'en')
        $groupDAO = new \enterprise\daos\Group();
    else
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
    $group = $groupDAO->getByIdxLookup($siteId, $requestPathSum);
    if ($group) {
        $pageNo = 1;
        $queryString = parse_url($requestURL, PHP_URL_QUERY);
        if ($queryString) {
            $queries = array();
            parse_str($queryString, $queries);
            $pageNo = (int)($queries['p']??1);
            if ($pageNo <= 1)
                $pageNo = 1;
        }
        return enterprise_action_sets_product_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $group['id'], $pageNo);
    }

    // Custom Pages
    $customPageDAO = new \enterprise\daos\CustomPage();
    $condition = "`site_id`=" . (int)$siteId . " AND `deleted`=0 AND `path`='" . $customPageDAO->escape($requestPath) . "'";
    $customPage = $customPageDAO->getOneBy($condition);
    if ($customPage)
        return $customPage['body'];

    return null;
}

/* {{{ URLs */

function enterprise_url_prefix()
{
    //return $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'];
    return 'http://' . $_SERVER['HTTP_HOST'];
}

/**
 * URL - Image
 *
 * @return string
 */
function enterprise_url_image($imageId, $productCaption = '', $imageSizeType = '', $default = '', $pathOnly = false)
{
    if (is_array($imageId)) {
        $retval = array();
        foreach ($imageId as $id) {
            $retval[] = enterprise_url_image($id, $productCaption, $imageSizeType);
        }
        return $retval;
    }

    if (!$imageId) {
        if ($default)
            return $default;
        else
            return $GLOBALS['gsProductDefaultImageUrl'];
    }

    $suffix = '';
    $urlKey = enterprise_generate_url_key($productCaption);
    if ($urlKey)
        $suffix = '-' . $urlKey;

    $path = '/uploaded_images/' . $imageSizeType . $imageId . $suffix . '.jpg';
    return ($pathOnly?'':enterprise_url_prefix()) . $path;
}

/**
 * URL - Image
 *
 * @return string
 */
function enterprise_url_photo($uri, $desc = '', $imageSizeType = '', $default = '', $pathOnly = false)
{
    if (strpos($uri, $_SERVER['REQUEST_SCHEME'] . '://') === 0)
        return $uri;

    $imageId = (int)str_replace('image://', '', $uri);
    return enterprise_url_image($imageId, $desc, $imageSizeType, $default, $pathOnly);
}

/**
 * URL - Product
 *
 * @return string
 */
function enterprise_url_product($product, $pageNo = 1, $pathOnly = false)
{
    if (!$product)
        return null;

    $pageString = '';
    if ($pageNo > 1)
        $pageString = 'p' . $pageNo;

    if ($product['path'])
        $path = $product['path'];
    else {
        $urlKey = enterprise_generate_url_key($product['caption']);
        $urlKeyString = '';
        if ($urlKey)
            $urlKeyString = '-' . $urlKey;
        $pUrlPrefix = ((isset($product['group']['purl_prefix'])&&$product['group']['purl_prefix'])?$product['group']['purl_prefix']:$GLOBALS['gaUrlPrefixes']['product']);
        $path = '/' . $pUrlPrefix . '-' . $product['id'] . $pageString . $urlKeyString . '.html';
    }
    return ($pathOnly?'':enterprise_url_prefix()) . $path;
}

/**
 * URL - Detailed Product
 *
 * @return string
 */
function enterprise_url_detailed_product($product, $pathOnly = false)
{
    $urlKey = enterprise_generate_url_key($product['caption']);
    $urlKeyString = '';
    if ($urlKey)
        $urlKeyString = '-' . $urlKey;
    $path = '/sell-detail-' . $product['id'] . $urlKeyString . '.html';
    return ($pathOnly?'':enterprise_url_prefix()) . $path;
}

/**
 * URL - Product Pic
 *
 * @return string
 */
function enterprise_url_product_pic($product, $pathOnly = false)
{
    $path = '/pic-' . $product['id'] . '.html';
    return ($pathOnly?'':enterprise_url_prefix()) . $path;
}

/**
 * URL - Product List
 *
 * @return string
 */
function enterprise_url_product_list($group = null, $pageNo = 1, $pathOnly = false)
{
    if ($group) {
        if ($group['path'])
            $path = $group['path'] . ($pageNo > 1?'?p=' . $pageNo:'');
        else {
            $groupId = $group['id']??$group['group_id'];
            $pageString = '';
            if ($pageNo > 1)
                $pageString = 'p' . $pageNo;
            $urlKey = enterprise_generate_url_key($group['name']);
            $urlKeyString = '';
            if ($urlKey)
                $urlKeyString = '-' . $urlKey;
            $path = '/' . $GLOBALS['gaUrlPrefixes']['group'] . '-' . $groupId . $pageString . $urlKeyString;
        }
    } else {
        $pageString = '';
        if ($pageNo > 1)
            $pageString = '-' . $pageNo;
        $path = '/products' . $pageString . '.html';
    }
    return ($pathOnly?'':enterprise_url_prefix()) . $path;
}

/**
 * URL - Product Directory
 *
 * @return string
 */
function enterprise_url_product_directory($pageNo = 1)
{
    $pageString = '';
    if ($pageNo > 1)
        $pageString = '-' . $pageNo;
    return enterprise_url_prefix() . '/directory' . $pageString . '.html';
}

/**
 * URL - Product Search
 *
 * @return string
 */
function enterprise_url_product_search($phrase, $pageNo = 1)
{
    $pageString = '';
    if ($pageNo > 1)
        $pageString = '?p=' . $pageNo;
    return enterprise_url_prefix() . '/s-' . enterprise_generate_url_key($phrase) . '.html' . $pageString;
}

/**
 * URL - Sitemap
 */
function enterprise_url_sitemap($currentDomainSuffix, $page = 'product', $no = 1)
{
    $suffix = '';
    if ($no > 1)
        $suffix = '-' . $no;
    return enterprise_url_prefix() . '/sitemap/' . $page . $suffix . '.xml';
}

/**
 * URL - News
 *
 * @return string
 */
function enterprise_url_news($news, $pathOnly = false)
{
    if (!$news)
        return null;

    $urlKey = enterprise_generate_url_key($news['caption']);
    $urlKeyString = '';
    if ($urlKey)
        $urlKeyString = '-' . $urlKey;
    $path = '/news-' . $news['id'] . $urlKeyString . '.html';

    return ($pathOnly?'':enterprise_url_prefix()) . $path;
}

/**
 * URL - News List
 *
 * @return string
 */
function enterprise_url_news_list($pageNo = 1)
{
    $pageString = '';
    if ($pageNo > 1)
        $pageString = '-' . $pageNo;
    return enterprise_url_prefix() . '/news' . $pageString;
}
/* }}} */

/* {{{ Groups */

/**
 * Assign Group Info
 */
function enterprise_assign_group_info($smarty, $var, $groupId, $langCode = 'en')
{
    $group = enterprise_get_group_info($groupId, $langCode);
    $smarty->assign('group', $group);
}

/**
 * Assign Group List
 *
 * @return array Group Array
 */
function enterprise_assign_group_list($smarty, $var, $siteId, $max = null, $skipEmpty = true,
        $appendFirstProducts = false, $maxAppendedProducts = 1)
{
    return enterprise_assign_group_list_ex($smarty, $var, $siteId, 'en', $max, '', $skipEmpty, $appendFirstProducts, $maxAppendedProducts);
}

/**
 * Get Group List
 */
function enterprise_get_group_list($siteId, $langCode = 'en', $max = null, $additionalConditions = '', $orderBy = null, $additionalFields = '')
{
    if ($langCode == 'en') {
        $groupDAO = new \enterprise\daos\Group();
        $fields = '*';
        $condition = "`site_id`={$siteId} AND `deleted`=0";
        if (!isset($orderBy))
            $orderBy = '`created` ASC ';
    } else {
        $groupDAO = new \enterprise\daos\LangGroup($langCode);
        $fields = 'lg.*, g.`id`, g.`path`, g.`purl_prefix`, g.`product_give_h1_to`';
        $condition = "lg.`site_id`={$siteId} AND lg.`deleted`=0";
        if (!isset($orderBy))
            $orderBy = 'g.`created` ASC ';
    }
    if ($additionalFields)
        $fields .= ", {$additionalFields}";

    $condition .= ($additionalConditions?(' AND ' . $additionalConditions):'');
    return $groupDAO->getMultiInOrderBy($condition, $fields, $orderBy, $max);
}

/**
 * Assign Group List Ext
 *
 * @return array Group Array
 */
function enterprise_assign_group_list_ex($smarty, $var, $siteId, $langCode = 'en', $max = null, $additionalConditions = '', $skipEmpty = true,
        $appendFirstProducts = false, $maxAppendedProducts = 1)
{
    $groups = enterprise_get_group_list_ex($siteId, $langCode, $max, $additionalConditions, $skipEmpty, $appendFirstProducts, $maxAppendedProducts);
    $smarty->assign($var, $groups);
    return $groups;
}

/**
 * Get Group List Ext
 *
 * @return array Group Array
 */
function enterprise_get_group_list_ex($siteId, $langCode = 'en', $max = null, $additionalConditions = '', $skipEmpty = true,
        $appendFirstProducts = false, $maxAppendedProducts = 1)
{
    $maxGroupsFromDb = ($appendFirstProducts?null:$max);
    $cntString = ($skipEmpty?($langCode!='en'?'lg.':'') . '`cnt`>0':'');

    if ($additionalConditions)
        $additionalConditions .= $cntString;
    else
        $additionalConditions = $cntString;
    
    $groups = enterprise_get_group_list($siteId, $langCode, $maxGroupsFromDb, $additionalConditions);

    if ($appendFirstProducts) {
        $retval = array();
        $accItems = 0;
        foreach ($groups as $group) {
            $groupId = (int)($group['id']??$group['group_id']);

            $GLOBALS['gaGroupCache'][$langCode][$groupId] = $group;

            $condition = "`site_id`={$siteId} AND `group_id`={$groupId} AND `deleted`=0";
            $products = enterprise_get_product_list($siteId, $langCode, $groupId, true, 1, $maxAppendedProducts);
            $group['products'] = $products;
            $retval[] = $group;
            ++$accItems;

            if ($max
                    && $accItems >= $max)
                break;
        }
        $groups = $retval;
    }
    return $groups;
}

/**
 * Response - Replace group list
 */
function enterprise_response_replace_group_list($smarty, $siteId, $response)
{
    $characteristic = enterprise_site_info_get_group_list_characteristic($siteId);
    if (!$characteristic)
        return $response;

    $document = new \DOMDocument();
    @$document->loadHTML($response);
    $groupListElement = \analyzer\utils\DOMUtils::findFirstElementByTagNameNAttribute($document, $characteristic['tag_name'], $characteristic['attr_name'], $characteristic['attr_value']);
    if ($groupListElement) {
        $originalGroupListHtml = $document->saveHTML($groupListElement);

        enterprise_assign_group_list($smarty, 'groups', $siteId);
        $newGroupListHtmlFragment = $smarty->fetch('sites/' . $siteId . '/group_list_fragment.tpl');

        if ($newGroupListHtmlFragment) {
            $fragment = $document->createDocumentFragment();
            $fragment->appendXML($newGroupListHtmlFragment);
            $groupListElement->appendChild($fragment);
            $newGroupListHtml = $document->saveHTML($groupListElement);
            $response = str_replace($originalGroupListHtml, $newGroupListHtml, $response);
        }
    }

    return $response;
}
/* }}} */

/* {{{ Site Info */

/**
 * Extract hidden groups from site info
 *
 * @return array
 */
function enterprise_extract_hidden_groups($site)
{
    if (!array_key_exists('hidden_groups', $site))
        return [];
    $retval = json_decode($site['hidden_groups'], true);
    if (!$retval)
        return [];

    return $retval;
}

/**
 * Site Info - Get characteristic of group list
 */
function enterprise_site_info_get_group_list_characteristic($siteId)
{
    global $siteInfo;

    if (!isset($siteInfo[$siteId]['group_list_characteristic']))
        return null;

    return $siteInfo[$siteId]['group_list_characteristic'];
}
/**
 * Site Info - Get page size of product list
 */
function enterprise_site_info_get_product_list_page_size($siteId)
{
    global $siteInfo;

    if (!isset($siteInfo[$siteId]['product_list_page_size']))
        return null;

    return $siteInfo[$siteId]['product_list_page_size'];
}
/* }}} */

/**
 * Get corporation info
 */
function enterprise_get_corporation_info($siteId, $langCode = 'en')
{
    // Corporation
    $corporationDAO = new \enterprise\daos\Corporation();
    $condition = "`site_id`=" . (int)$siteId;
    $corporation = $corporationDAO->getOneBy($condition);

    if ($langCode != 'en') {
        $langCorporationDAO = new \enterprise\daos\LangCorporation($langCode);
        $condition = '`site_id`=' . (int)$siteId;
        $langCorporation = $langCorporationDAO->getOneBy($condition);
        if ($langCorporation)
            $corporation = array_merge($corporation, $langCorporation);
    }
    
    return $corporation;
}

/**
 * Assign corporation info
 */
function enterprise_assign_corporation_info($smarty, $var, $siteId, $langCode = 'en')
{
    $smarty->assign($var, enterprise_get_corporation_info($siteId, $langCode));
}

/**
 * Get site info
 */
function enterprise_get_site_info($siteId, $langCode = 'en')
{
    // Site
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);

    // Language Site
    if ($langCode != 'en') {
        $langSiteDAO = new \enterprise\daos\LangSite($langCode);
        $condition = '`site_id`=' . (int)$siteId;
        $langSite = $langSiteDAO->getOneBy($condition);
        if ($langSite)
            $site = array_merge($site, $langSite);
    }

    return $site;
}

/**
 * Assign site info
 */
function enterprise_assign_site_info($smarty, $var, $siteId, $langCode = 'en')
{
    $smarty->assign($var, enterprise_get_site_info($siteId, $langCode));
}

/* {{{ Contact */
/**
 * Assign Contact List
 */
function enterprise_assign_contact_list($smarty, $var, $siteId)
{
    $contactDAO = new \enterprise\daos\Contact();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $contacts = $contactDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $contacts);
}

/**
 * Assign contact info
 */
function enterprise_assign_contact_info($smarty, $var, $contactId)
{
    $contactDAO = new \enterprise\daos\Contact();
    $contact = $contactDAO->get($contactId);
    $smarty->assign($var, $contact);
}

/* }}} */

/* {{{ Route V2 Actions */

/**
 * Common procedure
 */
function enterprise_action_sets_common_proc($smarty, $site, $langCode, $currentDomainSuffix, $appendFirstProductsToGroups = false, $maxAppendedProductsToGroups = null)
{
    $siteId = $site['site_id'];

    // Corporation
    enterprise_assign_corporation_info($smarty, 'corporation', $siteId, $langCode);
    $corporation = $smarty->getTemplateVars('corporation');

    // + Slogan
    $corporationSlogan = ($corporation['slogan']?$corporation['slogan']:'This is a verified supplier can provide quality products and have passed the Business License Check.');
    $smarty->assign('corporation_slogan', $corporationSlogan);

    // Groups
    enterprise_assign_group_list_ex($smarty, 'groups', $siteId, $langCode, null, '', true, $appendFirstProductsToGroups, $maxAppendedProductsToGroups);

    // Domain suffix
    $smarty->assign('site_root_domain', $currentDomainSuffix);

    // Alternate Mobile Host
    $smarty->assign('alternate_mobile_host', enterprise_build_alternate_mobile_host($langCode, $currentDomainSuffix));
    // Canonical Host
    $smarty->assign('canonical_host', enterprise_build_canonical_host($langCode, $currentDomainSuffix));

    // Quick questions
    $smarty->assign('quick_questions', enterprise_get_quick_questions_for_inquiry($smarty));

    // Contacts
    enterprise_assign_contact_list($smarty, 'contacts', $siteId);

    // Main Products
    enterprise_assign_main_product_list($smarty, 'main_products', $siteId);

    // Default Language Code
    $smarty->assign('default_lang_code', $GLOBALS['gsDefaultLangCode']);

    // Supported lang codes
    $supportedLangCodes = \enterprise\LangCode::getSupportedLangCodes();
    $smarty->assign('supported_lang_codes', $supportedLangCodes);

    // Site lang codes
    $siteLangCodes = ($site['lang_codes']?json_decode($site['lang_codes'], true):array());
    $smarty->assign('site_lang_codes', $siteLangCodes);

    $hiddenGroupIdMapping = enterprise_extract_hidden_groups($site);
    $smarty->assign('hidden_groups', $hiddenGroupIdMapping);

    // Language Code
    $smarty->assign('lang_code', $langCode);

    // Latest Products
    enterprise_assign_product_list($smarty, 'latest_products', $siteId, $langCode, null, 1, 3);

    // Groups In Links-Bar
    enterprise_assign_group_list_ex($smarty, 'groups_in_links_bar', $siteId, $langCode, null, '', true, true, 3);
}

/**
 * @return string Path
 */
function enterprise_decide_template_path($smarty, $site, $platform, $relativePath)
{
    if ($site) {
        $templateName = $site['template'];

        if ($platform == ENTERPRISE_PLATFORM_PC)
            $tplPath = 'sets/' . $templateName . $relativePath;
        else
            $tplPath = 'sets/mobile' . $relativePath;
        if ($smarty->templateExists($tplPath))
            return $tplPath;
    }

    $siteId = $site['site_id'];
    $tplPath = 'sites/' . $siteId . $relativePath;
    if ($smarty->templateExists($tplPath))
        return $tplPath;

    return null;
}

/**
 * /contactus.html
 *
 * @return string
 */
function enterprise_action_sets_contactus_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    global $contactDescMapping;

    $siteId = $site['site_id'];

    enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $tplPath = enterprise_decide_template_path($smarty, $site, $platform, '/contactus.tpl');
    if (!$tplPath)
        return null;

    // Site
    $smarty->assign('site', $site);

    $smarty->assign('contact_desc', $contactDescMapping);

    $corporation = $smarty->getTemplateVars('corporation');

    // TDK
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $searches = ['{corporation}', '{tel_wt}'];
    $replacements = [$corporation['name'], $corporation['tel_wt']];
    $smarty->assign('title', str_replace($searches, $replacements, $presetTranslations['preset_contactus_html_title']));
    $smarty->assign('keywords', str_replace($searches, $replacements, $presetTranslations['preset_contactus_meta_keywords']));
    $smarty->assign('description', str_replace($searches, $replacements, $presetTranslations['preset_contactus_meta_description']));

    return $smarty->fetch($tplPath);
}

/**
 * /aboutus.html
 *
 * @return string
 */
function enterprise_action_sets_aboutus_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $siteId = $site['site_id'];

    $templateName = $site['template'];

    if ($platform == ENTERPRISE_PLATFORM_PC)
        $tplPath = 'sets/' . $templateName . '/aboutus.tpl';
    else
        $tplPath = 'sets/mobile/aboutus.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    // Photos - AboutUs
    enterprise_assign_photo_list($smarty, 'photos', $siteId, \enterprise\daos\Photo::TYPE_ABOUT_US);

    $corporation = $smarty->getTemplateVars('corporation');
    $groups = $smarty->getTemplateVars('groups');

    // TDK
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $group1Name = (isset($groups[0]['name'])?$groups[0]['name']:'');
    $group2Name = (isset($groups[1]['name'])?$groups[1]['name']:'');
    $searches = ['{group_1}', '{group_2}', '{corporation}'];
    $replacements = [$group1Name, $group2Name, $corporation['name']];
    $smarty->assign('title', str_replace($searches, $replacements, $presetTranslations['preset_aboutus_html_title']));
    $smarty->assign('keywords', str_replace($searches, $replacements, $presetTranslations['preset_aboutus_meta_keywords']));
    $smarty->assign('description', str_replace($searches, $replacements, $presetTranslations['preset_aboutus_meta_description']));

    return $smarty->fetch($tplPath);
}

/**
 * 替换TDK中的占位符
 *
 * @return string
 */
function enterprise_replace_placeholders_in_tdk($s, $corporation, $product, $productGroup)
{
    $productGroupName = (isset($productGroup['name'])?$productGroup['name']:'');
    $productTags = ($product['tags']?enterprise_extract_product_tags($product['tags']):array());
    $productTag1 = (isset($productTags[0])?$productTags[0]:'');
    $productTag2 = (isset($productTags[1])?$productTags[1]:'');
    $productTag3 = (isset($productTags[2])?$productTags[2]:'');

    $retval = $s;
    $retval = str_replace('[产品标题]', $product['caption'], $retval);
    $retval = str_replace('[产品分组]', $productGroupName, $retval);
    $retval = str_replace('[公司名称]', $corporation['name'], $retval);
    $retval = str_replace('[Tag1]', $productTag1, $retval);
    $retval = str_replace('[Tag2]', $productTag2, $retval);
    $retval = str_replace('[Tag3]', $productTag3, $retval);
    $retval = str_replace('[产品型号]', $product['model_number'], $retval);
    return $retval;
}

/**
 * 向模板追加产品详情页的TDK
 */
function enterprise_assign_tdk_of_product_detail($smarty, $pageType, $site, $corporation, $product, $productGroup, $langCode = 'en')
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);

    $productGroupId = (isset($productGroup['id'])?$productGroup['id']:0);
    $hitScope = ($site['product_tdk_scope'] == 0
            || $site['product_tdk_scope'] == $productGroupId);

    if ($pageType == ENTERPRISE_PRODUCT_PAGE_TYPE_PIC) {
        $titleTemplate = $presetTranslations['preset_pic_html_title'];
        $keywordsTemplate = $presetTranslations['preset_pic_meta_keywords'];
        $descriptionTemplate = $presetTranslations['preset_pic_meta_description'];
    } else {
        $titleTemplate = $presetTranslations['preset_product_html_title'];
        $keywordsTemplate = $presetTranslations['preset_product_meta_keywords'];
        $descriptionTemplate = $presetTranslations['preset_product_meta_description'];

        if ($hitScope) {
            if ($site['product_html_title'])
                $titleTemplate = $site['product_html_title'];
            if ($site['product_meta_keywords'])
                $keywordsTemplate = $site['product_meta_keywords'];
            if ($site['product_meta_description'])
                $descriptionTemplate = $site['product_meta_description'];
        }

        if ($productGroup['product_html_title'])
            $titleTemplate = $productGroup['product_html_title'];
        if ($productGroup['product_meta_keywords'])
            $keywordsTemplate = $productGroup['product_meta_keywords'];
        if ($productGroup['product_meta_description'])
            $descriptionTemplate = $productGroup['product_meta_description'];
    }

    $presetTitle = enterprise_replace_placeholders_in_tdk($titleTemplate, $corporation, $product, $productGroup);
    $presetKeywords = enterprise_replace_placeholders_in_tdk($keywordsTemplate, $corporation, $product, $productGroup);
    $presetDescription = enterprise_replace_placeholders_in_tdk($descriptionTemplate, $corporation, $product, $productGroup);

    $smarty->assign('title', ($product['html_title']?$product['html_title']:$presetTitle));
    $smarty->assign('keywords', ($product['meta_keywords']?$product['meta_keywords']:$presetKeywords));
    $smarty->assign('description', ($product['meta_description']?$product['meta_description']:$presetDescription));
}

/**
 * /sell-*.html
 *
 * @return string
 */
function enterprise_action_sets_product_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $productId, $pageType = ENTERPRISE_PRODUCT_PAGE_TYPE_DEFAULT, $pageNo = 1)
{
    global $productDescMapping;

    $siteId = $site['site_id'];

    if ($pageType != ENTERPRISE_PRODUCT_PAGE_TYPE_PIC)// No mobile page for /pic-*
        enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $templateName = $site['template'];

    if ($platform == ENTERPRISE_PLATFORM_PC) {
        if ($pageType == ENTERPRISE_PRODUCT_PAGE_TYPE_PIC)
            $tplPath = 'sets/' . $templateName . '/product_pic.tpl';
        else
            $tplPath = 'sets/' . $templateName . '/product_detail.tpl';
    } else {
        if ($pageType == ENTERPRISE_PRODUCT_PAGE_TYPE_DETAILED)
            $tplPath = 'sets/mobile/detailed_product.tpl';
        else
            $tplPath = 'sets/mobile/product_detail.tpl';
    }
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    enterprise_assign_action_product_detail($smarty, $siteId, $langCode, $productId);

    // Comments
    $pageSize = 10;
    $condition = enterprise_assign_comment_list($smarty, 'comments', $siteId, $productId, $pageNo, $pageSize);
    // Total comments
    $commentDAO = new \enterprise\daos\Comment();
    $totalComments = $commentDAO->countBy($condition);
    $totalPages = (int)($totalComments / $pageSize) + (($totalComments % $pageSize)?1:0);
    $smarty->assign('total_comments', $totalComments);
    $smarty->assign('page_size', $pageSize);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    $smarty->assign('product_desc', $productDescMapping);

    $corporation = $smarty->getTemplateVars('corporation');
    $product = $smarty->getTemplateVars('product');
    $productGroup = $smarty->getTemplateVars('product_group');

    if (DBG_MODE)
        var_dump($product);

    // TDK
    enterprise_assign_tdk_of_product_detail($smarty, $pageType, $site, $corporation, $product, $productGroup, $langCode);

    $productImages = $smarty->getTemplateVars('product_images');

    // Google Structured Data
    $structuredData = [];
    // + Product
    $productData = array(
            "@context" => "http://schema.org",
            "@type" => "Product",
            "name" => $product['caption'],
            "image" => enterprise_url_image($productImages[0]??0, $product['caption'], 'c'),
            "brand" => array(
                    "@type" => "Brand",
                    "name" => $product['brand_name'],
                    "logo" => enterprise_url_image($corporation['logo']),
                ),
        );
    $structuredData[] = $productData;
    // + Video Object
    if ($currentDomainSuffix == 'hrcusa.org') {
        $structuredData[] = array(
                "@context" => "http://schema.org",
                "@type" => "VideoObject",
                "name" => $product['caption'],
                "description" => $product['description'],
                "thumbnailUrl" => enterprise_url_prefix() . "/uploaded_images/c1947410-professional-drying-equipment-vegetable-dehydration-for-vegetables-dehydrator-with-competitive-price-digital-printer.jpg",
                "uploadDate" => "3/8/2018",
                "duration" => "21",
                "contentUrl" => enterprise_url_prefix() . "/tea_leaf_dryer.mp4"
            );
    } elseif ($productGroup['product_video_uri']
            && $productGroup['product_video_duration']
            && $productGroup['product_video_cover_uri']) {
        $structuredData[] = array(
                "@context" => "http://schema.org",
                "@type" => "VideoObject",
                "name" => $product['caption'],
                "description" => $product['description'],
                "thumbnailUrl" => enterprise_url_photo($productGroup['product_video_cover_uri']),
                "uploadDate" => date('n/j/Y', strtotime($productGroup['updated'])),
                "duration" => $productGroup['product_video_duration'],
                "contentUrl" => $productGroup['product_video_uri']
            );
    }
    $smarty->assign('google_structured_data', $structuredData);

    return $smarty->fetch($tplPath);
}


/**
 * 设置新闻页TDK
 */
function enterprise_assign_tdk_of_news_detail($smarty, $news, $groups, $corporation, $site, $langCode = 'en')
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);

    $group1Name = (isset($groups[0]['name'])?$groups[0]['name']:'');
    $group2Name = (isset($groups[1]['name'])?$groups[1]['name']:'');

    $searches = ['{group_1}', '{group_2}', '{corporation}', '{news}'];
    $replacements = [$group1Name, $group2Name, $corporation['name'], $news['caption']];

    $presetTitle = str_replace($searches, $replacements, $presetTranslations['preset_news_html_title']);
    $smarty->assign('title', ($presetTitle));

    $presetKeywords = str_replace($searches, $replacements, $presetTranslations['preset_news_meta_keywords']);
    $smarty->assign('keywords', ($presetKeywords));

    $presetDescription = str_replace($searches, $replacements, $presetTranslations['preset_news_meta_description']);
    $smarty->assign('description', ($presetDescription));
}

/**
 * /news-*.html
 *
 * @return string
 */
function enterprise_action_sets_news_detail_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $newsId)
{
    global $newsDescMapping;

    $siteId = $site['site_id'];

    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/news_detail.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    enterprise_assign_news_info($smarty, 'news', $newsId, $langCode);
    enterprise_assign_next_news_info($smarty, 'next_news', $siteId, $newsId, $langCode);
    enterprise_assign_prev_news_info($smarty, 'prev_news', $siteId, $newsId, $langCode);

    // New Products
    enterprise_assign_product_list($smarty, 'new_products', $siteId, $langCode);

    // TDK
    $corporation = $smarty->getTemplateVars('corporation');
    $groups = $smarty->getTemplateVars('groups');
    $news = $smarty->getTemplateVars('news');
    enterprise_assign_tdk_of_news_detail($smarty, $news, $groups, $corporation, $site, $langCode);

    return $smarty->fetch($tplPath);
}

function enterprise_assign_tdk_of_product_list_of_group($smarty, $group, $presetTranslations, $searches, $replacements)
{
    $titleTemplate = $presetTranslations['preset_group_html_title'];
    $keywordsTemplate = $presetTranslations['preset_group_meta_keywords'];
    $descriptionTemplate = $presetTranslations['preset_group_meta_description'];

    $searches[] = '{group}';
    $searches[] = '[分组名称]';
    $replacements[] = $group['name'];
    $replacements[] = $group['name'];

    if ($group['html_title'])
        $titleTemplate = $group['html_title'];
    if ($group['meta_keywords'])
        $keywordsTemplate = $group['meta_keywords'];
    if ($group['meta_description'])
        $descriptionTemplate = $group['meta_description'];

    $smarty->assign('title', str_replace($searches, $replacements, $titleTemplate));
    $smarty->assign('keywords', str_replace($searches, $replacements, $keywordsTemplate));
    $smarty->assign('description', str_replace($searches, $replacements, $descriptionTemplate));
}

function enterprise_assign_tdk_of_product_list($smarty, $corporation, $pageNo = 1, $langCode = 'en', $groupId = null, $group = null, $phrase = '', $tplFile = null)
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $pageInfo = (($pageNo > 1)?" of page {$pageNo}":'');
    $searches = ['{corporation}', '[公司名称]', '{page_info}', '[分页信息]'];
    $replacements = [$corporation['name'], $corporation['name'], $pageInfo, $pageInfo];
    if ($tplFile == 'product_directory.tpl') {// PATTERN_PRODUCT_DIRECTORY
        $smarty->assign('title', str_replace($searches, $replacements, $presetTranslations['preset_directory_html_title']));
        $smarty->assign('keywords', str_replace($searches, $replacements, $presetTranslations['preset_directory_meta_keywords']));
        $smarty->assign('description', str_replace($searches, $replacements, $presetTranslations['preset_directory_meta_description']));
    } elseif (null === $groupId) {// /products.html
        $smarty->assign('title', str_replace($searches, $replacements, $presetTranslations['preset_product_index_html_title']));
        $smarty->assign('keywords', str_replace($searches, $replacements, $presetTranslations['preset_product_index_meta_keywords']));
        $smarty->assign('description', str_replace($searches, $replacements, $presetTranslations['preset_product_index_meta_description']));
    } elseif (is_array($groupId)) {// PATTERN_PRODUCT_SEARCH
        $searches[] = '{phrase}';
        $replacements[] = $phrase;

        $smarty->assign('title', str_replace($searches, $replacements, $presetTranslations['preset_search_html_title']));
        $smarty->assign('keywords', str_replace($searches, $replacements, $presetTranslations['preset_search_meta_keywords']));
        $smarty->assign('description', str_replace($searches, $replacements, $presetTranslations['preset_search_meta_description']));
    } else {// $GLOBALS['gaUrlPatterns']['group']
        enterprise_assign_tdk_of_product_list_of_group($smarty, $group, $presetTranslations, $searches, $replacements);
    }
}

/**
 * /supplier-*.html
 *
 * @return string
 */
function enterprise_action_sets_product_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $groupId = null, $pageNo = 1, $tplFile = 'product_list.tpl', $pageSize = 10)
{
    global $productDescMapping;

    $siteId = $site['site_id'];

    enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $templateName = $site['template'];

    if ($platform == ENTERPRISE_PLATFORM_PC)
        $tplPath = 'sets/' . $templateName . '/' . $tplFile;
    else
        $tplPath = 'sets/mobile/' . $tplFile;
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    enterprise_assign_action_product_list($smarty, $siteId, $langCode, $groupId, $pageNo, $pageSize);

    $smarty->assign('product_desc', $productDescMapping);

    $corporation = $smarty->getTemplateVars('corporation');
    $phrase = $smarty->getTemplateVars('phrase');
    $group = (($groupId && !is_array($groupId))?$smarty->getTemplateVars('group'):null);

    // TDK
    enterprise_assign_tdk_of_product_list($smarty, $corporation, $pageNo, $langCode, $groupId, $group, $phrase, $tplFile);

    return $smarty->fetch($tplPath);
}

/**
 * 设置新闻列表页TDK
 */
function enterprise_assign_tdk_of_news_list($smarty, $pageNo, $corporation, $site, $langCode = 'en')
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $pageInfo = (($pageNo > 1)?" of page {$pageNo}":'');

    $searches = ['{corporation}', '{page_info}'];
    $replacements = [$corporation['name'], $pageInfo];

    $presetTitle = str_replace($searches, $replacements, $presetTranslations['preset_news_list_html_title']);
    $smarty->assign('title', ($presetTitle));

    $presetKeywords = str_replace($searches, $replacements, $presetTranslations['preset_news_list_meta_keywords']);
    $smarty->assign('keywords', ($presetKeywords));

    $presetDescription = str_replace($searches, $replacements, $presetTranslations['preset_news_list_meta_description']);
    $smarty->assign('description', ($presetDescription));
}

/**
 * /news-*.html
 *
 * @return string
 */
function enterprise_action_sets_news_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $pageNo = 1)
{
    $pageSize = 10;
    $siteId = $site['site_id'];

    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/news_list.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    $totalNews = enterprise_assign_news_list($smarty, 'news', $siteId, $langCode, $pageNo, $pageSize, true);

    $smarty->assign('total_news', $totalNews);
    $smarty->assign('page_size', $pageSize);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalNews, $pageSize, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    // TDK
    $corporation = $smarty->getTemplateVars('corporation');
    enterprise_assign_tdk_of_news_list($smarty, $pageNo, $corporation, $site, $langCode);

    return $smarty->fetch($tplPath);
}

/**
 * 设置关键词列表页TDK
 */
function enterprise_assign_tdk_of_keyword_list($smarty, $firstChar, $pageNo, $corporation, $site, $langCode = 'en')
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $pageInfo = (($pageNo > 1)?" of page {$pageNo}":'');

    $searches = ['{corporation}', '{first_char}', '{page_info}'];
    $replacements = [$corporation['name'], $firstChar, $pageInfo];

    $presetTitle = str_replace($searches, $replacements, $presetTranslations['preset_keyword_list_html_title']);
    $smarty->assign('title', ($presetTitle));

    $presetKeywords = str_replace($searches, $replacements, $presetTranslations['preset_keyword_list_meta_keywords']);
    $smarty->assign('keywords', ($presetKeywords));

    $presetDescription = str_replace($searches, $replacements, $presetTranslations['preset_keyword_list_meta_description']);
    $smarty->assign('description', ($presetDescription));
}

/**
 * /words-*.html
 *
 * @return string
 */
function enterprise_action_sets_keyword_list_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix, $firstChar, $pageNo = 1)
{
    $pageSize = 120;
    $siteId = $site['site_id'];

    $templateName = $site['template'];
    $tplFile = 'keyword_list.tpl';

    if ($platform == ENTERPRISE_PLATFORM_PC)
        $tplPath = 'sets/' . $templateName . '/' . $tplFile;
    else
        $tplPath = 'sets/mobile/' . $tplFile;
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    $alphabet = (array_key_exists($firstChar, KEYWORD_ALPHABET)?KEYWORD_ALPHABET[$firstChar]:0);

    $condition = enterprise_assign_keyword_list($smarty, 'site_keywords', $siteId, $langCode, $pageNo, $pageSize, $alphabet);

    if ($langCode == 'en')
        $keywordDAO = new \enterprise\daos\Keyword();
    else
        $keywordDAO = new \enterprise\daos\LangKeyword($langCode);
    $totalKeywords = $keywordDAO->countBy($condition);
    $smarty->assign('total_keywords', $totalKeywords);
    $smarty->assign('page_size', $pageSize);
    $smarty->assign('page_no', $pageNo);
    $pagerInfo = enterprise_pager_calculate_key_infos($totalKeywords, $pageSize, $pageNo);
    $smarty->assign('pager_info', $pagerInfo);

    $smarty->assign('first_char', $firstChar);

    // TDK
    $corporation = $smarty->getTemplateVars('corporation');
    enterprise_assign_tdk_of_keyword_list($smarty, $firstChar, $pageNo, $corporation, $site, $langCode);

    return $smarty->fetch($tplPath);
}

/**
 * /quality.html
 *
 * @return string
 */
function enterprise_action_sets_quality_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    $siteId = $site['site_id'];

    enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/quality.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    // Certifications
    enterprise_assign_certification_list($smarty, 'certifications', $siteId);

    $corporation = $smarty->getTemplateVars('corporation');
    $groups = $smarty->getTemplateVars('groups');

    // TDK
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);
    $group1Name = (isset($groups[0]['name'])?$groups[0]['name']:'');
    $searches = ['{corporation}', '{group_1}'];
    $replacements = [$corporation['name'], $group1Name];
    $smarty->assign('title', str_replace($searches, $replacements, $presetTranslations['preset_quality_html_title']));
    $smarty->assign('keywords', str_replace($searches, $replacements, $presetTranslations['preset_quality_meta_keywords']));
    $smarty->assign('description', str_replace($searches, $replacements, $presetTranslations['preset_quality_meta_description']));

    return $smarty->fetch($tplPath);
}

/** 
 * 获取“首页推荐产品”
 */
function enterprise_get_index_products_from_site($site, $indexProductIdArray = null, $langCode = 'en')
{
    if ($indexProductIdArray)
        $pidArray = $indexProductIdArray;
    else {
        if (!$site['index_products'])
            return null;

        $indexProducts = json_decode($site['index_products'], true);
        if (!is_array($indexProducts))
            return null;

        $pidArray = array();
        foreach ($indexProducts as $pid) {
            if ($pid)
                $pidArray[] = $pid;
        }
    }

    if (!$pidArray)
        return null;

    if ($langCode == 'en') {
        $pidFieldName = '`id`';
        $productDAO = new \enterprise\daos\Product();
        $fields = ENTERPRISE_PRODUCT_FIELDS_FOR_LIST;
    } else {
        $pidFieldName = 'elp.`product_id`';
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        $fields = ENTERPRISE_LANG_PRODUCT_FIELDS_FOR_LIST;
    }
    $pidCondition = ' ' . $pidFieldName . ' IN (' . implode(',', $pidArray) . ')';
    $products = $productDAO->getMultiInOrderBy($pidCondition, $fields);

    // Sort products by $indexProductIdArray
    if (is_array($products)) {
        $prodMapping = array();
        foreach ($products as $prod) {
            $pid = ($prod['id']??($prod['product_id']??null));
            if (!$pid)
                continue;
            $prodMapping[$pid] = $prod;
        }
        $products = array();
        foreach ($pidArray as $pid) {
            if (!$pid)
                continue;
            if (!isset($prodMapping[$pid]))
                continue;
            $products[] = $prodMapping[$pid];
        }
    }

    return enterprise_product_append_group_info($langCode, $products);
}

function enterprise_assign_index_products($smarty, $site, $langCode = 'en', $indexProductIdArray = null)
{
    $indexProducts = enterprise_get_index_products_from_site($site, $indexProductIdArray, $langCode);
    if ($indexProducts)
        $smarty->assign('products', $indexProducts);
    else
        enterprise_assign_product_list($smarty, 'products', $site['site_id'], $langCode, null, 1, ENTERPRISE_MAX_INDEX_PRODUCTS);
}

function enterprise_get_user_voices($smarty, $site)
{
    if (!$site['user_voices'])
        return null;

    return json_decode($site['user_voices'], true);
}

function enterprise_assign_user_voices($smarty, $var, $site, $userVoices = null)
{
    if (!$userVoices)
        $userVoices = enterprise_get_user_voices($smarty, $site);
    if (!$userVoices)
        $userVoices = enterprise_get_default_user_voice_list();

    $smarty->assign($var, $userVoices);
}

/**
 * 设置首页TDK
 */
function enterprise_assign_tdk_of_home($smarty, $groups, $corporation, $site, $langCode = 'en')
{
    $presetTranslations = enterprise_get_preset_translations($smarty, $langCode);

    $group1Name = (isset($groups[0]['name'])?$groups[0]['name']:'');
    $group2Name = (isset($groups[1]['name'])?$groups[1]['name']:'');

    $searches = ['{group_1}', '{group_2}', '{corporation}'];
    $replacements = [$group1Name, $group2Name, $corporation['name']];

    $presetTitle = str_replace($searches, $replacements, $presetTranslations['preset_index_html_title']);
    $smarty->assign('title', ($site['index_html_title']?$site['index_html_title']:$presetTitle));

    $presetKeywords = str_replace($searches, $replacements, $presetTranslations['preset_index_meta_keywords']);
    $smarty->assign('keywords', ($site['index_meta_keywords']?$site['index_meta_keywords']:$presetKeywords));

    $presetDescription = str_replace($searches, $replacements, $presetTranslations['preset_index_meta_description']);
    $smarty->assign('description', ($site['index_meta_description']?$site['index_meta_description']:$presetDescription));
}

/**
 * /
 *
 * @return string
 */
function enterprise_action_sets_home_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    $siteId = $site['site_id'];

    enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $templateName = $site['template'];

    if ($platform == ENTERPRISE_PLATFORM_PC)
        $tplPath = 'sets/' . $templateName . '/home.tpl';
    else
        $tplPath = 'sets/mobile/home.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Template Meta
    $templateMeta = $GLOBALS['gaTemplates'][$templateName];

    // Site
    $smarty->assign('site', $site);

    // Banners
    enterprise_assign_banner_list($smarty, 'banners', $siteId);

    // Users' voices
    $userVoices = enterprise_get_user_voice_list($siteId, $langCode, 3, 1);
    if (!$userVoices)
        $userVoices = enterprise_get_default_user_voice_list();
    $smarty->assign('user_voices', $userVoices);

    // Products
    enterprise_assign_index_products($smarty, $site, $langCode);

    enterprise_action_sets_common_proc($smarty, $site, $langCode, $currentDomainSuffix, true, $templateMeta['home_max_appended_products_to_group']??3);
    $corporation = $smarty->getTemplateVars('corporation');
    $groups = $smarty->getTemplateVars('groups');

    // TDK
    enterprise_assign_tdk_of_home($smarty, $groups, $corporation, $site, $langCode);

    // News
    enterprise_assign_news_list($smarty, 'news', $siteId, $langCode, 1, 5);

    // Index Keyword
    enterprise_assign_index_keyword_list($smarty, 'index_keywords', $siteId, $langCode, 1, 24);

    return $smarty->fetch($tplPath);
}

function enterprise_generate_inquiry_subject_by_product_id($productId, $langCode)
{
    if (!$productId)
        return null;

    $product = enterprise_get_product_info($productId, $langCode);
    if (!$product)
        return null;

    return 'Inquiry About ' . $product['caption'];
}

function enterprise_get_query_by_server_request($key, $filters = 'trim, strip_tags')
{
    $serverRequest = GuzzleHttp\Psr7\ServerRequest::fromGlobals();
    $uri = $serverRequest->getUri();
    $query = $uri->getQuery();
    parse_str($query, $params);
    $v = (isset($params[$key])?$params[$key]:'');
    return timandes_filter($v, $filters);
}

function enterprise_get_quick_questions_for_inquiry($smarty)
{
    $presetTranslations = $smarty->getTemplateVars('preset_translations');
    return array(
            $presetTranslations['quick_question_1'],
            $presetTranslations['quick_question_2'],
            $presetTranslations['quick_question_3'],
            $presetTranslations['quick_question_4'],
        );
}

function enterprise_parse_id_from_product_page($requestPath)
{
    if ($requestPath
            && enterprise_match_url_product($requestPath, $productId, $pageNo))
        return $productId;
    else
        return null;
}

/**
 * /contactnow.html
 *
 * @return string
 */
function enterprise_action_sets_contactnow_proc($smarty, $site, $userAgent, $platform, $langCode, $originalDomainSuffix, $currentDomainSuffix)
{
    global $contactDescMapping;

    $siteId = $site['site_id'];

    enterprise_adapt_platform($userAgent, $platform, $currentDomainSuffix, $langCode);

    $tplPath = enterprise_decide_template_path($smarty, $site, $platform, '/contactnow.tpl');
    if (!$tplPath)
        return null;

    // Site
    $smarty->assign('site', $site);

    $smarty->assign('contact_desc', $contactDescMapping);

    $corporation = $smarty->getTemplateVars('corporation');

    // Inquiry subject
    $aboutProductId = (int)enterprise_get_query_by_server_request('about_product');
    $subject = enterprise_generate_inquiry_subject_by_product_id($aboutProductId, $langCode);
    if (!$subject) {
        $referer = timandes_get_server_data('HTTP_REFERER');
        $refererPath = parse_url($referer, PHP_URL_PATH);
        $productId = enterprise_parse_id_from_product_page($refererPath);
        if ($productId) {
            $smarty->assign('target_product_id', $productId);
            enterprise_assign_product_info($smarty, 'target_product', $productId, $langCode);
            $subject = enterprise_generate_inquiry_subject_by_product_id($productId, $langCode);
        }

        if (!$subject)
            $subject= 'Inquiry About ' . $corporation['name'];
    } else {
        $smarty->assign('target_product_id', $aboutProductId);
        enterprise_assign_product_info($smarty, 'target_product', $aboutProductId, $langCode);
    }
    $smarty->assign('subject', $subject);

    return $smarty->fetch($tplPath);
}


/**
 * /404.html
 *
 * @return string
 */
function enterprise_action_404_proc($smarty, $siteId, $platform, $currentDomainSuffix)
{
    $site = enterprise_get_site_info($siteId);
    $tplPath = enterprise_decide_template_path($smarty, $site, $platform, '/404.tpl');
    if (!$tplPath)
        $tplPath = '404.tpl';

    // Site
    $smarty->assign('site', $site);

    enterprise_define_url_pattern_constants($site);

    // Corporation
    enterprise_assign_corporation_info($smarty, 'corporation', $siteId);

    enterprise_assign_preset_translations($smarty, 'en');

    // Groups
    $groups = enterprise_assign_group_list($smarty, 'groups', $siteId, 2, true, true, 5);

    $smarty->assign('site_portal', $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . '/');
    return $smarty->fetch($tplPath);
}


/* }}} */

/* {{{ Photo */
/**
 * Assign Photo List
 *
 * @return string Condition
 */
function enterprise_assign_photo_list($smarty, $var, $siteId, $type = null)
{
    $siteId = (int)$siteId;

    $typeCondition = '';
    if (null !== $type) {
        $type = (int)$type;
        $typeCondition = " AND `type`={$type}";
    }

    $photoDAO = new \enterprise\daos\Photo();
    $condition = "`site_id`={$siteId}{$typeCondition} AND `deleted`=0";
    $photos = $photoDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $photos);

    return $condition;
}

/**
 * Assign photo info
 */
function enterprise_assign_photo_info($smarty, $var, $photoId)
{
    $photoDAO = new \enterprise\daos\Photo();
    $photo = $photoDAO->get($photoId);
    $smarty->assign($var, $photo);
}

/* }}} */

/* {{{ Product */
/**
 * Filter Array => SQL Condition
 *
 * @return string
 */
function enterprise_filter_2_sql_condition($tablePrefix = '', $filter = null, &$extraValues = null)
{
    if (!$filter)
        return '';

    if (is_numeric($filter)) {
        $groupId = (int)$filter;
        return " AND {$tablePrefix}`group_id`={$groupId}";
    }

    if (!is_array($filter))
        throw new \InvalidArgumentException("Parameter 'filter' must be null, integer or array");

    if (isset($filter['url_key'])) {
        $phrase = enterprise_extract_url_key($filter['url_key']);
        $extraValues['phrase'] = $phrase;
        return " AND {$tablePrefix}`caption` LIKE '%" . str_replace(' ', '%', $phrase) . "%'";
    }

    throw new \InvalidArgumentException("Unsupported 'filter'");
}

/**
 * Get Product List
 *
 * @return string Condition
 */
function enterprise_get_product_list($siteId, $langCode = 'en', $groupId = null, $withGroupInfo = false, $pageNo = 1, $pageSize = 10, $additionalConditions = '', $orderBy = null, $additionalFields = '', &$extraValues = array(), &$condition = '')
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    if ($langCode == 'en')
        $tablePrefix = '';
    else
        $tablePrefix = 'elp.';

    $groupIdCondition = '';
    if (null !== $groupId) {
        $groupIdCondition = enterprise_filter_2_sql_condition($tablePrefix, $groupId, $extraValues);
    }

    if ($additionalConditions)
        $additionalConditions = ' AND ' . $additionalConditions;

    $forceIndex = null;
    if ($langCode == 'en') {
        $productDAO = new \enterprise\daos\Product();
        $condition = "`site_id`={$siteId}{$groupIdCondition} AND `deleted`=0{$additionalConditions}";
        if (!$orderBy) {
            $orderBy = '`updated` DESC';
            $forceIndex = '`idx_list`';
        }
        $fields = ENTERPRISE_PRODUCT_FIELDS_FOR_LIST;
    } else {
        $productDAO = new \enterprise\daos\LangProduct($langCode);
        $condition = "elp.`site_id`={$siteId}{$groupIdCondition} AND elp.`deleted`=0{$additionalConditions}";
        if (!$orderBy) {
            $orderBy = 'elp.`updated` DESC';
            $forceIndex = '`idx_list`';
        }
        $fields = ENTERPRISE_LANG_PRODUCT_FIELDS_FOR_LIST;
    }
    if ($additionalFields)
        $fields .= ", {$additionalFields}";

    $products = $productDAO->getMultiInOrderBy($condition, $fields, $orderBy, $pageSize, $start, $forceIndex);
    if (!$withGroupInfo
            || !is_array($products))
        return $products;

    // DEPRECATED: enterprise_product_append_group_info($langCode, $products);
    $retval = array();
    foreach ($products as $p) {
        $p['group'] = enterprise_get_group_info($p['group_id'], $langCode, true);
        $retval[] = $p;
    }
    return $retval;
}

/**
 * Assign Product List
 *
 * @return string Condition
 */
function enterprise_assign_product_list($smarty, $var, $siteId, $langCode = 'en', $groupId = null, $pageNo = 1, $pageSize = 10)
{
    $condition = '';
    $extraValues = array();
    $products = enterprise_get_product_list($siteId, $langCode, $groupId, true, $pageNo, $pageSize, '', null, '', $extraValues, $condition);
    $smarty->assign($var, $products);
    foreach ($extraValues as $k => $v)
        $smarty->assign($k, $v);
    return $condition;
}

/**
 * Assign product info
 */
function enterprise_assign_product_info($smarty, $var, $productId, $langCode = 'en')
{
    $smarty->assign($var, enterprise_get_product_info($productId, $langCode));
}

/**
 * Get product info
 */
function enterprise_get_product_info($productId, $langCode = 'en')
{
    // Product
    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);

    // Language Product
    if ($langCode != 'en') {
        $langProductDAO = new \enterprise\daos\LangProduct($langCode);
        $condition = '`product_id`=' . (int)$productId;
        $langProduct = $langProductDAO->getOneBy($condition);
        if ($langProduct)
            $product = array_merge($product, $langProduct);
    }

    $product['group'] = enterprise_get_group_info($product['group_id'], $langCode);

    return $product;
}
/* }}} */

/* {{{ Certification */
/**
 * Assign Certification List
 *
 * @return string Condition
 */
function enterprise_assign_certification_list($smarty, $var, $siteId)
{
    $siteId = (int)$siteId;

    $certificationDAO = new \enterprise\daos\Certification();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $certifications = $certificationDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $certifications);

    return $condition;
}

/**
 * Assign certification info
 */
function enterprise_assign_certification_info($smarty, $var, $certificationId)
{
    $certificationDAO = new \enterprise\daos\Certification();
    $certification = $certificationDAO->get($certificationId);
    $smarty->assign($var, $certification);
}

/* }}} */


/* {{{ Banner */
/**
 * Assign Banner List
 *
 * @return string Condition
 */
function enterprise_assign_banner_list($smarty, $var, $siteId)
{
    $siteId = (int)$siteId;

    $bannerDAO = new \enterprise\daos\Banner();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $banners = $bannerDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $banners);

    return $condition;
}

/**
 * Assign banner info
 */
function enterprise_assign_banner_info($smarty, $var, $bannerId)
{
    $bannerDAO = new \enterprise\daos\Banner();
    $banner = $bannerDAO->get($bannerId);
    $smarty->assign($var, $banner);
}

/* }}} */

/* {{{ CustomPage */
/**
 * Assign CustomPage List
 */
function enterprise_assign_custom_page_list($smarty, $var, $siteId)
{
    $customPageDAO = new \enterprise\daos\CustomPage();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $customPages = $customPageDAO->getMultiInOrderBy($condition, ENTERPRISE_CUSTOM_PAGE_FIELDS_FOR_LIST, '`id` DESC');
    $smarty->assign($var, $customPages);
}

/**
 * Assign custom_page info
 */
function enterprise_assign_custom_page_info($smarty, $var, $customPageId)
{
    $customPageDAO = new \enterprise\daos\CustomPage();
    $customPage = $customPageDAO->get($customPageId);
    $smarty->assign($var, $customPage);
}

/* }}} */

/* {{{ Comment */
/**
 * Assign Comment List
 */
function enterprise_assign_comment_list($smarty, $var, $siteId, $productId, $pageNo = 1, $pageSize = 10)
{
    $siteId = (int)$siteId;
    $productId = (int)$productId;
    $start = ($pageNo - 1) * $pageSize;

    $commentDAO = new \enterprise\daos\Comment();
    $condition = "`site_id`={$siteId} AND `product_id`={$productId} AND `deleted`=0";
    $comments = $commentDAO->getMultiInOrderBy($condition, '`id`, `subject`, `message`, `issued_on`, `avatar`, `contact`', '`id` DESC', $pageSize, $start);
    $smarty->assign($var, $comments);

    return $condition;
}

/**
 * Assign comment info
 */
function enterprise_assign_comment_info($smarty, $var, $commentId)
{
    $commentDAO = new \enterprise\daos\Comment();
    $comment = $commentDAO->get($commentId);
    $smarty->assign($var, $comment);
}

/* }}} */


/* {{{ News */

/**
 * Assign News List
 *
 * @return int Total
 */
function enterprise_assign_news_list($smarty, $var, $siteId, $langCode = 'en', $pageNo = 1, $pageSize = 10, $returnTotal = false)
{
    if ($returnTotal)
        $retval = 0;
    else
        $retval = null;
    $news = enterprise_get_news_list($siteId, $langCode, $pageSize, '', null, '', $pageNo, $retval);

    $smarty->assign($var, $news);

    return $retval;
}

/**
 * Get News List
 *
 * @return array
 */
function enterprise_get_news_list($siteId, $langCode = 'en', $pageSize = 10, $additionalConditions = '', $orderBy = null, $additionalFields = '', $pageNo = 1, &$total = null)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    $newsDAO = new \enterprise\daos\News();
    if ($langCode == 'en') {
        $condition = "`site_id`={$siteId} AND `deleted`=0";
        $condition .= ($additionalConditions?(' AND ' . $additionalConditions):'');
        $fields = '`id`, `caption`, `head_image_id`, `created`, `updated`, `content`';
        if ($additionalFields)
            $fields .= ", {$additionalFields}";
        $news = $newsDAO->getMultiInOrderBy($condition, $fields, ($orderBy??'`id` DESC'), $pageSize, $start);
        if (isset($total))
            $total = $newsDAO->countBy($condition);
    } else {
        $langNewsDAO = new \enterprise\daos\LangNews($langCode);
        $tableName = $langNewsDAO->getTableName();
        $newsTableName = $newsDAO->getTableName();
        $condition = "ln.`site_id`={$siteId} AND ln.`deleted`=0";
        $condition .= ($additionalConditions?(' AND ' . $additionalConditions):'');
        $fields = ENTERPRISE_NEWS_FIELDS_FOR_INFO;
        if ($additionalFields)
            $fields .= ", {$additionalFields}";
        $sql = "SELECT {$fields} FROM `{$tableName}` ln
LEFT JOIN `{$newsTableName}` n ON n.`id`=ln.`news_id`
WHERE {$condition}";
        if ($orderBy)
            $sql = ' ORDER BY ' . $orderBy;
        $news = $langNewsDAO->getMultiBySql($sql);
        if (isset($total)) {
            $strippedCondition = str_replace('ln.', '', $condition);
            $total = $langNewsDAO->countBy($strippedCondition);
        }
    }

    return $news;
}

/**
 * Get News Info
 */
function enterprise_get_news_info($newsId, $langCode = 'en')
{
    $newsId = (int)$newsId;

    $newsDAO = new \enterprise\daos\News();
    if ($langCode == 'en')
        return $newsDAO->get($newsId);
    else {
        $langNewsDAO = new \enterprise\daos\LangNews($langCode);
        $newsTableName = $newsDAO->getTableName();
        $tableName = $langNewsDAO->getTableName();
        $sql = "SELECT n.`id`, ln.*, n.`head_image_id` FROM `{$tableName}` ln
LEFT JOIN `{$newsTableName}` n ON n.`id`=ln.`news_id`
WHERE ln.`news_id`={$newsId}";
        return $langNewsDAO->getOneBySql($sql);
    }
}

/**
 * Assign News info
 */
function enterprise_assign_news_info($smarty, $var, $newsId, $langCode = 'en')
{
    $news = enterprise_get_news_info($newsId, $langCode);
    $smarty->assign($var, $news);
}

/**
 * Assign Next News info
 */
function enterprise_assign_next_news_info($smarty, $var, $siteId, $newsId, $langCode = 'en')
{
    $newsDAO = new \enterprise\daos\News();
    if ($langCode == 'en') {
        $condition = "`site_id`={$siteId} AND `deleted`=0 AND `id`>{$newsId} ORDER BY `id`";
        $news = $newsDAO->getOneBy($condition);
    } else {
        $langNewsDAO = new \enterprise\daos\LangNews($langCode);
        $tableName = $langNewsDAO->getTableName();
        $newsTableName = $newsDAO->getTableName();
        $condition = "ln.`site_id`={$siteId} AND ln.`deleted`=0 AND ln.`news_id`>{$newsId}";
        $fields = ENTERPRISE_NEWS_FIELDS_FOR_INFO;
        $sql = "SELECT {$fields} FROM `{$tableName}` ln
LEFT JOIN `{$newsTableName}` n ON n.`id`=ln.`news_id`
WHERE {$condition}
ORDER BY ln.`news_id`";
        $news = $langNewsDAO->getOneBySql($sql);
    }
    $smarty->assign($var, $news);
}

/**
 * Assign Prev News info
 */
function enterprise_assign_prev_news_info($smarty, $var, $siteId, $newsId, $langCode = 'en')
{
    $newsDAO = new \enterprise\daos\News();
    if ($langCode == 'en') {
        $condition = "`site_id`={$siteId} AND `deleted`=0 AND `id`<{$newsId} ORDER BY `id` DESC";
        $news = $newsDAO->getOneBy($condition);
    } else {
        $langNewsDAO = new \enterprise\daos\LangNews($langCode);
        $tableName = $langNewsDAO->getTableName();
        $newsTableName = $newsDAO->getTableName();
        $condition = "ln.`site_id`={$siteId} AND ln.`deleted`=0 AND ln.`news_id`<{$newsId}";
        $fields = ENTERPRISE_NEWS_FIELDS_FOR_INFO;
        $sql = "SELECT {$fields} FROM `{$tableName}` ln
LEFT JOIN `{$newsTableName}` n ON n.`id`=ln.`news_id`
WHERE {$condition}
ORDER BY ln.`news_id` DESC";
        $news = $langNewsDAO->getOneBySql($sql);
    }
    $smarty->assign($var, $news);
}
/* }}} */


/* {{{ UserVoice */

/**
 * Get default user-voice list
 *
 * @return array
 */
function enterprise_get_default_user_voice_list()
{
    return array(
            array(
                    'title' => 'Victor',
                    'voice' => 'I want to say that your products very good. Thank you for all your suggestion, also good after sales service.',
                ),
            array(
                    'title' => 'Ms. Smith',
                    'voice' => 'The company considerate after-sales service ,And try their best to meet the requirement of customers. We will be a long-term cooperation.',
                ),
            array(
                    'title' => 'Mr. Johnifere',
                    'voice' => 'We trust the quality of your products. It always the best. Keep this going, and we will establish a long-term trade relationship with you.',
                ),
        );
}
/**
 * Assign UserVoice List
 */
function enterprise_assign_user_voice_list($smarty, $var, $siteId, $langCode = 'en', $pageNo = 1, $pageSize = 10)
{
    $userVoices = enterprise_get_user_voice_list($siteId, $langCode, $pageSize, $pageNo);
    $smarty->assign($var, $userVoices);
}

/**
 * Assign UserVoice List
 *
 * @return array
 */
function enterprise_get_user_voice_list($siteId, $langCode = 'en', $pageSize = 10, $additionalConditions = '', $orderBy = null, $additionalFields = '', $pageNo = 1)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    if ($langCode == 'en') {
        $userVoiceDAO = new \enterprise\daos\UserVoice();
        $condition = "`site_id`={$siteId} AND `deleted`=0";
        $fields = '`id`, `title`, `avatar_image_id`, `created`, `updated`, `voice`';
        $orderBy = $orderBy??'`id` DESC';
    } else {
        $userVoiceDAO = new \enterprise\daos\LangUserVoice($langCode);
        $condition = "eluv.`site_id`={$siteId} AND eluv.`deleted`=0";
        $fields = 'euv.`id`, euv.`avatar_image_id`, eluv.*';
        $orderBy = $orderBy??'eluv.`user_voice_id` DESC';
    }
    $condition .= ($additionalConditions?(' AND ' . $additionalConditions):'');
    if ($additionalFields)
        $fields .= ", {$additionalFields}";

    $userVoices = $userVoiceDAO->getMultiInOrderBy($condition, $fields, $orderBy, $pageSize, $start);
    return $userVoices;
}

/**
 * Assign UserVoice info
 */
function enterprise_assign_user_voice_info($smarty, $var, $userVoiceId, $langCode = 'en')
{
    $userVoice = enterprise_get_user_voice_info($userVoiceId, $langCode);
    $smarty->assign($var, $userVoice);
}

/**
 * Get UserVoice info
 */
function enterprise_get_user_voice_info($userVoiceId, $langCode = 'en')
{
    // UserVoice
    $userVoiceDAO = new \enterprise\daos\UserVoice();
    $userVoice = $userVoiceDAO->get($userVoiceId);

    // Language UserVoice
    if ($langCode != 'en') {
        $langUserVoiceDAO = new \enterprise\daos\LangUserVoice($langCode);
        $condition = '`user_voice_id`=' . (int)$userVoiceId;
        $langUserVoice = $langUserVoiceDAO->getOneBy($condition);
        if ($langUserVoice)
            $userVoice = array_merge($userVoice, $langUserVoice);
    }

    return $userVoice;
}

/* }}} */

/**
 * 展示附件
 */
function enterprise_action_attachment_proc($guidHex)
{
    $attachmentDAO = new \enterprise\daos\Attachment();
    $condition = '`guid`=UNHEX(\'' . $guidHex . '\')';
    $attachment = $attachmentDAO->getOneBy($condition);
    if (!$attachment)
        return null;

    header('Content-Type: ' . $attachment['content_type']);
    header('Cache-Control: max-age=3600');
    return $attachment['body'];
}


/* {{{ MainProduct */

/**
 * Assign MainProduct List
 *
 * @return string Condition
 */
function enterprise_assign_main_product_list($smarty, $var, $siteId, $pageNo = 1, $pageSize = 10)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    $mainProductDAO = new \enterprise\daos\MainProduct();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $mainProducts = $mainProductDAO->getMultiInOrderBy($condition, '`id`, `label`, `url`, `target_product_id`, `created`, `updated`, `url`', '`id` DESC', $pageSize, $start);
    $smarty->assign($var, $mainProducts);

    return $condition;
}

/**
 * Assign MainProduct info
 */
function enterprise_assign_main_product_info($smarty, $var, $mainProductId)
{
    $mainProductDAO = new \enterprise\daos\MainProduct();
    $mainProduct = $mainProductDAO->get($mainProductId);
    $smarty->assign($var, $mainProduct);
}

/* }}} */


/* {{{ Picture */
/**
 * Assign Picture List
 *
 * @return string Condition
 */
function enterprise_assign_picture_list($smarty, $var, $siteId)
{
    $siteId = (int)$siteId;

    $pictureDAO = new \enterprise\daos\Picture();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $pictures = $pictureDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $pictures);

    return $condition;
}

/**
 * Assign picture info
 */
function enterprise_assign_picture_info($smarty, $var, $pictureId)
{
    $pictureDAO = new \enterprise\daos\Picture();
    $picture = $pictureDAO->get($pictureId);
    $smarty->assign($var, $picture);
}

/* }}} */


/* {{{ IndexKeyword */

/**
 * Assign IndexKeyword List
 *
 * @return string Condition
 */
function enterprise_assign_index_keyword_list($smarty, $var, $siteId, $langCode = 'en', $pageNo = 1, $pageSize = 10)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    //if ($langCode == 'en') {
        $userVoiceDAO = new \enterprise\daos\IndexKeyword();
        $condition = "`site_id`={$siteId} AND `deleted`=0";
        $userVoices = $userVoiceDAO->getMultiInOrderBy($condition, '`id`, `keyword`, `url`, `created`, `updated`', '`id` DESC', $pageSize, $start);
    /*} else {
        $userVoiceDAO = new \enterprise\daos\LangIndexKeyword($langCode);
        $condition = "eluv.`site_id`={$siteId} AND eluv.`deleted`=0";
        $userVoices = $userVoiceDAO->getMultiInOrderBy($condition, 'euv.`id`, eluv.*', 'eluv.`index_keyword_id` DESC', $pageSize, $start);
    }*/
    $smarty->assign($var, $userVoices);

    return $condition;
}

/**
 * Assign IndexKeyword info
 */
function enterprise_assign_index_keyword_info($smarty, $var, $userVoiceId, $langCode = 'en')
{
    $userVoice = enterprise_get_index_keyword_info($userVoiceId, $langCode);
    $smarty->assign($var, $userVoice);
}

/**
 * Get IndexKeyword info
 */
function enterprise_get_index_keyword_info($userVoiceId, $langCode = 'en')
{
    // IndexKeyword
    $userVoiceDAO = new \enterprise\daos\IndexKeyword();
    $userVoice = $userVoiceDAO->get($userVoiceId);

    // Language IndexKeyword
    /*
    if ($langCode != 'en') {
        $langIndexKeywordDAO = new \enterprise\daos\LangIndexKeyword($langCode);
        $condition = '`index_keyword_id`=' . (int)$userVoiceId;
        $langIndexKeyword = $langIndexKeywordDAO->getOneBy($condition);
        if ($langIndexKeyword)
            $userVoice = array_merge($userVoice, $langUserVoice);
    }*/

    return $userVoice;
}

/* }}} */


/* {{{ Keyword */

/**
 * Assign Keyword List
 *
 * @return string Condition
 */
function enterprise_assign_keyword_list($smarty, $var, $siteId, $langCode = 'en', $pageNo = 1, $pageSize = 10, $alphabet = null)
{
    $condition = '';
    $keywords = enterprise_get_keyword_list($siteId, $langCode, $alphabet, $pageNo, $pageSize, null, '`id` DESC', $condition);
    $smarty->assign($var, $keywords);

    return $condition;
}

/**
 * Get Keyword List
 *
 * @return array
 */
function enterprise_get_keyword_list($siteId, $langCode, $alphabet, $pageNo, $pageSize, $extraCondition = null, $orderBy = null, &$condition = '')
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    //if ($langCode == 'en') {
        $keywordDAO = new \enterprise\daos\Keyword();
        $condition = "`site_id`={$siteId} AND `deleted`=0";
        if (isset($alphabet))
            $condition .= " AND `alphabet`=" . (int)$alphabet;
        if (isset($extraCondition))
            $condition .= ' AND ' . $extraCondition;
        $keywords = $keywordDAO->getMultiInOrderBy($condition, '`id`, `keyword`, `has_desc`, `created`, `updated`', $orderBy, $pageSize, $start);
    /*} else {
        $keywordDAO = new \enterprise\daos\LangKeyword($langCode);
        $condition = "eluv.`site_id`={$siteId} AND eluv.`deleted`=0";
        $keywords = $keywordDAO->getMultiInOrderBy($condition, 'euv.`id`, eluv.*', 'eluv.`keyword_id` DESC', $pageSize, $start);
    }*/
    return $keywords;
}

/**
 * Assign Keyword info
 */
function enterprise_assign_keyword_info($smarty, $var, $keywordId, $langCode = 'en')
{
    $keyword = enterprise_get_keyword_info($keywordId, $langCode);
    $smarty->assign($var, $keyword);
}

/**
 * Get Keyword info
 */
function enterprise_get_keyword_info($keywordId, $langCode = 'en')
{
    // Keyword
    $keywordDAO = new \enterprise\daos\Keyword();
    $keyword = $keywordDAO->get($keywordId);

    // Language Keyword
    /*
    if ($langCode != 'en') {
        $langIndexKeywordDAO = new \enterprise\daos\LangIndexKeyword($langCode);
        $condition = '`index_keyword_id`=' . (int)$keywordId;
        $langIndexKeyword = $langIndexKeywordDAO->getOneBy($condition);
        if ($langIndexKeyword)
            $keyword = array_merge($keyword, $langUserVoice);
    }*/

    return $keyword;
}

/**
 * URL - Keyword List
 *
 * @return string
 */
function enterprise_url_keyword_list($firstChar, $pageNo = 1)
{
    $pageString = '';
    if ($pageNo > 1)
        $pageString = '-' . $pageNo;
    return enterprise_url_prefix() . '/words-' . $firstChar . $pageString . '.html';
}

/* }}} */