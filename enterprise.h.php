<?php
/**
 * 项目公用函数库
 *
 * @package timandes\enterprise
 */

/* {{{ Common */

/**
 * 获取站点基本信息
 */
function enterprise_extract_site_infos()
{
    global $domainInfo, $siteInfo;

    $a = explode('.', $_SERVER['HTTP_HOST']);
    $n = count($a);
    if ($n < 2)
        throw new HttpException(403);
    elseif ($n == 2)
        $locale = '';
    else
        $locale = ($a[$n-3]=='www'?'english':$a[$n-3]);

    $currentDomainSuffix = $a[$n-2] . '.' . $a[$n-1];
    if (!isset($domainInfo[$currentDomainSuffix])
            || !is_array($domainInfo[$currentDomainSuffix]))
        throw new HttpException(404);

    $siteId = $domainInfo[$currentDomainSuffix]['site_id'];
    if (!isset($siteInfo[$siteId])
            || !is_array($siteInfo[$siteId])) 
        throw new HttpException(404);

    $originalDomainSuffix = $siteInfo[$siteId]['original_domain_prefix'];
    return array(
            $siteId, $locale, $originalDomainSuffix, $currentDomainSuffix,
        );
}

/**
 * Generate GUID
 */
function enterprise_generate_guid()
{
    return md5(uniqid(mt_rand(), true), true);
}

/**
 * 过滤参数值
 *
 * @param mixed $mValue 参数值
 * @param string $sFilters 过滤函数清单
 * @return mixed
 */
function enterprise_filter($mValue, $sFilters = 'trim, strip_tags')
{
    if (!is_string($mValue))
        return $mValue; // skip non-string

    // 使用过滤函数
    if(!empty($sFilters)) {
        $aFilters = explode(',', $sFilters);
        if(is_array($aFilters)) foreach($aFilters as $f) {
            $f = trim($f);
            eval("\$mValue = {$f}(\$mValue);");
        }
    }

    return $mValue;
}

function enterprise_get_post_data($key, $filters = 'trim, strip_tags')
{
    $v = (isset($_POST[$key])?$_POST[$key]:'');
    return enterprise_filter($v, $filters);
}

function enterprise_get_query_data($key, $filters = 'trim, strip_tags')
{
    $v = (isset($_GET[$key])?$_GET[$key]:'');
    return enterprise_filter($v, $filters);
}

function enterprise_get_session_data($key, $filters = 'trim, strip_tags')
{
    $v = (isset($_SESSION[$key])?$_SESSION[$key]:'');
    return enterprise_filter($v, $filters);
}

function enterprise_filter_response($content, $originalDomainSuffix, $currentDomainSuffix)
{
    $content = str_replace('<script type=text/javascript src="/webim/webim.js"></script>', '', $content);
    $content = str_replace($originalDomainSuffix, $currentDomainSuffix, $content);
    $content = str_replace('//www.google-analytics.com/analytics.js', '', $content);
    echo $content;
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

/* }}} */

/**
 * 展示Sitemap Index页面
 */
function enterprise_action_sitemap_index_proc($siteId, $currentDomainSuffix)
{
    $translationDAO = new \crawler\daos\Translation();
    $sitemapIndex = new \Thepixeldeveloper\Sitemap\SitemapIndex(); 
    $translations = $translationDAO->getBySite($siteId);

    if (is_array($translations)) foreach ($translations as $translation) {
        $loc = 'http://www.' . $currentDomainSuffix . '/sitemap/' . $translation['locale'] . '.xml';
        $sitemap = (new \Thepixeldeveloper\Sitemap\Sitemap($loc));
        $sitemapIndex->addSitemap($sitemap);
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
    $pageDAO = new \crawler\daos\Page();
    $curId = 0;
    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 
    do {
        $pages = $pageDAO->getBySite($siteId, $locale, $curId);
        if (!$pages)
            break;

        foreach ($pages as $page) {
            $curId = max($curId, $page['id']);

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
 * 展示用户新发图片
 */
function enterprise_action_uploaded_image_proc($imageId)
{
    if (!$imageId) {
        http_response_code(400);
        exit;
    }

    $imageDAO = new \enterprise\daos\Image();
    $image = $imageDAO->get($imageId);
    if (!$image) {
        http_response_code(404);
        exit;
    }

    header('Content-Type: image/jpeg');
    echo $image['body'];
    exit;
}

function enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId)
{
    if (!$productId)
        throw new HttpException(404);

    $productDAO = new \enterprise\daos\Product();
    $product = $productDAO->get($productId);
    if (!$product) 
        throw new HttpException(404);
    $smarty->assign('product', $product);

    $tplPath = 'sites/' . $siteId . '/product_detail.tpl';
    $response = $smarty->fetch($tplPath);
    echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_output_cnzz($currentDomainSuffix);
}

/**
 * 保存询盘
 */
function enterprise_action_save_inquiry_proc($smarty, $siteId)
{
    $subject = enterprise_get_post_data('subject');
    $message = enterprise_get_post_data('message', 'trim');
    $email = enterprise_get_post_data('email');

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
            'courtesy_title' => enterprise_get_post_data('gender'),
            'company' => enterprise_get_post_data('company'),
            'tel' => enterprise_get_post_data('tel'),
            'fax' => enterprise_get_post_data('fax'),
            'website' => enterprise_get_post_data('senderwebsite'),
            'country' => enterprise_get_post_data('country'),
            'contact' => enterprise_get_post_data('name'),
            'email' => $email,
            'price_n_terms' => enterprise_get_post_data('incoterm'),
            'payment' => enterprise_get_post_data('payment'),
            'initial_order' => enterprise_get_post_data('order'),
            'sample_terms' => enterprise_get_post_data('sample'),
            'request_specifications' => enterprise_get_post_data('othersc'),
            'request_company_description' => enterprise_get_post_data('othercd'),
            'request_deliver_time' => enterprise_get_post_data('otherscdt'),
            'contact_within_24h' => enterprise_get_post_data('iscontact'),
            'email_me_updates' => enterprise_get_post_data('newsletter'),
            'site_id' => $siteId,
            'attachments' => $attachments,
            'created' => date('Y-m-d H:i:s'),
        );
    $inquiryDAO->insert($values);
    $smarty->display('inquiry_sent.tpl');
    exit(0);
}

/**
 * Router
 */
function enterprise_route($smarty, $requestPath, $siteId, $originalDomainSuffix, $currentDomainSuffix)
{
    if ($requestPath == '/contactsave.html') {
        return enterprise_action_save_inquiry_proc($smarty, $siteId);
    } elseif(preg_match('/^\/sale-new-([0-9]+)(-[a-z]+)+\.html$/', $requestPath, $matches)) {
        $productId = $matches[1];
        return enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId);
    }

    throw new HttpException(404);
}

/**
 * URL - Image
 *
 * @return string
 */
function enterprise_url_image($imageId)
{
    if (!$imageId)
        return 'media/image/no_image.png';
    return 'http://' . $_SERVER['HTTP_HOST'] . '/uploaded_images/' . $imageId . '.jpg';
}
