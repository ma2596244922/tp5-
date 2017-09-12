{include file="sets/trade/common/scripts.tpl"}
{if $site.enable_floating_widget|default:'0'};
<input type="hidden" id="input-floating-widget-url" value="{$site.floating_widget_url|default:''|escape}">
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/floating_box.js"></script>
{/if}
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/product.js?t=201707191624"></script>
{$site.common_fragment}
{if $site.common_bg_image}
<script type="text/javascript">
$(function() {
    $(".content").css("background", "#f5f5f5 url('{$site.common_bg_image|url:'enterprise_url_image'}') center top no-repeat fixed");
})
</script>
{/if}