// JavaScript Document
//图片轮播
function banner(){	
	var bn_id = 0;
	var bn_id2= 1;
	var speed33=5000;
	var qhjg = 1;
    var MyMar33;
	$("#banner .d1").hide();
	$("#banner .d1").eq(0).fadeIn("slow");
	if($("#banner .d1").length>1)
	{
		$("#banner_id li").eq(0).addClass("nuw");
		function Marquee33(){
			bn_id2 = bn_id+1;
			if(bn_id2>$("#banner .d1").length-1)
			{
				bn_id2 = 0;
			}
			$("#banner .d1").eq(bn_id).css("z-index","2");
			$("#banner .d1").eq(bn_id2).css("z-index","1");
			$("#banner .d1").eq(bn_id2).show();
			$("#banner .d1").eq(bn_id).fadeOut("slow");
			$("#banner_id li").removeClass("current");
			$("#banner_id li").eq(bn_id2).addClass("current");
			bn_id=bn_id2;
		};
	
		MyMar33=setInterval(Marquee33,speed33);
		
		$("#banner_id li").click(function(){
			var bn_id3 = $("#banner_id li").index(this);
			if(bn_id3!=bn_id&&qhjg==1)
			{
				qhjg = 0;
				$("#banner .d1").eq(bn_id).css("z-index","2");
				$("#banner .d1").eq(bn_id3).css("z-index","1");
				$("#banner .d1").eq(bn_id3).show();
				$("#banner .d1").eq(bn_id).fadeOut("slow",function(){qhjg = 1;});
				$("#banner_id li").removeClass("current");
				$("#banner_id li").eq(bn_id3).addClass("current");
				bn_id=bn_id3;
			}
		})
		$("#banner_id").hover(
			function(){
				clearInterval(MyMar33);
			}
			,
			function(){
				MyMar33=setInterval(Marquee33,speed33);
			}
		)	
	}
	else
	{
		$("#banner_id").hide();
	}
}

banner()

//图片翻页
$(function(){ 
	var page=1;
	var $p_Div=$(".scroll-list");
	var $picDiv=$(".scroll-box");
	var picNum=$picDiv.children("ul").children("li").length;
	$(".scroll-box ul").css("width",200*picNum);
	var page_count=Math.ceil(picNum/5);
	var $pDiv_w=$p_Div.width();
	$(".prev-next .next").click(function(){
		if(page_count>page){
			$picDiv.animate({left:'-'+page*$pDiv_w+"px"},900);
			page++;
			$(".prev-next a.prev").removeClass("default");
			if(page>=page_count){
				$(this).addClass("default");
			}else{
				$(this).removeClass("default");
			}
		} 
	});
	
	$(".prev-next .prev").click(function(){
		if(page>1){
			$picDiv.animate({left:"+="+$pDiv_w+'px'},900);
			page--;
			$(".prev-next a.next").removeClass("default");
			if(page<=1){
				$(this).addClass("default");
			}else{
				$(this).removeClass("default");
			}
		}
	});
	
})

var c
$(function(){
   $(".tabContent .detail:first").show();
   $(".tab-title li").click(function(){
       $(this).addClass("current");
	   $(this).siblings().removeClass("current");
	   c =  $(this).index();
	   $($(".tabContent .detail")[c]).siblings().hide();
	   $($(".tabContent .detail")[c]).fadeIn(300);
   })  
})

$(".nav li").hover(function(){
		$(this).children(".nav-list").show();
		},function(){
		$(this).children(".nav-list").hide();
			})

