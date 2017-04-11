<?php
/**
 * 项目公用函数库
 *
 * @package timandes\enterprise
 */

/** @var string Pattern of Product List */
define('PATTERN_PRODUCT_LIST', '/^\/factory-([0-9]+)(p([0-9]+))?((-[0-9a-z]+)+)?$/');
/** @var string Pattern of Product Detail */
define('PATTERN_PRODUCT_DETAIL', '/^\/sell-([0-9]+)(p([0-9]+))?((-[0-9a-z]+)+)?\.html$/');
/** @var string Pattern of Product Index */
define('PATTERN_PRODUCT_INDEX', '/^\/products(-([0-9]+))?\.html$/');
/** @var string Fields of Product for List */
define('ENTERPRISE_PRODUCT_FIELDS_FOR_LIST', '`id`, `caption`, `head_image_id`, `group_id`, `brand_name`, `model_number`, `certification`, `place_of_origin`, `min_order_quantity`, `price`, `payment_terms`, `supply_ability`, `delivery_time`, `packaging_details`');
/** @var string Fields of Custom Page for List */
define('ENTERPRISE_CUSTOM_PAGE_FIELDS_FOR_LIST', '`id`, `path`, `desc`, `created`, `updated`');
/** @var int Max Urls per File */
define('ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE', 5000);

/** @var int PC端 */
define('ENTERPRISE_PLATFORM_PC', 10);
/** @var int 移动端 */
define('ENTERPRISE_PLATFORM_MOBILE', 20);

/* {{{ Common */

/**
 * 从Host中分离出语言类型和域名
 */
function enterprise_extract_locale_n_domain($host)
{
    $meta = enterprise_extract_host_meta($host);
    return array($meta['locale'], $meta['root_domain']);
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
        $locale = ($subdomain=='www'||$subdomain=='m'?'english':$hostObj->subdomain);
        $platform = (($subdomain == 'm')?ENTERPRISE_PLATFORM_MOBILE:ENTERPRISE_PLATFORM_PC);
    } else {
        $a = explode('.', $subdomain);
        $locale = $a[1];
        $platform = (($a[0] == 'm')?ENTERPRISE_PLATFORM_MOBILE:ENTERPRISE_PLATFORM_PC);
    }

    return array(
            'locale' => $locale,
            'root_domain' => $currentDomainSuffix,
            'platform' => $platform,
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

    return array(
            $siteId, $platform, $locale, $originalDomainSuffix, $currentDomainSuffix,
        );
}

/**
 * Generate GUID
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

/* }}} */

/* {{{ Sitemap */

/**
 * 展示Sitemap Index页面
 */
