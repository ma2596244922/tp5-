{include file="sets/trade/common/scripts.tpl"}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/product.js"></script>
{$site.common_fragment}
{if $site.common_bg_image}
<script type="text/javascript">
$(function() {
    $(".content").css("background", "#f5f5f5 url('{$site.common_bg_image|url:'enterprise_url_image'}') center top no-repeat");
})
</script>
{/if}