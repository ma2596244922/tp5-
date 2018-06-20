//banner
if($(".slideBox").length>0){
	jQuery(".slideBox").slide({mainCell:".bd ul",effect:"leftLoop",autoPlay:true,delayTime:700});
}
//图片轮播
if($(".swiper-container").length>0){
	var swiper = new Swiper('.swiper-container', {
		autoplay: 5000,//可选选项，自动滑动
		pagination: '.swiper-pagination',
		paginationClickable: true,
		loop : true
	});
}

// 语言选择
$('[data-role="ShowParent"]').click(function(){
    var listA=$('[data-role="ListType"]').children("a");
    var val_menu = $('[data-role="SearchShow"]').html();
    $('[data-role="selectParent"]').toggleClass('current');
    $('[data-role="ListType"]').slideToggle('fast');
    listA.each(function(i) {
        var val = $(this).html();
        if (val_menu == val) {
            $(this).css("display", "none");
            $(this).siblings().css("display", "block");
        }
    });
})
$('[data-role="ListType"] a').click(function(){
	var this_val=$(this).html();
	$('[data-role="SearchShow"]').html(this_val); 
	$('[data-role="ListType"]').slideUp('fast');
})
// 验证
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
var pro_name=$("#proName").text();
if(pro_name==undefined||pro_name==""||pro_name==null){
	pro_name=$(".logo span").text();
}
$("#subject").val("Inquiry About:"+pro_name);
var pro_name=$("#proName").text();
if(pro_name==undefined||pro_name==""||pro_name==null){
	pro_name=$(".logo span").text();
}
$("#subject").val("Inquiey about:"+pro_name);
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

$(".send-btn a").click(function() {
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
    $('#form-inquiry').submit();
})


$(function() {
	var c;
    $(".small-list li").click(function() {
        $(this).addClass("current");
        $(this).siblings().removeClass("current");
        c = $(this).index();
        $($(".big-show li")[c]).siblings().hide();
        $($(".big-show li")[c]).fadeIn();
    })
})

$(".nav-inner li").hover(function(){
	$(this).children("dl").slideDown();
},function(){
	$(this).children("dl").hide();
})