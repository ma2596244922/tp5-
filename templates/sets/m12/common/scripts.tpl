<script charset="utf-8" type="text/javascript" src="media/sets/m12/jquery.min.js"></script>
<script charset="utf-8" type="text/javascript" src="/media/sets/trade/jquery.cookie.min.js"></script> 
<script charset="utf-8" type="text/javascript" src="/media/sets/trade/jquery.base64.min.js"></script> 

<script type="text/javascript">
function SearchProducts() {
    var kw = $('#kw').val();
    if(kw) window.location.href='s-'+kw+'.html';
}
function checknum(c, b, a) {
    maxLength = c.getAttribute("maxlength");
    if (maxLength && c.value.length > maxLength) {
        c.value = c.value.substr(0, maxLength);
    } else {
        c.value = c.value.substr(0, b);
    }
    $("#" + a).html(c.value.length);
}
 function jsSubmit(b) {
 	var a = $(b).find("input[name='email']").val();
    {literal}var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$");{/literal}

    if (a.length < 3 || !reg.test(a)) {
        alert("{$preset_translations.please_enter_your_email_address}");
        return false;
    }
    

    var a = $(b).find("textarea[name='message']").val();
    if (a.length < 20 || a.length > 5000) {
        alert("{$preset_translations.your_inquiry_content_must_be_between_20_to_5000_characters}");
        return false;
    }

    return true;
}

var li_length=$(".menu-list ul li").length;
if(li_length>=10){
    $(".menu-list .see-more").css("display","block");
}
$(".menu-list .see-more a").click(function(){
    var a_text=$(this).html();
    if(a_text=="see more"){
        $(".menu-list ul").addClass("current");
        $(this).html("less");
        $(this).siblings("i").addClass("less");
    }else if(a_text=="less"){
        $(".menu-list ul").removeClass("current");
        $(this).html("see more");
        $(this).siblings("i").removeClass("less");
    }
})

var hidden_groups_length=$(".hidden_groups a").length;
if(hidden_groups_length>8){
    $(".hidden_groups_more_tr").css("display","block");
}
$(".hidden_groups_more span").click(function() {
    var a_text=$(this).html();
    if(a_text=="see more"){
        $(".hidden_groups").addClass("current");
        $(this).html("less");
        $(".hidden_groups_more").addClass("hover");
    }else if(a_text=="less"){
        $(".hidden_groups").removeClass("current");
        $(this).html("see more");
        $(".hidden_groups_more").removeClass("hover");
    }
});
</script>
{if $site.enable_floating_widget|default:'0'}
<input type="hidden" id="input-floating-widget-url" value="{$site.floating_widget_url|default:''|escape}">
<script charset="utf-8" language="javascript" type="text/javascript" src="/media/sets/trade/floating_box.js"></script>
{/if}
{$site.common_fragment}
{if $site.common_bg_image}
<script type="text/javascript">
$(function() {
    $("body").css("background", "#f5f5f5 url('{$site.common_bg_image|url:'enterprise_url_image'}') center top no-repeat fixed");
})
</script>
{/if}