$(".nav-list").hover(function(){
	$(this).siblings("a").addClass("current");
	},function(){
		if($(this).parent("li").siblings().children("a").hasClass("current")){
			$(this).siblings("a").removeClass("current");
			}
		})
		
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
    if ($.trim(area.val()) == ''){
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

$("#send-email").blur(function() {
    var username = $(this);
    if (username.val() == "") {
        $("#send-error").css("display", "block");
        return false;
    } else if (!valideEmail(username)) {
        $("#send-error").css("display", "block");
        return false;
    } else {
        $("#send-error").css("display", "none");
        return true;
    }
})
$("#send-btn").click(function(){
	var username = $("#send-email");
    if (username.val() == "") {
        $("#send-error").css("display", "block");
        return false;
    } else if (!valideEmail(username)) {
        $("#send-error").css("display", "block");
        return false;
    } else {
        $("#send-error").css("display", "none");
        return true;
    }
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

$("#sendNow").click(function(){
	var username=$("#email-user");
	if ($.trim(username.val()) == '') {
		$("#email-error1").text("Enter Error");
        $("#email-error1").addClass("is-visible");
        username.css("border-color", "#d41313");
        return false;
    } else if (!valideEmail(username)) {
        $("#email-error1").text("Enter Error");
        $("#email-error1").addClass("is-visible");
        username.css("border-color", "#d41313");
        return false;
    }
	var area = $("#area-user");
    if ($.trim(area.val()) == ''){
        area.css("border-color", "#d41313");
        $("#area-error1").addClass("is-visible");
		$("#area-error1").text("Your inquiry content must be between 20 to 5000 characters.")
        return false;
    } else if (area.val().length < 20) {
        area.css("border-color", "#d41313");
        $("#area-error1").addClass("is-visible");
        $("#area-error1").text("Your inquiry content must be between 20 to 5000 characters.")
        return false;
    } else if (area.val().length > 5000) {
        area.css("border-color", "#d41313");
        $("#area-error1").addClass("is-visible");
        $("#area-error1").text("Your inquiry content must be between 20 to 5000 characters.")
        return false;
    }
	})
$("#email-user").focus(function(){
	$("#email-error1").removeClass("is-visible");
	$(this).css("border-color","#ddd");
	})
$("#area-user").focus(function(){
	$("#area-error1").removeClass("is-visible");
	$(this).css("border-color","#ddd");
	})
	
//首页图片翻页
$(function(){ 
	var page=1;
	var $p_Div=$(".scroll-list1");
	var $picDiv=$(".sell-list");
	var picNum=$picDiv.children("ul").children("li").length;
	$(".sell-list ul").css("width",200*picNum);
	var page_count=Math.ceil(picNum/5);
	var $pDiv_w=$p_Div.width();
	$(".prev-next1 .next").click(function(){
		if(page_count>page){
			$picDiv.animate({left:'-'+page*$pDiv_w+"px"},900);
			page++;
			$(".prev-next1 a.prev").removeClass("default");
			if(page>=page_count){
				$(this).addClass("default");
			}else{
				$(this).removeClass("default");
			}
		} 
	});
	
	$(".prev-next1 .prev").click(function(){
		if(page>1){
			$picDiv.animate({left:"+="+$pDiv_w+'px'},900);
			page--;
			$(".prev-next1 a.next").removeClass("default");
			if(page<=1){
				$(this).addClass("default");
			}else{
				$(this).removeClass("default");
			}
		}
	});
})

$("#search-a").click(function(){
	$(this).siblings(".search-top").css("display","inline-block");
	})

var li_length=$(".popular-search ul li").length;
if(li_length>15){
	$(".popular-search .slide-more").css("display","block");
	$(".popular-search ul").css("margin","15px 0 28px 0");
	}
$(".popular-search .slide-more a,.recom-product .slide-more a").click(function(){
	var a_text=$(this).html();
	if(a_text=="More"){
		$(this).parent().siblings("ul").addClass("cur");
		$(this).html("Less");
		$(this).siblings("i").addClass("less");
		}else if(a_text=="Less"){
			$(this).parent().siblings("ul").removeClass("cur");
			$(this).html("More");
			$(this).siblings("i").removeClass("less");
			}
})

var c;
$(function(){
   $(".tab-content .tab-detail:first").show();
   $(".tab-title li").click(function(){
       $(this).addClass("current");
	   $(this).siblings().removeClass("current");
	   c =  $(this).index();
	   $($(".tab-content .tab-detail")[c]).siblings().hide();
	   $($(".tab-content .tab-detail")[c]).fadeIn("fast");
   })  
})
$(".high-quality ul li:first-child").css("width","436px");
$(".high-quality ul li").hover(function(){
	var li_index = $(this).index();
	$(this).stop().animate({width:436},300);
	$(this).siblings().stop().animate({width:180},300);
})

$('[data-role="send-now"]').click(function(){
	var email_txt=$('[data-role="email"]');
	var email_val=$('[data-role="email"]').val();
	if(email_val==''){
		$('[data-role="email_error"]').addClass("is-visible").text("Please enter your email address.");
		return false;
	}else if(!valideEmail(email_txt)){
		$('[data-role="email_error"]').addClass("is-visible").text("Please enter your valid email address.");
		return false;
	}
	$("form").submit();
})
$('[data-role="email"]').focus(function(){
	$('[data-role="email_error"]').removeClass("is-visible");
	})

var c
$(function(){
   $('[data-role="update-list"] ul:first').show();
   $('[data-role="update-title"] li').click(function(){
       $(this).addClass("cur");
	   $(this).siblings().removeClass("cur");
	   c =  $(this).index();
	   $($('[data-role="update-list"] ul')[c]).siblings().hide();
	   $($('[data-role="update-list"] ul')[c]).show();
   })  
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