function enterprise_action_sitemap_index_proc($siteId, $currentDomainSuffix)
{
    $translationDAO = new \crawler\daos\Translation();
    $sitemapIndex = new \Thepixeldeveloper\Sitemap\SitemapIndex(); 
    $translations = $translationDAO->getBySite($siteId);

    if (is_array($translations)
            && $translations) foreach ($translations as $translation) {
        $loc = 'http://www.' . $currentDomainSuffix . '/sitemap/' . $translation['locale'] . '.xml';
        $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
        $sitemapIndex->addSitemap($sitemap);
    }

    {
        $siteDAO = new enterprise\daos\Site();
        $condition = "`site_id`=" . (int)$siteId;
        $site = $siteDAO->getOneBy($condition);
        $productCnt = (int)$site['product_cnt'];
        $productsPerFile = ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE;
        $sitemapFiles = (int)($productCnt / $productsPerFile) + (($productCnt % $productsPerFile)?1:0);
        for ($i=1; $i<=$sitemapFiles; ++$i) {
            $loc = enterprise_url_sitemap($currentDomainSuffix, $i);
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

    // New groups N products
    if ($locale == 'english') {
        // groups
        $groupDAO = new \enterprise\daos\Group();
        $curGroupId = 0;
        $max = 100;
        do {
            $condition = "`site_id`={$siteId} AND `deleted`=0 AND `id`>{$curGroupId}";
            $groups = $groupDAO->getMultiBy($condition, $max);
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
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}

/**
 * 展示Sitemap页面
 */
function enterprise_action_sitemap_proc_2($siteId, $originalDomainSuffix, $currentDomainSuffix, $no = 1)
{
    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 

    $productDAO = new \enterprise\daos\Product();
    $start = ($no - 1) * ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE;
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $products = $productDAO->getMultiInOrderBy($condition, ENTERPRISE_PRODUCT_FIELDS_FOR_LIST, '`id` ASC', ENTERPRISE_SITEMAP_MAX_URLS_PER_FILE, $start);
    if ($products) foreach ($products as $product) {
        $loc = enterprise_url_product($product);
        $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
        $urlSet->addUrl($url);
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}

/* }}} */

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
        $condition = "`image_id`=" . (int)$imageId;
        $thumbnail = $thumbnailDAO->getOneBy($condition);
        if (!$thumbnail
                || !$thumbnail[$field]) {
            http_response_code(404);
            exit;
        }

        header('Content-Type: image/jpeg');
        echo $thumbnail[$field];
    } else {
        $imageDAO = new \enterprise\daos\Image();
        $image = $imageDAO->get($imageId);
        if (!$image) {
            http_response_code(404);
            exit;
        }

        header('Content-Type: image/jpeg');
        echo $image['body'];
    }
    exit;
}

function enterprise_assign_action_product_detail($smarty, $siteId, $productId)
{
    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);
    if (!$product) 
        throw new HttpException(404);
    $smarty->assign('product', $product);

    // Tags
    $productTags = array();
    if ($product['tags']) {
        $a = explode(',', $product['tags']);
        foreach ($a as $tag) {
            $productTags[] = trim($tag);
        }
    }
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
    $groups = enterprise_assign_group_list($smarty, 'groups', $siteId);

    // Product Group
    foreach ($groups as $group) {
        if ($group['id'] == $product['group_id']) {
            $smarty->assign('group', $group);
            $smarty->assign('product_group', $group);
            break;
        }
    }

    // New Products
    enterprise_assign_product_list($smarty, 'new_products', $siteId, $product['group_id']);
}

/**
 * Product Detail
 */
function enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId)
{
    if (!$productId)
        throw new HttpException(404);

    enterprise_assign_action_product_detail($smarty, $siteId, $productId);

    $tplPath = 'sites/' . $siteId . '/product_detail.tpl';
    $response = $smarty->fetch($tplPath);
    echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_output_cnzz($currentDomainSuffix);
}

function enterprise_assign_action_product_list($smarty, $siteId, $groupId = null, $pageNo = 1, $pageSize = 10)
{
    // Product list
    $condition = enterprise_assign_product_list($smarty, 'products', $siteId, $groupId, $pageNo, $pageSize);

    // Total products
    $productDAO = new \enterprise\daos\Product();
    $totalProducts = $productDAO->countBy($condition);
    $totalPages = (int)($totalProducts / $pageSize) + (($totalProducts % $pageSize)?1:0);
    $smarty->assign('total_products', $totalProducts);
    $smarty->assign('page_size', $pageSize);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    // Group info
    if ($groupId) {
        $groupDAO = new \enterprise\daos\Group();
        $group = $groupDAO->get($groupId);
        if (!$group) 
            throw new HttpException(404);
        $smarty->assign('group', $group);
    }

    // All groups
    enterprise_assign_group_list($smarty, 'groups', $siteId);
}

/**
 * Product List
 */
function enterprise_action_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId = null, $pageNo = 1)
{
    if (!$groupId)
        throw new HttpException(404);

    $pageSize = enterprise_site_info_get_product_list_page_size($siteId);
    if (!$pageSize)
        $pageSize = 10;

    enterprise_assign_action_product_list($smarty, $siteId, $groupId, $pageNo, $pageSize);

    // Filter
    $tplPath = 'sites/' . $siteId . '/product_list.tpl';
    $response = $smarty->fetch($tplPath);
    echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_output_cnzz($currentDomainSuffix);
}

