<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/css/swiper.min.css">
</head>
<body>
{include file="sets/m12/common/header.tpl" cur="aboutus"}
<!-- header -->

<div class="guide_wrap"><a href="/">{$preset_translations.home}</a>{$preset_translations.about_us}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
    {include file="sets/m12/common/left.tpl"}
</div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="title"><h1>{$corporation.name}</h1></div>
            <div class="cb"></div>
            <div class="photo_box">
                <div class="big_box">
                    <div class="swiper-container company-photo">
                        <div class="swiper-wrapper">
                            {foreach $photos as $photo}
                            <div class="swiper-slide"><img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" alt="{$corporation.name}" width="400" height="250" /></div>
                            {/foreach}
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                </div>
            </div>
            <div class="fram_box">
                <div class="fram_tit"><h2>{$preset_translations.company_details}</h2></div>
                <table cellpadding="0" cellspacing="0">
                    <tr><th>{$preset_translations.address}:</th><td>{$corporation.address}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.business_type}:</th><td>{$corporation.business_type}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.main_market}:</th><td>{$corporation.main_market}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.brands}:</th><td>{$corporation.brands}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.no_of_employees}:</th><td>{$corporation.no_of_employees}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.annual_sales}:</th><td>{$corporation.annual_sales}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.year_established}:</th><td>{$corporation.year_established}</td></tr>
                    <tr style="text-align: left;"><th>{$preset_translations.export_p_c}:</th><td>{$corporation.export_p_c}</td></tr>
                </table>
            </div>
            <div class="cb_10"></div>
            <div class="pro_detail">
                <div class="title"><h2>{$preset_translations.history}</h2></div>
                <div class="con_wrap">
                    {$corporation.history}
                </div>
            </div>

            <div class="cb_10"></div>
            <div class="pro_detail">
                <div class="title"><h2>{$preset_translations.service}</h2></div>
                <div class="con_wrap">
                    {$corporation.service}
                </div>
            </div>

            <div class="cb_10"></div>
            <div class="pro_detail">
                <div class="title"><h2>{$preset_translations.our_team}</h2></div>
                <div class="con_wrap">
                    {$corporation.our_team}
                </div>
            </div>

            <div class="cb_10"></div>
        </div>
        <div class="cb_10"></div>
        <div class="content_box">
            <div class="title">
                Parnter Suppliers
            </div>
            <div class="cb"></div>
            <div class="ps_wrap">
                <table cellpadding="0" cellspacing="0" width="100%">
                    {foreach $contacts as $contact}
                    <tr>
                        <th valign="top" style="border: 0;"><img src="{$corporation.logo|url:'enterprise_url_image'}" width="140" height="50"></th>
                        <td valign="top" style="border: 0;">
                            <dl>
                                <dt>{$corporation.name}</dt>
                                <dd><span>Contact Person : {$contact.name}</span><span>Telephone: {$contact.tel}</span></dd>
                            </dl>
                        </td>
                    </tr>
                    {/foreach}
                    
                </table>
            </div>
            <div class="cb"></div>
        </div>
    </div>
    <div class="cb_10"></div>
</div>

<!-- content -->
{include file="sets/m12/common/footer.tpl"}
{include file="sets/m12/common/scripts.tpl"}
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/js/swiper.min.js"></script>

<script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
      pagination: {
        clickable: true,
        el: '.swiper-pagination',
      },
    });
</script>
</body>
</html>