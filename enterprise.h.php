<?php
/**
 * 项目公用函数库
 *
 * @package timandes\enterprise
 */

/* {{{ Common */

/**
 * 从Host中分离出语言类型和域名
 */
function enterprise_extract_locale_n_domain($host)
{
    $pslManager = new Pdp\PublicSuffixListManager();
    $parser = new Pdp\Parser($pslManager->getList());
    $hostObj = $parser->parseHost($host);

    $currentDomainSuffix = $hostObj->registerableDomain;
    $subdomain = $hostObj->subdomain;
    $locale = ($subdomain=='www'||$subdomain=='m'?'english':$hostObj->subdomain);

    return array($locale, $currentDomainSuffix);
}

/**
 * 获取站点基本信息
 */
function enterprise_extract_site_infos()
{
    global $domainInfo, $siteInfo;

    list($locale, $currentDomainSuffix) = enterprise_extract_locale_n_domain($_SERVER['HTTP_HOST']);

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
    return preg_replace('/[\s]+/', '-', enterprise_standardize_url_key($str));
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
    $urlSet = new \Thepixeldeveloper\Sitemap\Urlset(); 

    // All crawled pages
    $pageDAO = new \crawler\daos\Page();
    $curId = 0;
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

    // New groups N products
    if ($locale == 'english') {
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

                $loc = enterprise_url_product_list($group);
                $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
                $urlSet->addUrl($url);

                $productDAO = new \enterprise\daos\Product();
                $curProductId = 0;
                do {
                    $condition = "`site_id`={$siteId} AND `deleted`=0 AND `group_id`={$group['id']} AND `id`>{$curProductId}";
                    $products = $productDAO->getMultiBy($condition, $max);
                    if (!$products)
                        break;

                    foreach ($products as $product) {
                        $curProductId = max($curProductId, $product['id']);

                        $loc = enterprise_url_product($product);
                        $url = (new \Thepixeldeveloper\Sitemap\Url($loc));
                        $urlSet->addUrl($url);
                    }
                } while(true);
            }
        } while(true);
    }

    header('Content-Type: text/xml; utf-8');
    echo (new \Thepixeldeveloper\Sitemap\Output())->getOutput($urlSet);
    exit(0);
}

/**
 * 展示用户新发图片
 */
function enterprise_action_uploaded_image_proc($char, $imageId)
{
    global $thumbnailInfo;

    if (!$imageId) {
        http_response_code(400);
        exit;
    }

    if ($char) {
        if (!array_key_exists($char, $thumbnailInfo)) {
            http_response_code(404);
            exit;
        }
        $size = $thumbnailInfo[$char];
        list($w, $h) = $size;
        $field = $w . 'x' . $h;

        $thumbnailDAO = new \enterprise\daos\Thumbnail();
        $condition = "`image_id`=" . (int)$imageId;
        $thumbnail = $thumbnailDAO->getOneBy($condition);
        if (!$thumbnail) {
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

/**
 * Product Detail
 */
function enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId)
{
    if (!$productId)
        throw new HttpException(404);

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

    // Groups
    enterprise_assign_group_list($smarty, 'groups', $siteId);

    $tplPath = 'sites/' . $siteId . '/product_detail.tpl';
    $response = $smarty->fetch($tplPath);
    echo enterprise_filter_response($response, $originalDomainSuffix, $currentDomainSuffix);
    enterprise_output_cnzz($currentDomainSuffix);
}

/**
 * Product List
 */
function enterprise_action_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId, $pageNo = 1)
{
    if (!$groupId)
        throw new HttpException(404);

    $groupId = (int)$groupId;
    $pageSize = 10;
    $start = ($pageNo - 1) * $pageSize;

    // Product list
    $productDAO = new \enterprise\daos\Product();
    $condition = "`site_id`={$siteId} AND `deleted`=0 AND `group_id`={$groupId}";
    $products = $productDAO->getMultiInOrderBy($condition, '*', '`id` DESC', $pageSize, $start);
    $smarty->assign('products', $products);

    // Total products
    $totalProducts = $productDAO->countBy($condition);
    $totalPages = (int)($totalProducts / $pageSize) + (($totalProducts % $pageSize)?1:0);
    $smarty->assign('total_products', $totalProducts);
    $smarty->assign('page_size', $pageSize);
    $smarty->assign('page_no', $pageNo);
    $smarty->assign('total_pages', $totalPages);

    // Group info
    $groupDAO = new \enterprise\daos\Group();
    $group = $groupDAO->get($groupId);
    if (!$group) 
        throw new HttpException(404);
    $smarty->assign('group', $group);

    // All groups
    enterprise_assign_group_list($smarty, 'groups', $siteId);

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
    } elseif(preg_match('/^\/sale-new-([0-9]+)((-[0-9a-z]+)+)?\.html$/', $requestPath, $matches)) {
        $productId = $matches[1];
        return enterprise_action_product_detail_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $productId);
    } elseif ($requestPath == '/robots.txt') {
        return enterprise_action_robots_txt($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix);
    } elseif(preg_match('/^\/supplier-new-([0-9]+)(p([0-9]+))?((-[0-9a-z]+)+)?$/', $requestPath, $matches)) {
        $groupId = $matches[1];
        if ($matches[3])
            $pageNo = (int)$matches[3];
        else
            $pageNo = 1;
        return enterprise_action_product_list_proc($smarty, $siteId, $originalDomainSuffix, $currentDomainSuffix, $groupId, $pageNo);
    }

    throw new HttpException(404);
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
function enterprise_url_image($imageId, $productCaption = '', $imageSizeType = '')
{
    if (is_array($imageId)) {
        $retval = array();
        foreach ($imageId as $id) {
            $retval[] = enterprise_url_image($id, $productCaption, $imageSizeType);
        }
        return $retval;
    }

    if (!$imageId)
        return 'media/image/no_image.png';

    $suffix = '';
    if ($productCaption)
        $suffix = '-' . enterprise_generate_url_key($productCaption);

    return enterprise_url_prefix() . '/uploaded_images/' . $imageSizeType . $imageId . $suffix . '.jpg';
}

/**
 * URL - Product
 *
 * @return string
 */
function enterprise_url_product($product)
{
    return enterprise_url_prefix() . '/sale-new-' . $product['id'] . '-' . enterprise_generate_url_key($product['caption']) . '.html';
}

/**
 * URL - Product List
 *
 * @return string
 */
function enterprise_url_product_list($group, $pageNo = 1)
{
    $pageString = '';
    if ($pageNo > 1)
        $pageString = 'p' . $pageNo;
    return enterprise_url_prefix() . '/supplier-new-' . $group['id'] . $pageString . '-' . enterprise_generate_url_key($group['name']);
}

/* }}} */

/**
 * Assign Group List
 */
function enterprise_assign_group_list($smarty, $var, $siteId)
{
    $groupDAO = new \enterprise\daos\Group();
    $condition = "`site_id`={$siteId} AND `deleted`=0";
    $groups = $groupDAO->getMultiInOrderBy($condition);
    $smarty->assign($var, $groups);
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