/**
 * 保存询盘
 */
function enterprise_action_save_inquiry_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $site = null;
    $tplPath = enterprise_decide_template_path($smarty, $siteId, '/contactsave.tpl', $site);
    if ($tplPath) {
        // Site
        $smarty->assign('site', $site);

        // Corporation
        enterprise_assign_corporation_info($smarty, 'corporation', $siteId);

        // Groups
        $groups = enterprise_assign_group_list($smarty, 'groups', $siteId, 2, true, true, 5);

        // Domain suffix
        $smarty->assign('site_root_domain', $currentDomainSuffix);
    } else
        $tplPath = 'inquiry_sent.tpl';

    $subject = timandes_get_post_data('subject');
    $message = timandes_get_post_data('message', 'trim');
    $email = timandes_get_post_data('email');

    $messageType = timandes_get_post_data('message_type');
    if ($messageType == 'text/plain')
        $message = nl2br($message);

    // Validation
    if (!$subject
            || !$message
            || !$email) {
        header('Location: /contactnow.html');
        exit(0);
    }

    // Upload files
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
    // Create inquiry
    $inquiryDAO = new \enterprise\daos\Inquiry();
    $guid = enterprise_generate_guid();
    $values = array(
            'guid' => $guid,
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
            'created' => date('Y-m-d H:i:s'),
            'domain' => $currentDomainSuffix,
            'ip' => $_SERVER['REMOTE_ADDR'],
            'target_product_id' => (int)timandes_get_post_data('target_product_id'),
        );
    $inquiryDAO->insert($values);
    // Send Email
    $userDAO = new \enterprise\daos\User();
    $condition = "`site_id`=" . (int)$siteId;
    $user = $userDAO->getOneBy($condition);
    if ($user
            && $user['email']
            && Nette\Utils\Validators::is($user['email'], 'email')) {
        $mailDomain = 'mail.50u50.com';
        $from = 'no-reply@' . $mailDomain;
        $mail = timandes_initialize_mail_message($user['email'], $from, $user['email'], $subject, $message);
        $mailer = new Nette\Mail\SmtpMailer(array(
                'host' => $mailDomain,
            ));
        $mailer->send($mail);
    }
    $smarty->display($tplPath);
    enterprise_output_cnzz($currentDomainSuffix);
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
 * Router
 */
