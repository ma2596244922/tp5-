// JavaScript Document
$(function() {
    $(".nav li").hover(function() {
        $(this).children(".nav-list").show();
    }, function() {
        $(this).children(".nav-list").hide();
    })
})
$(".nav-list").hover(function() {
    $(this).siblings("a").addClass("current");
}, function() {
    if ($(this).parent("li").siblings().children("a").hasClass("current")) {
        $(this).siblings("a").removeClass("current");
    }
})
$(".simple-intro ul li .more-price").hover(function() {
    $(this).children("table").show();
    $(this).children("i").addClass("current");
    $(this).children("i").text("stop");
}, function() {
    $(this).children("table").hide();
    $(this).children("i").removeClass("current");
    $(this).children("i").text("more");
})
$(".right-list .tips").hover(function() {
    $(this).children("em").show();
}, function() {
    $(this).children("em").hide();
})

function getvalue(index, number) {
    $("#selectTxt" + number).text(index);
    $("#selectMenu" + number).css("display", "none");
    $(".select-box").children("i").removeClass("current");
}
$("#selectMenu2 a").click(function() {
    var index = $(this).text();
    $("#selectTxt2").html(index);
    $("#selectMenu2").css("display", "none");
    $(".select-box").children("i").removeClass("current");
    $(".area-li .area").val("");
    if (index == "Quick question") {
        $(".area-li .area").val("");
        $('[data-role="isquick"]').val(0);
        return false;
    } else {
        $('[data-role="isquick"]').val(1);
    }
    $(".area-li .area").val(index);
    $("#area-error").css("display", "none");
    $(".area-li .area").css("border-color", "#ddd");
})

