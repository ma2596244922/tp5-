<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    {$site.common_head_fragment}
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/trade/common/definitions.tpl" page_name="home"}
    {include file="sets/m12/common/styles.tpl"}
    <link href="/media/sets/m12/css/cmopany_detail.css" rel="stylesheet" type="text/css" />
</head>
<body>
{include file="sets/m12/common/header.tpl" cur="contactus"}
<!-- header -->
<div class="guide_wrap"><a href="#">{$preset_translations.home}</a>{$preset_translations.contact_us}</div>
<div class="main_wrap">
    <div class="sider_wrap fl">
    {include file="sets/m12/common/left.tpl"}
</div>
    <div class="content_wrap">
        <div class="content_box">
            <div class="title">{$corporation.name}</div>
            <div class="cb"></div>
            <div class="contact_wrap">
                <table cellspacing="0" cellpadding="0" border="0" width="100%" style="background: #F1F1F1;border-collapse: collapse;">
                    <tbody>
                        <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.address} : </th><td style="text-align:left;"> {$corporation.address}</td></tr>

                        <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.worktime} : </th><td style="text-align:left;">{$corporation.worktime}</td></tr>

                        <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.business_phone} : </th><td style="text-align:left;"> <h1>{$corporation.tel_wt}({$preset_translations.working_time})</h1></td></tr>

                        <tr style="text-align:right;"><th valign="Top" nowrap="nowrap" style="width:120px;">{$preset_translations.fax} : </th><td style="text-align:left;"> {$corporation.fax}</td></tr>
                    </tbody>
                </table>
                <div class="cb_10"></div>
            </div>
            <div class="cb"></div>
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

</body>
</html>