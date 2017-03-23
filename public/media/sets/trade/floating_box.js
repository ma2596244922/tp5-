//通用询盘篮漂浮框  2016-5-11

/*---------------------------
使用手册
1.列表页要点击的标签上添加上 data-role="产品ID"  onclick="aclick(产品ID)"
  例子：<a href="javascript:" data-role="565626" onclick="aclick(565626)">Add to My Cart</a>
2.单个要点击的标签上添加上 data-role="产品ID" class="single_an"(添加上这个class判断是否是单个产品)  onclick="aclick(产品ID)"
  例子：<a href="javascript:" data-role="565626" onclick="aclick(565626)" class="single_an">Add to My Cart</a>
---------------------------*/

$(document).ready(function() {
    var csstext = ".floating_box .title_t i,.inquiry_a .s,.inquiry_ul li .but span,.inquiry_ul li .but i.on,.shrink{background:url('/media/sets/trade/floating_pic.png') no-repeat}.floating_box{position:fixed;right:0;top:50%;width:200px;-moz-border-left-top-radius:3px;-webkit-border-radius:3px;border-radius:3px;border:1px solid #6c7c93;background:#fff}.floating_box .title{height:48px;line-height:48px;background:#6c7c93;color:#fff;text-align:center;font-size:16px;font-weight:bold}.floating_box .title_t{height:45px;line-height:45px;color:#fff;padding:0 8px;font-size:14px;background:#99a5b6;position:relative;cursor:pointer}.floating_box .title_t i{display:block;position:absolute;left:15px;top:50%;margin-top:-9px;width:18px;height:18px}.floating_box .send_an{padding:0}.floating_box .send_an a{display:block;height:40px;padding-left:40px;color:#fff}.floating_box .title_t span{position:absolute;right:10px;border:6px solid #99a5b6;border-top-color:#fff;top:50%;margin-top:-3px}.floating_box .send_an i{background-position:center 2px}.floating_box .inquiry_an i{background-position:center -17px}.floating_box .browse_an i{background-position:center -33px}.floating_box .go_top i{background-position:center -50px}.open_an{padding:5px;overflow:hidden;display:none;background:#fff}.browse_ul{padding:5px}.browse_ul li{height:25px;line-height:25px;font-size:12px;overflow:hidden}.browse_ul li a{color:#666}.browse_ul li a:hover{color:#333;text-decoration:underline}.inquiry_txt{overflow:hidden;height:375px;position:relative;margin:5px 0}.inquiry_ul{position:relative}.inquiry_ul *{overflow:hidden}.inquiry_ul li{height:75px;padding-left:70px;position:relative}.inquiry_ul li .img{width:62px;height:62px;border:1px solid #ddd;-moz-border-left-top-radius:3px;-webkit-border-radius:3px;border-radius:3px;position:absolute;left:0;top:0}.inquiry_ul li .img img{width:62px;height:62px}.inquiry_ul li .t{height:36px;line-height:18px;font-size:12px}.inquiry_ul li .t a{color:#333}.inquiry_ul li .but{height:12px;margin-top:16px;padding-right:5px}.inquiry_ul li .but i{line-height:94px;display:block;width:10px;height:10px;-moz-border-left-top-radius:3px;-webkit-border-radius:3px;border-radius:3px;border:1px solid #ccc;float:left;cursor:pointer}.inquiry_ul li .but i.on{background-position:0 -143px}.inquiry_ul li .but span{display:block;width:12px;height:12px;float:right;background-position:0 -129px;cursor:pointer}.inquiry_a{height:30px;overflow:hidden;margin-bottom:5px}.inquiry_aa{display:block;width:110px;height:30px;line-height:30px;text-align:center;float:left;overflow:hidden;color:#fff;font-size:14px;background:#6c7c93;-moz-border-left-top-radius:3px;-webkit-border-radius:3px;border-radius:3px}.inquiry_a .s{display:block;width:28px;height:28px;float:left;border:1px solid #6c7c93;overflow:hidden;-moz-border-left-top-radius:3px;-webkit-border-radius:3px;border-radius:3px;margin-left:8px;cursor:pointer}.inquiry_a .s_top{background-position:6px -67px}.inquiry_a .s_bottom{background-position:6px -94px}.inquiry_a .on_top,.inquiry_a .on_bottom{filter:alpha(opacity=50);-moz-opacity:0.5;opacity:0.5;}.open_c.on{background:#6c7c93}.floating_box .title_t .title_pa{border-top:1px solid #a6afbe; padding-left:28px; width:0; overflow:hidden}.open_c.on .title_pa{border:0}.floating_box .open_c.on span{border:6px solid #6c7c93;border-bottom-color:#fff;margin-top:-9px}.inquiry_ul li.txt{padding:0;line-height:35px;height:35px;text-align:center;font-size:16px;}.simple-intro .contact-btn a.default{cursor:default;}.simple-intro .contact-btn a.default:hover{background:#fff;border:solid 1px #6c7c93; color:#6c7c93;}.shrink{display:block; width:16px; height:95px; left:0; top:50%; margin-top:-50px;position:absolute; background-position:0 -155px;cursor:pointer; z-index:-1}";

    var style = document.createElement("style");
    style.type = "text/css";
    try {
        style.appendChild(document.createTextNode(csstext));
    } catch (ex) {
        style.styleSheet.cssText = csstext;
    }
    var ohead = document.getElementsByTagName("head")[0];
    ohead.appendChild(style);

    var count_an = $.cookie('iw_cnt');
    if (count_an == undefined) {
        count_an = 0
    };
    //创建头部 Inquiry Basket
    $(".top-product .right-list li.basket").html("");
    var a = $("<a>");
    a.attr({ href: 'javascript:' });
    a.html("<i></i>Inquiry Basket&nbsp;&nbsp;(<span id='number_top'>" + count_an + "</span>)");
    $(".top-product .right-list li.basket").append(a);


    var shop_id = $("#shop_id").val();
    //创建漂浮框结构
    var div = $("<div>");
    div.attr({ class: 'floating_box', onclick: "obtainShow()" });
    div.css({ right: -155 });
    $("body").append(div);
    /*var div=$("<div>");
	    div.attr({class:'title'});
		div.text("Contact with Supplier");
        $(".floating_box").append(div);*/
    var div = $("<div>");
    div.attr({ class: 'title_t send_an' });
    $(".floating_box").append(div);
    var a = $("<a>");
    var rightInquiryUrl = $("input[name=rightInquiryUrl]").val();
    if (rightInquiryUrl == undefined) {
        a.attr({ href: "/index.php?op=contactnow&id=" + $.base64.encode(shop_id) + "&type=2", target: '_blank', rel: "nofollow" });
    } else {
        a.attr({ href: rightInquiryUrl, target: '_blank', rel: "nofollow" });
    }
    a.css({ 'padding-left': 50 })
    a.html("<i title='Send Inquiry'></i>Send Inquiry");
    $(".send_an").append(a);
    var div = $("<div>");
    div.attr({ class: 'title_t inquiry_an open_c' });
    $(".floating_box").append(div);
    var div = $("<div>");
    div.attr({ class: 'title_pa' });
    div.html("<i title='Inquiry Basket'></i>Inquiry Basket<span></span>");
    $(".inquiry_an").append(div);
    var div = $("<div>");
    div.attr({ class: 'open_an' });
    $(".floating_box").append(div);
    var div = $("<div>");
    div.attr({ class: 'inquiry_txt' });
    $(".open_an").append(div);
    var ul = $("<ul>");
    ul.attr({ class: 'inquiry_ul' });
    $(".inquiry_txt").append(ul);
    var div = $("<div>");
    div.attr({ class: 'inquiry_a' });
    div.html("<a href='javascript:'  class='inquiry_aa'>send Inquiry</a><span class='s s_top'></span><span class='s s_bottom on_bottom'></span>");
    $(".open_an").append(div);
    var div = $("<div>");
    div.attr({ class: 'title_t browse_an open_c' });
    $(".floating_box").append(div);
    var div = $("<div>");
    div.attr({ class: 'title_pa' });
    div.html("<i title='Browse by Category'></i>Browse by Category<span></span>");
    $(".browse_an").append(div);
    var div = $("<div>");
    div.attr({ class: 'open_an' });
    $(".floating_box").append(div);
    var ul = $("<ul>");
    ul.attr({ class: 'browse_ul' });
    div.append(ul);
    var div = $("<div>");
    div.attr({ class: 'title_t go_top' });
    $(".floating_box").append(div);
    var div = $("<div>");
    div.attr({ class: 'title_pa' });
    div.html("<i title='Go To Top'></i>Go To Top");
    $(".go_top").append(div);
    var div = $("<div>");
    div.attr({ class: 'shrink' });
    div.hide();
    $(".floating_box").append(div);
    var input = $("<input>");
    input.attr({ type: "hidden", id: "delete" });
    $("body").append(input);

    //创建漂浮框结构---NED


    //返回顶部
    $(".go_top").hide();
    $(window).scroll(function() {
        top_s(); //margin-top函数
        if ($(window).scrollTop() > 300) {
            $(".go_top").fadeIn(200); //当滑动栏向下滑动时，按钮渐现的时间
        } else {
            $(".go_top").fadeOut(0); //当页面回到顶部第一屏时，按钮渐隐的时间
        }
    });
    $(".go_top").click(function() {
        $('html,body').animate({ scrollTop: '0px' }, 300); //返回顶部所用的时间 返回顶部也可调用goto()函数
    });


    //展开and隐藏
    $(".open_c").click(function() {
        $(this).toggleClass("on").siblings(".open_c").removeClass("on");
        $(this).next(".open_an").slideToggle(0).siblings(".open_an").slideUp(0);
        open_s();
        top_s();
    });


    //头部点击询盘篮展开
    $(".top-product .right-list li.basket").click(function() {
        $(".floating_box .inquiry_an").toggleClass("on").siblings(".open_c").removeClass("on");
        $(".floating_box .inquiry_an").next(".open_an").slideToggle(0).siblings(".open_an").slideUp(0);
        open_s();
        top_s();
        obtain();
        $(".floating_box").removeAttr("onclick");
    });

    $(".floating_box").hover(function() {
        $(".shrink").stop().animate({ left: -17 });
    }, function() {
        $(".shrink").stop().animate({ left: 0 });
    });

    $(".shrink").click(function() {
        $(".floating_box").animate({ right: -155 }, 600);
        $(".floating_box .title_t .title_pa").animate({ 'padding-left': 28, width: 0 }, 600);
        $(".floating_box .send_an a").animate({ 'padding-left': 50 }, 600);
        $(".open_c").removeClass("on").next(".open_an").slideUp(0);
        $(this).hide();
        top_s();
    });

    //横排列表
    $(".product-intro").each(function(index) {
        if ($(".product-intro:eq(" + index + ")").data('config') == undefined) {

        } else {
            var price = $(".product-intro:eq(" + index + ")").data('config').inquiry_basket_id;
            var supply_id = $(".product-intro:eq(" + index + ")").find(".add-basket").data('role');
            $(".product-intro:eq(" + index + ")").find(".add-basket").addClass("add-success").attr({ onclick: "dleBasketc(" + price + "," + supply_id + ")" });
        }
    });
    //竖版列表
    $(".product-img li").each(function(index) {
        if ($(".product-img li:eq(" + index + ")").data('config') == undefined) {

        } else {
            var price = $(".product-img li:eq(" + index + ")").data('config').inquiry_basket_id;
            var supply_id = $(".product-img li:eq(" + index + ")").find(".add-basket").data('role');
            $(".product-img li:eq(" + index + ")").find(".add-basket").addClass("add-success").attr({ onclick: "dleBasketc(" + price + "," + supply_id + ")" });
        }
    });

    //详情页面
    if ($(".contact-btn .single_an").data('config') == undefined) {

    } else {
        $(".contact-btn .single_an").addClass("default").removeAttr("onclick");
        $(".contact-btn .single_an").text("Added in  Cart");
    }
})