function boxOut(id) {
    var val_menu = $("#selectTxt" + id).text();
    var select_menu = $(".selectMenu a");
    $('.selectMenu a').each(function(i) {
        var val = $(this).text();
        if (val_menu == val) {
            $(this).css("display", "none");
            $(this).siblings().css("display", "block");
        }
    });
    $("#selectMenu" + id).slideToggle('fast');
    $(".select-box").children("i").toggleClass("current");
}
$(document).bind("click", function(e) {
    var target = $(e.target);
    if (target.closest("li.select").length == 0) {
        $("li.select .selectMenu").css("display", "none");
        $(".select-box").children("i").removeClass("current");
    }
    if (target.closest("li.select-li").length == 0) {
        $("li.select-li .selectMenu").css("display", "none");
        $(".select-box").children("i").removeClass("current");
    }
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

//导航固定
$(function() {
    var offsetTop = $(".nav").offset().top;
    $(window).scroll(function(e) {
        if ($(window).scrollTop() > offsetTop) {
            $(".nav-fixed").show();
        } else {
            $(".nav-fixed").hide();
        }
    });
});

//大图页所需js
var t;
$(function() {
    $(".small-box ul li").click(function() {
        $(this).addClass("current");
        $(this).siblings().removeClass("current");
        t = $(this).index();
        $($(".big-box ul li")[t]).siblings().hide();
        $($(".big-box ul li")[t]).show();
    })
})

//图片翻页
$(function() {
    var page_img = 1;
    var $p_Div = $(".scrollArea");
    var $picDiv = $(".img-list");
    var picNum = $picDiv.children("ul").children("li").length;
    $(".img-list ul").css("height", 213 * picNum);
    var page_count = Math.ceil(picNum / 3);
    var $pDiv_h = $p_Div.height();
    $(".next-btn a.next").click(function() {
        if (page_count > page_img) {

            $picDiv.animate({ top: '-' + page_img * $pDiv_h + "px" }, 1200);
            page_img++;
        }
    });
    $(".next-btn a.prev").click(function() {
        if (page_img > 1) {

            $picDiv.animate({ top: "+=" + $pDiv_h + 'px' }, 1200);
            page_img--;
        }
    });
})
$(function() {
    $(".product-box ul li").hover(function() {
        if ($(this).children("a.add-basket").hasClass("add-success")) {
            $(this).children("a.add-basket").addClass("delete");
        } else {
            $(this).children("a.add-basket").addClass("current");
        }
        $(this).children("span.img-box").addClass("current");
        $(this).children("a.img-box").addClass("current");
        $(this).children("dl").show();
    }, function() {
        $(this).children("a.img-box").removeClass("current");
        $(this).children("span.img-box").removeClass("current");
        $(this).children("a.add-basket").removeClass("delete");
        $(this).children("a.add-basket").removeClass("current");
        $(this).children("dl").hide();
    })
    $(".product-box ul li a.add-basket").click(function() {
        if ($(this).hasClass("delete")) {
            $(this).removeClass("delete");
            $(this).removeClass("add-success");
            $(this).addClass("current");
        } else { $(this).addClass("delete"); }
    })
})
$(function() {
    $(".product-intro .left-img").hover(function() {
        if ($(this).children(".add-basket").hasClass("add-success")) {
            $(this).children(".add-basket").addClass("delete");
        } else {
            $(this).children(".add-basket").addClass("current");
        }
    }, function() {
        $(this).children(".add-basket").removeClass("current");
        $(this).children(".add-basket").removeClass("delete");
    })
    $(".product-intro .left-img a.add-basket").click(function() {
        if ($(this).hasClass("delete")) {
            $(this).removeClass("delete");
            $(this).addClass("current");
            $(this).removeClass("add-success");
        } else { $(this).addClass("delete"); }
    })
})

//企业介绍图片轮播
function banner() {
    var bn_id = 0;
    var bn_id2 = 1;
    var speed33 = 5000;
    var qhjg = 1;
    var MyMar33;
    $("#scrollArea .c1").hide();
    $("#scrollArea .c1").eq(0).fadeIn("slow");
    if ($("#scrollArea .c1").length > 1) {
        $("#small-list li").eq(0).addClass("current");

        function Marquee33() {
            bn_id2 = bn_id + 1;
            if (bn_id2 > $("#scrollArea .c1").length - 1) {
                bn_id2 = 0;
            }
            $("#scrollArea .c1").eq(bn_id).css("z-index", "2");
            $("#scrollArea .c1").eq(bn_id2).css("z-index", "1");
            $("#scrollArea .c1").eq(bn_id2).show();
            $("#scrollArea .c1").eq(bn_id).fadeOut("slow");
            $("#small-list li").removeClass("current");
            $("#small-list li").eq(bn_id2).addClass("current");
            bn_id = bn_id2;
        };

        MyMar33 = setInterval(Marquee33, speed33);

        $("#small-list li").click(function() {
            var bn_id3 = $("#small-list li").index(this);
            if (bn_id3 != bn_id && qhjg == 1) {
                qhjg = 0;
                $("#scrollArea .c1").eq(bn_id).css("z-index", "2");
                $("#scrollArea .c1").eq(bn_id3).css("z-index", "1");
                $("#scrollArea .c1").eq(bn_id3).show();
                $("#scrollArea .c1").eq(bn_id).fadeOut("slow", function() { qhjg = 1; });
                $("#small-list li").removeClass("current");
                $("#small-list li").eq(bn_id3).addClass("current");
                bn_id = bn_id3;
            }
        })
        $("#small-list").hover(
            function() {
                clearInterval(MyMar33);
            },
            function() {
                MyMar33 = setInterval(Marquee33, speed33);
            }
        )
    } else {
        $("#small-list").hide();
    }
}

banner()

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
    var page_img = 1;
    var $p_Div = $(".scroll-list");
    var $picDiv = $(".small-box");
    var picNum = $picDiv.children("ul").children("li").length;
    $(".small-box ul").css("width", 80 * picNum);
    var page_count = Math.ceil(picNum / 8);
    var $pDiv_w = $p_Div.width();
    $("a.next").click(function() {
        if (page_count > page_img) {
            $picDiv.animate({ left: '-' + page_img * $pDiv_w + "px" }, 1200);
            page_img++;
        }
    });
    $("a.prev").click(function() {
        if (page_img > 1) {
            $picDiv.animate({ left: "+=" + $pDiv_w + 'px' }, 1200);
            page_img--;
        }
    });
})

