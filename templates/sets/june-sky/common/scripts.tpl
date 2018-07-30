<script charset="utf-8" type="text/javascript" src="https://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/qrcode.js"></script>
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/tabs.js"></script>
{if $page_name=='home'}
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/wowslider.js"></script>
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/script.js"></script>
{/if}
{if $page_name=='product'}
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/common.js"></script>
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/productdetail.js"></script>

{/if}
<script charset="utf-8" type="text/javascript" src="/media/sets/june-sky/js/theme.js?v=073003"></script>
{$site.common_fragment}
{if $site.common_bg_image}
<script type="text/javascript">
$(function() {
    $("body").css("background", "#f5f5f5 url('{$site.common_bg_image|url:'enterprise_url_image'}') center top no-repeat fixed");
})
</script>
{/if}