function obtainShow() {
    obtain();
    $(".floating_box").removeAttr("onclick");
}

//添加产品
function aclick(id) {
    $('[data-role=' + id + ']').removeAttr("onclick");
    var tt = Math.round(Math.random() * 10000);
    $.ajax({
        type: "POST",
        url: window.location.protocol + "//trade" + DOMAIN_SUFFIX + "/common/animal/roo.php7?op=saveToInquiryBasket&t=" + tt + "&m=" + id,
        async: true,
        dataType: "jsonp",
        success: function(data) {
            if (data == true)
                obtain();
            $(".floating_box .inquiry_an").addClass("on");
            $(".floating_box .inquiry_an").next(".open_an").slideDown(0);
            open_s();
            top_s();
            cc = [];
            $(".floating_box").removeAttr("onclick");
        }
    });
}

function obtain() { //获取数据
    var tt = Math.round(Math.random() * 10000);
    var m = $("#shop_id").val();
    $.ajax({
        type: "POST",
        url: window.location.protocol + "//trade" + DOMAIN_SUFFIX + "/common/animal/roo.php7?op=getInquiryBasket&t=" + tt + "&m=" + m,
        async: true,
        dataType: "jsonp",
        jsonpCallback: "handler",
        success: function(data) {
            $('.inquiry_ul').html("");
            $('.browse_ul').html("");
            if (data.count == 0) { //无数据
                var li = $("<li>");
                li.attr({ class: 'txt' });
                li.html("Add product");
                $(".inquiry_ul").append(li);
                $(".inquiry_a").hide();
                $("#number_top").text(0);
            } else if (data.count > 0) { //循环出数据
                var c = data.basket;
                var number = data.count;
                $("#number_top").text(number);
                /*for(var i=0;i<c.length;i++){ //询盘篮数据
                	inquiry_ul(c[i]);
                };*/
                //c.reverse();
                for (var o in c) { //询盘篮数据
                    inquiry_ul(c[o]);
                };
                inquiry_aa();
                $(".inquiry_a").show();
            }
            var s = data.category;
            for (var z in s) { //分组数据
                browse_ul(s[z]);
            };
            clickc();
            $(".inquiry_ul li .but i").click(function() {
                $(this).toggleClass("on");
                inquiry_aa();
                var $i = $(this);
                deletec($i)

            });
        }
    })
}