function enterprise_route($smarty, $requestPath, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    if ($requestPath == '/contactsave.html') {
        return enterprise_action_save_inquiry_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(preg_match(PATTERN_PRODUCT_DETAIL, $requestPath, $matches)) {
        $productId = $matches[1];
        return enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId);
    } elseif ($requestPath == '/robots.txt') {
        return enterprise_action_robots_txt($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(preg_match(PATTERN_PRODUCT_LIST, $requestPath, $matches)) {
        $groupId = $matches[1];
        if ($matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        return enterprise_action_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId, $pageNo);
    }

    throw new HttpException(404);
}

/**
 * Router V2
 *
 * @return string Response
 */
function enterprise_route_2($smarty, $requestPath, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    if ($requestPath == '/contactus.html') {
        return enterprise_action_sets_contactus_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif ($requestPath == '/aboutus.html') {
        return enterprise_action_sets_aboutus_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(preg_match(PATTERN_PRODUCT_DETAIL, $requestPath, $matches)) {
        $productId = $matches[1];
        if ($matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        return enterprise_action_sets_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId, $pageNo);
    } elseif(preg_match(PATTERN_PRODUCT_LIST, $requestPath, $matches)) {
        $groupId = $matches[1];
        if (isset($matches[3])
                && $matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        return enterprise_action_sets_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId, $pageNo);
    } elseif(preg_match(PATTERN_PRODUCT_INDEX, $requestPath, $matches)) {
        if (isset($matches[2])
                && $matches[2])
            $pageNo = (int)$matches[2];
        else
            $pageNo = 1;
        return enterprise_action_sets_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, null, $pageNo);
    } elseif ($requestPath == '/quality.html') {
        return enterprise_action_sets_quality_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif ($requestPath == '/') {
        return enterprise_action_sets_home_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif ($requestPath == '/contactnow.html') {
        return enterprise_action_sets_contactnow_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
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
    return 'http://' . $_SERVER['HTTP_HOST'];
}

/**
 * URL - Image
 *
 * @return string
 */
function enterprise_url_image($imageId, $productCaption = '', $imageSizeType = '', $default = '')
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
            return '/media/sets/trade/no_image.png';
    }

    $suffix = '';
    if ($productCaption)
        $suffix = '-' . enterprise_generate_url_key($productCaption);

    return enterprise_url_prefix() . '/uploaded_images/' . $imageSizeType . $imageId . $suffix . '.jpg';
}

/**
 * URL - Image
 *
 * @return string
 */
function enterprise_url_photo($uri, $desc = '', $imageSizeType = '', $default = '')
{
    if (strpos($uri, 'http://') === 0)
        return $uri;

    $imageId = (int)str_replace('image://', '', $uri);
    return enterprise_url_image($imageId, $desc, $imageSizeType, $default);
}

/**
 * URL - Product
 *
 * @return string
 */
function enterprise_url_product($product, $pageNo = 1)
{
    $pageString = '';
    if ($pageNo > 1)
        $pageString = 'p' . $pageNo;
    return enterprise_url_prefix() . '/sell-' . $product['id'] . $pageString . '-' . enterprise_generate_url_key($product['caption']) . '.html';
}

/**
 * URL - Product List
 *
 * @return string
 */
function enterprise_url_product_list($group = null, $pageNo = 1)
{
    if ($group) {
        $pageString = '';
        if ($pageNo > 1)
            $pageString = 'p' . $pageNo;
        return enterprise_url_prefix() . '/factory-' . $group['id'] . $pageString . '-' . enterprise_generate_url_key($group['name']);
    } else {
        $pageString = '';
        if ($pageNo > 1)
            $pageString = '-' . $pageNo;
        return enterprise_url_prefix() . '/products' . $pageString . '.html';
    }
}

/**
 * URL - Sitemap
 */
function enterprise_url_sitemap($currentDomainSuffix, $no = 1)
{
    $suffix = '';
    if ($no > 1)
        $suffix = '-' . $no;
    return 'http://www.' . $currentDomainSuffix . '/sitemap/product' . $suffix . '.xml';
}

/* }}} */

/**
 * Assign Group List
 *
 * @return array Group Array
 */
function enterprise_assign_group_list($smarty, $var, $siteId, $max = null, $skipEmpty = true,
        $appendFirstProducts = false, $maxAppendedProducts = 1)
{
    $maxGroupsFromDb = ($appendFirstProducts?null:$max);
    $cntString = ($skipEmpty?' AND `cnt`>0':'');

    $groupDAO = new \enterprise\daos\Group();
    $condition = "`site_id`={$siteId} AND `deleted`=0{$cntString}";
    $groups = $groupDAO->getMultiInOrderBy($condition, '*', null, $maxGroupsFromDb);

    if ($appendFirstProducts) {
        $productDAO = new \enterprise\daos\Product();
        $retval = array();
        $accItems = 0;
        foreach ($groups as $group) {
            $groupId = (int)$group['id'];
            $condition = "`site_id`={$siteId} AND `group_id`={$groupId} AND `deleted`=0";
            $products = $productDAO->getMultiInOrderBy($condition, ENTERPRISE_PRODUCT_FIELDS_FOR_LIST, '`id` DESC', $maxAppendedProducts);
            $group['products'] = $products;
            $retval[] = $group;
            ++$accItems;

            if ($max
                    && $accItems >= $max)
                break;
        }
        $groups = $retval;
    }

    $smarty->assign($var, $groups);
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
        $fragment = $document->createDocumentFragment();
        $fragment->appendXML($newGroupListHtmlFragment);
        $groupListElement->appendChild($fragment);
        $newGroupListHtml = $document->saveHTML($groupListElement);
        $response = str_replace($originalGroupListHtml, $newGroupListHtml, $response);
    }

    return $response;
}

/* {{{ Site Info */
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
 * Assign corporation info
 */
function enterprise_assign_corporation_info($smarty, $var, $siteId)
{
    $corporationDAO = new \enterprise\daos\Corporation();
    $condition = "`site_id`=" . (int)$siteId;
    $corporation = $corporationDAO->getOneBy($condition);
    $smarty->assign($var, $corporation);
}

/**
 * Assign site info
 */
function enterprise_assign_site_info($smarty, $var, $siteId)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    $smarty->assign($var, $site);
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
function enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix, $appendFirstProductsToGroups = false, $maxAppendedProductsToGroups = null)
{
    // Corporation
    enterprise_assign_corporation_info($smarty, 'corporation', $siteId);

    // Groups
    enterprise_assign_group_list($smarty, 'groups', $siteId, null, true, $appendFirstProductsToGroups, $maxAppendedProductsToGroups);

    // Domain suffix
    $smarty->assign('site_root_domain', $currentDomainSuffix);

    // Quick questions
    $smarty->assign('quick_questions', enterprise_get_quick_questions_for_inquiry());

    // Contacts
    enterprise_assign_contact_list($smarty, 'contacts', $siteId);
}

/**
 * @param array &$site Return site info
 * @return string Path
 */
function enterprise_decide_template_path($smarty, $siteId, $relativePath, &$site = null)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    if ($site) {
        $templateName = $site['template'];

        $tplPath = 'sets/' . $templateName . $relativePath;
        if ($smarty->templateExists($tplPath))
            return $tplPath;
    }

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
function enterprise_action_sets_contactus_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $site = null;
    $tplPath = enterprise_decide_template_path($smarty, $siteId, '/contactus.tpl', $site);
    if (!$tplPath)
        return null;

    // Site
    $smarty->assign('site', $site);

    // Contact Desc Mapping
    $contactDescMapping = array(
            'name' => 'Contact Person',
            'title' => 'Job Title',
            'tel' => 'Business Phone',
            'skype' => 'Skype',
            'email' => 'Email',
            'yahoo' => 'Yahoo',
            'icq' => 'ICQ',
            'viber' => 'Viber',
            'whatsapp' => 'WhatsApp',
        );
    $smarty->assign('contact_desc', $contactDescMapping);

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix);
    $corporation = $smarty->getTemplateVars('corporation');

    // TDK
    $smarty->assign('title', "{$corporation['tel_wt']} - {$corporation['name']}");
    $smarty->assign('keywords', "{$corporation['name']}, Contact Us, {$corporation['tel_wt']}");
    $smarty->assign('description', "Contact us by {$corporation['tel_wt']} - {$corporation['name']}.");

    return $smarty->fetch($tplPath);
}

