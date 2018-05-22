        <link rel="canonical" href="{$smarty.server.REQUEST_SCHEME}://{$canonical_host}{$smarty.server.REQUEST_URI}">
        
        {-if in_array($page_name|default:'', ['home', 'product_list','product_details']) && preg_match('/^\/products(-([0-9]+))?.html$/', $smarty.server.REQUEST_URI, $matches)!=1}
        	<link rel="amphtml" href="{$smarty.server.REQUEST_SCHEME}://{$smarty.server.HTTP_HOST}/amp{$smarty.server.REQUEST_URI}">
		{-/if}

{-if in_array($page_name|default:'', ['home', 'product_list', 'aboutus', 'news_list', 'contactus', 'keyword_list', 'product_directory'])}
    {-if $lang_code!=$default_lang_code}
        <link rel="alternate" href="http://{$default_lang_code|call:'enterprise_build_alternate_mobile_host':$site_root_domain}{$smarty.server.REQUEST_URI}" hreflang="{$default_lang_code}" />
    {-/if}
    {-foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}{if $lc==$lang_code}{continue}{/if}
        <link rel="alternate" href="http://{$lc|call:'enterprise_build_alternate_mobile_host':$site_root_domain}{$smarty.server.REQUEST_URI}" hreflang="{$lc}" />
    {-/foreach}
{-/if}
{-if $hide_site.enabled}
        <script type="text/javascript" src="/hide.php"></script>
{-/if}