function deletec(de) {
    if (de.hasClass("on")) {
        //alert($i.attr("id"));
        cc.push(de.attr("id"));
    } else {
        var index = cc.indexOf(de.attr("id"));
        cc.splice(index, 1);
    };
    cc.join(",");
    $("#delete").val(cc);

}

//删除产品
function dleBasketc(id, cp_id) {
    var tt = Math.round(Math.random() * 10000);
    $.ajax({
        type: "POST",
        url: window.location.protocol + "//trade" + DOMAIN_SUFFIX + "/common/animal/roo.php7?op=delBasket&t=" + tt + "&m=" + id,
        async: true,
        dataType: "jsonp",
        success: function(data) {
            if (data == true)
                $('[data-role=' + cp_id + ']').removeClass("add-success");
            //var iid=$("#"+id).data("role");
            $('[data-role=' + cp_id + ']').attr({ onclick: "aclick(" + cp_id + ")" });
            if ($('[data-role=' + cp_id + ']').hasClass("single_an")) {
                $('[data-role=' + cp_id + ']').removeClass("default");
                $('[data-role=' + cp_id + ']').text("Add to My Cart");
            }
            $("#" + cp_id).remove();
            //var number_c=$(".inquiry_ul li").length;
            var number_c = $.cookie('iw_cnt');
            $("#number_top").text(number_c);
            if (number_c == 0) {
                var li = $("<li>");
                li.attr({ class: 'txt' });
                li.html("Add product");
                $(".inquiry_a").hide();
                $(".inquiry_ul").append(li);
                $("#number_top").text(0);
            }
            clickc();
            inquiry_aa();
            var vv = $('#' + id);
            deletec(vv)
                //obtain();
        }
    });

}

