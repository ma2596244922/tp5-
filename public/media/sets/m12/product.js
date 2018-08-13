var c;
$(function() {
    $(".small-img ul li").click(function() {
        $(this).addClass("current");
        $(this).siblings().removeClass("current");
        c = $(this).index();
        $($(".big-img ul li")[c]).siblings().hide();
        $($(".big-img ul li")[c]).show();
    })
})
//图片翻页
$(function() {
    var page = 0;
    var $picDiv = $(".scroll");
    var picNum = $picDiv.children("ul").children("li").length;
    $(".scroll ul").css("width", 79 * picNum);
    var $pDiv_w = $(".scroll ul li").width() + 15;
    if ($picDiv.children("ul").children("li").length <= 4) {
        $(".prev-next a.prev").addClass("default");
        $(".prev-next a.next").addClass("default");
        return false;
    }
    $(".prev-next a.next").click(function() {
        page++;
        $(".prev-next a.prev").removeClass("default");
        if (page >= picNum - 4) { page = picNum - 4;
            $(this).addClass("default") };
        $picDiv.animate({ scrollLeft: $pDiv_w * page }, "normal");
    });
    $(".prev-next a.prev").click(function() {
        page--;
        if (page <= 0) { page = 0;
            $(this).addClass("default"); }
        $(".prev-next a.next").removeClass("default");
        $picDiv.animate({ scrollLeft: $pDiv_w * page }, "normal");
    });
})
$(function() {
    var page = 0;
    var $picDiv = $(".scroll1");
    var picNum = $picDiv.children("ul").children("li").length;
    $(".scroll1 ul").css("width", 52 * picNum);
    var $pDiv_w = $(".scroll1 ul li").width() + 15;
    if ($picDiv.children("ul").children("li").length <= 4) {
        $(".prev-next1 a.prev").addClass("default");
        $(".prev-next1 a.next").addClass("default");
        return false;
    }
    $(".prev-next1 a.next").click(function() {
        page++;
        $(".prev-next1 a.prev").removeClass("default");
        if (page >= picNum - 4) { page = picNum - 4;
            $(this).addClass("default") };
        $picDiv.animate({ scrollLeft: $pDiv_w * page }, "normal");
    });
    $(".prev-next1 a.prev").click(function() {
        page--;
        if (page <= 0) { page = 0;
            $(this).addClass("default"); }
        $(".prev-next1 a.next").removeClass("default");
        $picDiv.animate({ scrollLeft: $pDiv_w * page }, "normal");
    });
})

var r;
$(function() {
    $(".img-box ul li").click(function() {
        $(this).addClass("current");
        $(this).siblings().removeClass("current");
        r = $(this).index();
        $($(".big-img ul li")[r]).siblings().hide();
        $($(".big-img ul li")[r]).show();
    })
})