/**
 * /aboutus.html
 *
 * @return string
 */
function enterprise_action_sets_aboutus_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    if (!$site)
        return null;
    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/aboutus.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    // Photos - AboutUs
    enterprise_assign_photo_list($smarty, 'photos', $siteId, \enterprise\daos\Photo::TYPE_ABOUT_US);

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix);
    $corporation = $smarty->getTemplateVars('corporation');

    // TDK
    $smarty->assign('title', "Company Introduction - {$corporation['name']}");
    $smarty->assign('keywords', "{$corporation['name']}, China {$corporation['name']}, Company Introduction");
    $smarty->assign('description', "Supplier's profile of {$corporation['name']}, China quality supplier.");

    return $smarty->fetch($tplPath);
}

/**
 * 向模板追加产品详情页的TDK
 */
function enterprise_assign_tdk_of_product_detail($smarty, $corporation, $product, $productGroup)
{
    $productGroupName = (isset($productGroup['name'])?$productGroup['name']:'');

    $presetTitle = "Buy {$product['caption']} - {$corporation['name']}";
    $smarty->assign('title', ($product['html_title']?$product['html_title']:$presetTitle));

    $presetKeywords = "{$product['caption']}, China {$productGroupName} manufacturer, {$productGroupName} supplier, {$productGroupName} for sale";
    $smarty->assign('keywords', ($product['meta_keywords']?$product['meta_keywords']:$presetKeywords));

    $presetDescription = "Buy {$product['caption']} from quality {$productGroupName} manufacturers of {$corporation['name']}.";
    $smarty->assign('description', ($product['meta_description']?$product['meta_description']:$presetDescription));
}