//发送询盘后清理询盘蓝数据
function afterSendingUpdateBasketc() {
    var id = $(".inquiry_aa").attr('alt');
    var idd = $("#delete").val();

    var tt = Math.round(Math.random() * 10000);
    $.ajax({
        type: "POST",
        url: window.location.protocol + "//trade" + DOMAIN_SUFFIX + "/common/animal/roo.php7?op=delBasket&t=" + tt + "&m=" + idd,
        async: true,
        dataType: "jsonp",
        success: function(data) {
            if (data == true) {

                $(".inquiry_ul li .but i.on").each(function() {
                    var cc = $(this).text();
                    $("#" + cc).remove();
                    $('[data-role=' + cc + ']').removeClass("add-success");
                    $('[data-role=' + cc + ']').attr({ onclick: "aclick(" + cc + ")" }).removeAttr("id");
                    if ($('[data-role=' + cc + ']').hasClass("single_an")) {
                        $('[data-role=' + cc + ']').removeClass("default");
                        $('[data-role=' + cc + ']').text("Add to My Cart");
                    }
                });


                //var number_c=$(".inquiry_ul li").length;
                var number_c = $.cookie('iw_cnt');
                $("#number_top").text(number_c);
                if (number_c == 0) {
                    var li = $("<li>");
                    li.attr({ class: 'txt' });
                    li.html("Add product");
                    $(".inquiry_a").hide();
                    $(".inquiry_ul").append(li);
                    $("#number_top").text(0);
                }


                clickc();

                //obtain();
            }
        }
    });

}


