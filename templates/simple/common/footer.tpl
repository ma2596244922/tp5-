<div class="footer">
    <div class="foot-inner">
        <ul>
            <li>主办单位:中国互联网新闻中心 网络传播视听节目许可证号:0105123 京ICP证 040089号</li>
            <li>版权所有 中国互联网新闻中心 中国供应商(trade.china.cn)</li>
        </ul>
    </div>
</div>
<!-- footer -->
<script type="text/javascript" src="simple/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
    $(".Left a.s3").click(function(){
        $(this).toggleClass("cur");
        $(this).next("ul").slideToggle();
    })
    $(".Left a.s11").click(function(){
        $(this).toggleClass("cur");
        $(this).next("ul").slideToggle();
    })
    $(".user-login").hover(function(){
        $(this).children("ul").slideDown("fast");
        $(this).children("i").addClass("cur");
    },function(){
        $(this).children("i").removeClass("cur");
        $(this).children("ul").hide();
    })
    var c
    $(".tab-content .tab-detail:first").show();
    $(".tab-title li").click(function(){
        $(this).addClass("cur");
        $(this).siblings().removeClass("cur");
        c =  $(this).index();
        $($(".tab-content .tab-detail")[c]).siblings().hide();
        $($(".tab-content .tab-detail")[c]).show();
    })  
})
    
</script>