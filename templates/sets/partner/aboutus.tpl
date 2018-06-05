
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$lang_code}"{$html_attr_dir}>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}">
    <meta name="description" content="{$description|escape}">
    {include file="sets/partner/common/styles.tpl"}
</head>
<body>
{include file="sets/partner/common/header.tpl"}
<!-- header -->
{include file="sets/partner/common/navbar.tpl"}
<!-- nav -->
{include file="sets/partner/common/banner.tpl"}
<!-- banner -->
<div class="content fl-clr">
    <div class="left-content">
        <div class="company-intro">
            <div class="company-img">
                {foreach $photos as $photo}
                <img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" title="{$preset_translations.company_profile}" alt="{$preset_translations.company_profile}" />
                {/foreach}
            </div>
            <div class="intro-box">
                <h1>{$preset_translations.company_profile}</h1>
                <p>{$preset_translations.company_details}</p>
            </div>
            <div class="intro-box">
                <span>Company Details</span>
                <ul>
                    <li>{$preset_translations.business_type}:{$corporation.business_type}</li>
                    <li>{$preset_translations.main_market}:{$corporation.main_market}</li>
                    <li>{$preset_translations.brands}:{$corporation.brands}</li>
                    <li>{$preset_translations.no_of_employees}:{$corporation.no_of_employees}</li>
                    <li>{$preset_translations.annual_sales}:{$corporation.annual_sales}</li>
                    <li>{$preset_translations.year_established}:{$corporation.year_established}</li>
                    <li>{$preset_translations.export_p_c}:{$corporation.export_p_c}</li>
                </ul>
            </div>
            <div class="intro-box">
                <span>Company History</span>
                <p>{$corporation.history}</p>
            </div>
            {include file="sets/partner/common/send_msg.tpl"}
        </div>
    </div>
    <!-- left-content -->
    {include file="sets/partner/common/right_list.tpl"}
    <!-- right-list -->
</div>
<!-- content -->
{include file="sets/partner/common/footer.tpl"}

{include file="sets/partner/common/scripts.tpl"}
</body>
</html>