function valideEmail(objName) {
    var i, strDomain, cChar;
    var nDotCount = 0;
    var bFindAlpha = false;
    var bLastIsDot = false;
    var strValid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.";
    var value = objName.val();

    if (value == "") return true;
    i = value.indexOf("@");
    if (i == -1 || i == 0 || i == value.length - 1) return false;
    strDomain = value.substring(i + 1, value.length);

    if (strDomain.indexOf("@") != -1) return false;
    if (strDomain.charAt(0) == ".") return false;
    if (strDomain.charAt(strDomain.length - 1) == ".") return false;
    for (i = 0; i < strDomain.length; i++) {
        cChar = strDomain.charAt(i);
        if (strValid.indexOf(cChar) == -1) return false;
        if (cChar == ".") {
            if (bLastIsDot) return false;
            bLastIsDot = true;
            nDotCount++;
        } else bLastIsDot = false;
        if ((("a" <= cChar) && (cChar <= "z")) || (("A" <= cChar) && (cChar <= "Z")))
            bFindAlpha = true;
    }
    if (bFindAlpha && (0 == nDotCount)) return false;
    var pa = /^[A-Za-z0-9]+([A-Za-z0-9-_.]+[A-Za-z0-9]+)*@([A-Za-z0-9]+[-.])+[A-Za-z0-9]{2,5}$/;
    // /^(?:\w+\.?)*-?\w+@(?:-?\w+\.?)*\w+$/;
    if (!pa.test(value)) {
        return false;
    }
    return true;
}
$("#email").blur(function() {
    var username = $(this);
    if (username.val() == "") {
        $("#email-error").css("display", "block");
        $(this).css("border-color", "#d55c5c");
        return false;
    } else if (!valideEmail(username)) {
        $("#email-error").css("display", "block");
        $(this).css("border-color", "#d55c5c");
        return false;
    } else {
        $("#email-error").css("display", "none");
        $(this).css("border-color", "#ddd");
        return true;
    }
})
$("#subject").blur(function() {
    var username = $(this);
    if (username.val() == "") {
        $("#subject-error").css("display", "block");
        $(this).css("border-color", "#d55c5c");
        return false;
    } else {
        $("#subject-error").css("display", "none");
        $(this).css("border-color", "#ddd");
        return true;
    }
})
$("#area").blur(function() {
    var username = $(this);
    var username = $("#area");
    if (username.val() == "") {
        $("#area-error").css("display", "block");
        $(this).css("border-color", "#d55c5c");
        return false;
    } else {
        $("#area-error").css("display", "none");
        $(this).css("border-color", "#ddd");
        return true;
    }
})
$(".send-btn").click(function() {
    $(".txt1").each(function() {
        if ($(this).val() == "") {
            $(this).siblings("span").css("display", "block");
            $(this).css("border-color", "#d41313");
            return false;
        }
    })
    var area_value = $("#area").val();
    if (area_value == "") {
        $("#area-error").css("display", "block");
        $("#area").css("border-color", "#d41313");
        return false;
    }
    var username = $("#email");
    if (!valideEmail(username)) {
        $("#email-error").css("display", "block");
        $(this).css("border-color", "#d41313");
        return false;
    }
})
$(".search-product div:last-child").css("border", "none");
$(".news-art div:last-child").css("border", "none");
$(function() {
    $(".product-box ul li").each(function() {
        var price = $(this).children("dl").children("dd.price_dd").html();
        if (price == undefined) {
            return false;
        }
        var price_le = price.length;
        if (price_le > 30) {
            price = price.replace(/USD/g, "");
            $(this).children("dl").children("dd.price_dd").html(price);
        }
    })
})

$(function() {
    var url = window.location.search;
    if (url == "") {
        return false;
    }
    var key = url.split("?")[1].split("=")[0];
    if (key == "keyword") {
        var letter = url.substring(9);
        var space = letter.indexOf(" ").length;
        if (space != -1) {}
        $("#search_shop").val(letter);
        $("#selectTxt5").text("On Site");
    }

})
$(".view-page .view .view-li a").click(function() {
    var link_url = $(this).attr("data-url");
    if (typeof(link_url) == 'undefined') {
        return false;
    } else {
        window.location = link_url;
    }
})
$(".view-page .select-li .selectMenu a").click(function() {
    var link_url = $(this).attr("data-url");
    window.location = link_url;
})

var ul_length = $("#tabs-list ul").length;
if (ul_length > 1) {
    $("#tabs-new").show();
} else {
    $("#tabs-new").hide();
}
var r;
$(function() {
    $("#tabs-list ul:first").show();
    $("#tabs-new a").click(function() {
        $(this).addClass("current");
        $(this).siblings().removeClass("current");
        r = $(this).index();
        $($("#tabs-list ul")[r]).siblings().hide();
        $($("#tabs-list ul")[r]).show();
    })
})