/**
 * /sell-*.html
 *
 * @return string
 */
function enterprise_action_sets_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId, $pageNo = 1)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    if (!$site)
        return null;
    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/product_detail.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    enterprise_assign_action_product_detail($smarty, $siteId, $productId);

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

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix);
    $corporation = $smarty->getTemplateVars('corporation');
    $product = $smarty->getTemplateVars('product');
    $productGroup = $smarty->getTemplateVars('product_group');

    // TDK
    enterprise_assign_tdk_of_product_detail($smarty, $corporation, $product, $productGroup);

    return $smarty->fetch($tplPath);
}

/**
 * /supplier-*.html
 *
 * @return string
 */
function enterprise_action_sets_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId = null, $pageNo = 1)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    if (!$site)
        return null;
    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/product_list.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    enterprise_assign_action_product_list($smarty, $siteId, $groupId, $pageNo);

    // Product Desc Mapping
    $productDescMapping = array(
            'place_of_origin' => array(
                    'label' => 'Place of Origin',
                    'default' => '',
                ),
            'brand_name' => array(
                    'label' => 'Brand Name',
                    'default' => '',
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
    $smarty->assign('product_desc', $productDescMapping);

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix);
    $corporation = $smarty->getTemplateVars('corporation');

    // TDK
    $pageInfo = (($pageNo > 1)?" of page {$pageNo}":'');
    if (null === $groupId) {// /products.html
        $smarty->assign('title', "Product Categories - {$corporation['name']}{$pageInfo}");
        $smarty->assign('keywords', "Product Categories, Product for sale, {$corporation['name']}");
        $smarty->assign('description', "Product Categories - buy quality products from {$corporation['name']}{$pageInfo}.");
    } else {// supplier-*.html
        $group = $smarty->getTemplateVars('group');
        $smarty->assign('title', "{$group['name']} - {$group['name']} for sale{$pageInfo}");
        $smarty->assign('keywords', "{$group['name']}, {$corporation['name']}, Quality {$group['name']}, {$group['name']} for sale");
        $smarty->assign('description', "Buy {$group['name']}, we provide quality {$group['name']} and you can choose the right product you want{$pageInfo}.");
    }

    return $smarty->fetch($tplPath);
}


/**
 * /quality.html
 *
 * @return string
 */
function enterprise_action_sets_quality_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    if (!$site)
        return null;
    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/quality.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    // Certifications
    enterprise_assign_certification_list($smarty, 'certifications', $siteId);

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix);
    $corporation = $smarty->getTemplateVars('corporation');
    $groups = $smarty->getTemplateVars('groups');

    // TDK
    $group1Name = (isset($groups[0]['name'])?$groups[0]['name']:'');
    $smarty->assign('title', "Quality control - {$corporation['name']}");
    $smarty->assign('keywords', "{$corporation['name']}, Best quality, Quality control");
    $smarty->assign('description', "Quality control - {$corporation['name']} provide {$group1Name} with best quality.");

    return $smarty->fetch($tplPath);
}

/**
 * /
 *
 * @return string
 */