//询盘数据
function inquiry_ul(val) {

    if ($('[data-role=' + val.supply_id + ']').hasClass("single_an")) {
        $('[data-role=' + val.supply_id + ']').addClass("default").removeAttr("onclick");
        $('[data-role=' + val.supply_id + ']').text("Added in  Cart");
    } else {
        $('[data-role=' + val.supply_id + ']').addClass("add-success");
        $('[data-role=' + val.supply_id + ']').attr({ onclick: "dleBasketc(" + val.id + "," + val.supply_id + ")" });
    }
    var li = $("<li>");
    li.attr({ id: val.supply_id });
    $(".inquiry_ul").append(li);
    var a = $("<a>");
    a.attr({ href: val.url, class: "img", target: "_blank" });
    li.append(a);
    var img = $("<img>")
    img.attr({ src: val.pic, alt: val.caption, title: val.caption });
    a.append(img);
    var div = $("<div>");
    div.attr({ class: "t" })
    li.append(div);
    var a = $("<a>");
    a.attr({ href: val.url, title: val.caption, target: "_blank" });
    a.text(val.caption);
    div.append(a);
    var div = $("<div>");
    div.attr({ class: "but" })
    li.append(div);
    var i = $("<i>");
    i.attr({ class: "on", id: val.id });
    i.text(val.supply_id);
    div.append(i);
    cc.push(val.id);
    $("#delete").val(cc);
    var span = $("<span>");
    span.attr({ onclick: "dleBasketc(" + val.id + "," + val.supply_id + ")" });
    div.append(span);
};