function showBox() {
    var b_height = $(window).height();
    var b_width = $(window).width();
    var scollTop = $(document).scrollTop();
    var objLeft = (b_width - $("#float-layer").width()) / 2;
	var objTop = (b_height - $("#float-layer").height()) / 2;
	$("#float-layer").css({
		left:objLeft + "px",
		top:objTop + "px"
	});		
    $("#float-layer").show();
    $("#opacity-layer").css({ "width": b_width, "height": b_height }).fadeTo(100, 0.8).show();
}
$(".close_btn").click(function() {
    $("#float-layer").hide();
    $("#opacity-layer").fadeOut(100);
})
$("#username").focus(function() {
    $("#username_error").removeClass("is-visible");
    $(this).css("border-color", "#ddd");
})
$("#area1").focus(function() {
    $("#area_error").removeClass("is-visible");
    $(this).css("border-color", "#ddd");
})
$("span.erro_alert").click(function() {
        $(this).removeClass("is-visible");
        $(this).siblings(".txt").css("border-color", "#ddd");
        $(this).siblings(".txt").focus();
        $(this).siblings(".area").css("border-color", "#ddd");
        $(this).siblings(".area").focus();
    })
    //提交

function submit() {
    $(".txt").each(function() {
        if ($(this).val() == "") {
            $(this).siblings("span").addClass("is-visible");
            $(this).css("border-color", "#d41313");
        } else {
            $(this).siblings("span").removeClass("is-visible");
            $(this).css("border-color", "#ddd");
        }
    })
    $(".area").each(function() {
        if ($(this).val() == "") {
            $(this).siblings("span").addClass("is-visible");
            $(this).css("border-color", "#d41313");
        } else {
            $(this).siblings("span").removeClass("is-visible");
            $(this).css("border-color", "#ddd");
        }
    })
    var username = $("#username");
    if ($.trim(username.val()) == '') {
        $("#username_error").addClass("is-visible");
        username.css("border-color", "#d41313");
        return false;
    } else if (!valideEmail(username)) {
        $("#username_error").text("Please enter your valid email address.");
        $("#username_error").addClass("is-visible");
        username.css("border-color", "#d41313");
        return false;
    }
    var area = $("#area1");
    if ($.trim(area.val()) == '') {
        area.css("border-color", "#d41313");
        $("#area_error").addClass("is-visible");
        return false;
    } else if (area.val().length < 20) {
        area.css("border-color", "#d41313");
        $("#area_error").addClass("is-visible");
        $("#area_error").text("Your inquiry content must be between 20 to 5000 characters.")
        return false;
    } else if (area.val().length > 5000) {
        area.css("border-color", "#d41313");
        $("#area_error").addClass("is-visible");
        $("#area_error").text("Your inquiry content must be between 20 to 5000 characters.")
        return false;
    }
}

function valideEmail(objName) {
    var i, strDomain, cChar;
    var nDotCount = 0;
    var bFindAlpha = false;
    var bLastIsDot = false;
    var strValid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.";
    var value = objName.val();

    if (value == "") return true;
    i = value.indexOf("@");
    if (i == -1 || i == 0 || i == value.length - 1) return false;
    strDomain = value.substring(i + 1, value.length);

    if (strDomain.indexOf("@") != -1) return false;
    if (strDomain.charAt(0) == ".") return false;
    if (strDomain.charAt(strDomain.length - 1) == ".") return false;
    for (i = 0; i < strDomain.length; i++) {
        cChar = strDomain.charAt(i);
        if (strValid.indexOf(cChar) == -1) return false;
        if (cChar == ".") {
            if (bLastIsDot) return false;
            bLastIsDot = true;
            nDotCount++;
        } else bLastIsDot = false;
        if ((("a" <= cChar) && (cChar <= "z")) || (("A" <= cChar) && (cChar <= "Z")))
            bFindAlpha = true;
    }
    if (bFindAlpha && (0 == nDotCount)) return false;
    var pa = /^[A-Za-z0-9]+([A-Za-z0-9-_.]+[A-Za-z0-9]+)*@([A-Za-z0-9]+[-.])+[A-Za-z0-9]{2,5}$/;
    // /^(?:\w+\.?)*-?\w+@(?:-?\w+\.?)*\w+$/;
    if (!pa.test(value)) {
        return false;
    }
    return true;
}