function enterprise_action_sets_home_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $siteDAO = new \enterprise\daos\Site();
    $condition = "`site_id`=" . (int)$siteId;
    $site = $siteDAO->getOneBy($condition);
    if (!$site)
        return null;
    $templateName = $site['template'];

    $tplPath = 'sets/' . $templateName . '/home.tpl';
    if (!$smarty->templateExists($tplPath))
        return null;

    // Site
    $smarty->assign('site', $site);

    // Banners
    enterprise_assign_banner_list($smarty, 'banners', $siteId);

    // Products
    enterprise_assign_product_list($smarty, 'products', $siteId, $groupId = null, 1, 10);

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix, true, 3);
    $corporation = $smarty->getTemplateVars('corporation');
    $groups = $smarty->getTemplateVars('groups');

    // TDK
    $group1Name = (isset($groups[0]['name'])?$groups[0]['name']:'');
    $smarty->assign('title', "Quality {$group1Name} - {$corporation['name']}");
    $smarty->assign('keywords', "{$group1Name}, China Manufacturers, China {$group1Name}, cheap {$group1Name}");
    $smarty->assign('description', "Quality {$group1Name} for sale of {$corporation['name']}, we provide {$group1Name} at lowest price.");

    return $smarty->fetch($tplPath);
}

function enterprise_generate_inquiry_subject_by_product_id($productId)
{
    if (!$productId)
        return null;

    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);
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

function enterprise_get_quick_questions_for_inquiry()
{
    return array(
            'I\'m very interested in your products; could you send me some detail reference information?',
            'Please send me detail product specification, thank you!',
            'May I be an agency of your products,and what\'s yourterms?',
            'We intend to purchase this product, would you please send me the quotation and minimum order quantity?',
        );
}

/**
 * /contactnow.html
 *
 * @return string
 */
function enterprise_action_sets_contactnow_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    $site = null;
    $tplPath = enterprise_decide_template_path($smarty, $siteId, '/contactnow.tpl', $site);
    if (!$tplPath)
        return null;

    // Site
    $smarty->assign('site', $site);

    // Contact Desc Mapping
    $contactDescMapping = array(
            'name' => 'Contact Person',
            'title' => 'Job Title',
            'tel' => 'Business Phone',
            'skype' => 'Skype',
            'email' => 'Email',
            'yahoo' => 'Yahoo',
            'icq' => 'ICQ',
            'viber' => 'Viber',
            'whatsapp' => 'WhatsApp',
        );
    $smarty->assign('contact_desc', $contactDescMapping);

    enterprise_action_sets_common_proc($smarty, $siteId, $currentDomainSuffix);
    $corporation = $smarty->getTemplateVars('corporation');

    // Inquiry subject
    $aboutProductId = (int)enterprise_get_query_by_server_request('about_product');
    $subject = enterprise_generate_inquiry_subject_by_product_id($aboutProductId);
    if (!$subject) {
        $referer = timandes_get_server_data('HTTP_REFERER');
        $refererPath = parse_url($referer, PHP_URL_PATH);
        if ($refererPath
                && preg_match(PATTERN_PRODUCT_DETAIL, $refererPath, $matches)) {
            $productId = $matches[1];
            $smarty->assign('target_product_id', $productId);
            $subject = enterprise_generate_inquiry_subject_by_product_id($productId);
        }

        if (!$subject)
            $subject= 'Inquiry About ' . $corporation['name'];
    } else
        $smarty->assign('target_product_id', $aboutProductId);
    $smarty->assign('subject', $subject);

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
 * Assign Product List
 *
 * @return string Condition
 */
function enterprise_assign_product_list($smarty, $var, $siteId, $groupId = null, $pageNo = 1, $pageSize = 10)
{
    $siteId = (int)$siteId;
    $start = ($pageNo - 1) * $pageSize;

    $groupIdCondition = '';
    if (null !== $groupId) {
        $groupId = (int)$groupId;
        $groupIdCondition = " AND `group_id`={$groupId}";
    }

    $productDAO = new \enterprise\daos\Product();
    $condition = "`site_id`={$siteId}{$groupIdCondition} AND `deleted`=0";
    $products = $productDAO->getMultiInOrderBy($condition, ENTERPRISE_PRODUCT_FIELDS_FOR_LIST, '`id` DESC', $pageSize, $start);
    $smarty->assign($var, $products);

    return $condition;
}

/**
 * Assign product info
 */
function enterprise_assign_product_info($smarty, $var, $productId)
{
    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);
    $smarty->assign($var, $product);
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