//询盘蓝一些操作
function clickc() {
    //产品滚动
    //点击向上的按钮
    if ($('.inquiry_ul li').length <= 5) {
        $('.s_top').hide();
        $('.s_bottom').hide();
        $(".inquiry_txt").height("auto");
    } else {
        $('.s_top').show();
        $('.s_bottom').show();
        $(".inquiry_txt").height(375);
    }

    $('.inquiry_ul').css({ top: 0 });
    var step = $('.inquiry_ul li').height();
    $('.s_top').bind('click', function() {
            var slideInnerHeight = $('.inquiry_ul').height();
            var slideOutHeight = $('.inquiry_txt').height();
            var enableTop = slideInnerHeight - slideOutHeight;
            var aa = Math.abs(parseInt($('.inquiry_ul').css('top'))) + step;
            if ((enableTop - Math.abs(parseInt($('.inquiry_ul').css('top')))) >= step) {
                if ((enableTop - Math.abs(parseInt($('.inquiry_ul').css('top')))) == step) {
                    $('.s_top').addClass('on_top');
                }
                $('.inquiry_ul').stop().animate({ 'top': -aa }, 'fast');
                $('.s_bottom').removeClass('on_bottom');
            } else {
                $('.s_top').addClass('on_top');
                return false;
            }
        })
        //点击向下的按钮
    $('.s_bottom').bind('click', function() {
        var aa = Math.abs(parseInt($('.inquiry_ul').css('top'))) - step;
        if (Math.abs(parseInt($('.inquiry_ul').css('top'))) >= step) {
            if (Math.abs(parseInt($('.inquiry_ul').css('top'))) == step) {
                $('.s_bottom').addClass('on_bottom');
            }
            $('.inquiry_ul').stop().animate({ 'top': -aa }, 'fast');
            $('.s_top').removeClass('on_top');
        } else {
            $('.s_bottom').addClass('on_bottom');
            return false;
        }
    })

    /*//选择
    $(".inquiry_ul li .but i").click(function(){
    	$(this).toggleClass("on");
    });*/
}

//margin_top值
function top_s() {
    var margin_top = $(".floating_box").height() / 2;
    $(".floating_box").animate({ "margin-top": -margin_top }, 50);
}

//悬浮框 开合
function open_s() {
    $(".floating_box").animate({ right: 0 }, 600);
    $(".floating_box .title_t .title_pa").animate({ 'padding-left': 32, width: 152 }, 600);
    $(".floating_box .send_an a").animate({ 'padding-left': 40 }, 600);
    $(".shrink").show();
}

var cc = [];

function inquiry_aa() {
    var str = $(".inquiry_ul li .but i.on").text();
    //获得的数字串以每9个数字用","分割
    var cutStr = function(str) {
        var newStr = new Array(str.length + parseInt(str.length / 9));
        var strArray = str.split("");
        newStr[newStr.length - 1] = strArray[strArray.length - 1];
        var currentIndex = strArray.length - 1;
        for (var i = newStr.length - 1; i >= 1; i--) {
            if ((newStr.length - i) % 10 == 0) {
                newStr[i] = ",";
            } else {
                newStr[i] = strArray[currentIndex--];
            }
        }
        return newStr.join("");
    }
    $(".inquiry_aa").attr({ onclick: 'afterSendingUpdateBasketc()', alt: cutStr(str), href: "//my.trade" + DOMAIN_SUFFIX + "/index.php?op=contactnow&id=" + $.base64.encode(cutStr(str)) + "&type=1&place=detail", target: "_blank" });
};




function nothing() {
    $(".floating_box .inquiry_an").toggleClass("on").siblings(".open_c").removeClass("on");
    $(".floating_box .inquiry_an").next(".open_an").slideToggle(0).siblings(".open_an").slideUp(0);
    open_s();
    top_s();

}




//分组数据
function browse_ul(val) {
    if (val.num == 0) {

    } else {
        var li = $("<li>");
        $(".browse_ul").append(li);
        var a = $("<a>");
        li.append(a);
        a.attr({ href: val.url, rel: "nofollow" });
        a.text(val.groupname + "(" + val.num + ")");
    }
    //val.num == '0' ? ' ' :"("+val.num+")";
}
//saveToInquiryBasket() 插入数据
//getInquiryBasket() 获取数据
//delBasket() 删除单个或多个数据
//afterSendingUpdateBasket() 发送询盘后清理询盘蓝数据
//\usercenter\UsersUrl::contactNow($id,$type)($id 是多个产品用，拼接或者是单个公司id,type 产品为1，公司为2)发送询盘
