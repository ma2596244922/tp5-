<?php
/**
 * 项目公用函数库
 *
 * @package timandes\enterprise
 */

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

    // Upload filess
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