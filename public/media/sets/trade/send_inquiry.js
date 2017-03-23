// JavaScript Document
//onblur
$("#username").blur(function() {
    var username = $(this);
    if ($.trim(username.val()) == '') {
        $(this).css("border-color", "#d41313");
        $("#username_error").addClass("is-visible");
        return false;
    } else if (!valideEmail(username)) {
        $("#username_error").addClass("is-visible");
        $("#username_error").text("Please enter your valid email address.");
        return false;
    } else {
        $(this).css("border-color", "#ddd");
        $("#username_error").removeClass("is-visible");
        return true;
    }
})
$("#subject").blur(function() {
    if ($.trim($(this).val()) == '') {
        $(this).css("border-color", "#d41313");
        $("#subject_error").addClass("is-visible");
        return false;
    } else if ($(this).val().length < 5) {
        $(this).css("border-color", "#d41313");
        $("#subject_error").addClass("is-visible");
        $("#subject_error").text("Please enter at least 5 characters.");
        return false;
    } else {
        $(this).css("border-color", "#ddd");
        $("#subject_error").removeClass("is-visible");
        return true;
    }
})
$("#area").blur(function() {
    if ($.trim($(this).val()) == '') {
        $("#area_error").addClass("is-visible");
        $(this).css("border-color", "#d41313");
        return false;
    } else if ($(this).val().length < 20) {
        $(this).css("border-color", "#d41313");
        $("#area_error").addClass("is-visible");
        $("#area_error").text("Your inquiry content must be between 20 to 5000 characters.");
        return false;
    } else if ($(this).val().length > 5000) {
        $(this).css("border-color", "#d41313");
        $("#area_error").addClass("is-visible");
        $("#area_error").text("Your inquiry content must be between 20 to 5000 characters.");
        return false;
    } else {
        $("#area_error").removeClass("is-visible");
        $(this).css("border-color", "#ddd");
        return true;
    }
})
$("#username").focus(function() {
    $("#username_error").removeClass("is-visible");
    $(this).css("border-color", "#ddd");
})
$("#subject").focus(function() {
    $("#subject_error").removeClass("is-visible");
    $(this).css("border-color", "#ddd");
})
$("#area").focus(function() {
        $("#area_error").removeClass("is-visible");
        $(this).css("border-color", "#ddd");
    })
    //提交
function submit() {
    $(".txt").each(function() {
        if ($(this).val() == "") {
            $(this).siblings("span").addClass("is-visible");
            $(this).css("border-color", "#d41313");
            return false;
        }
    })
    var area_value = $("#area").val();
    if (area_value == "") {
        $("#area_error").addClass("is-visible");
        $("#area").css("border-color", "#d41313");
        return false;
    }
    var subject_value = $("#subject").val();
    if (subject_value == "") {
        $("#subject_error").addClass("is-visible");
        $("#subject").css("border-color", "#d41313");
        return false;
    }
    var username = $("#username");
    if (!valideEmail(username)) {
        $("#username_error").addClass("is-visible");
        $("#username_error").text("Please enter your valid email address.");
        $("#username").css("border-color", "#d41313");
        return false;
    }

    $('#form-inquiry').submit();
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

var window_h = $(window).height();
var body_h = document.body.clientHeight;
var padding_h = (window_h - body_h) / 2 - 15;
$(".pageBody").css("padding-top", padding_h);
$("span.erro_alert").click(function() {
    $(this).removeClass("is-visible");
    $(this).siblings(".txt").css("border-color", "#ddd");
    $(this).siblings(".txt").focus();
})

function getvalue(index, number) {
    $("#selectTxt" + number).text(index);
    $("#selectMenu" + number).css("display", "none");
    $(".select-box").children("i").removeClass("current");
    if (index == "Mrs.") {
        $("#sex_hidden").val(2);
    } else {
        $("#sex_hidden").val(1);
    }

}

function boxOut(id) {
    var val_menu = $("#selectTxt1").text();
    var select_menu = $("#selectMenu1 a");
    $('#selectMenu1 a').each(function(i) {
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
})
$("#selectMenu1 a").click(function() {
    var index = $(this).text();
    $("#selectTxt1").html(index);
    $("#selectMenu1").css("display", "none");
    $(".select-box").children("i").removeClass("current");
    $("#area").val("");
    if (index == "Please select FAQ") {
        $("#area").val("");
        $("#selectHidden").val("");
        $('[data-role="isquick"]').val(0);
        return false;
    } else {
        $('[data-role="isquick"]').val(1);
    }
    $("#area").val(index);
    $("#selectHidden").val(1);
    $("#area_error").removeClass("is-visible");
    $("#area").css("border-color", "#ddd");
})
$(".slide-menu .title").click(function() {
        $(this).siblings(".slide-form").slideToggle();
        $(this).children().toggleClass("current");
    })
    //浏览器判断
    　　 var type = navigator.appName;　　
if (type == "Netscape") {　　
    var lang = navigator.language; //获取浏览器配置语言，支持非IE浏览器
    　　 } else {　　
    var lang = navigator.userLanguage; //获取浏览器配置语言，支持IE5+ == navigator.systemLanguage
    　　 };　　
var lang = lang.substr(0, 2); //获取浏览器配置语言前两位
　　
if (lang == "en") {　　 $(".main-form ul.check-list li .English").attr('checked', true);　　 };

$(".select-suppliers ul li i .check").click(function() {
    var aTxt = $(this).siblings("a.pro-title").html();
    var aHref = $(this).siblings("a.pro-title").attr("href");
    var aTitle = $(this).siblings("a.pro-title").attr("title");
    var imgURL = $(this).parent().siblings().children("img").attr("src");
    var imgAlt = $(this).parent().siblings().children("img").attr("alt");
    var numVal = $(this).attr('num');
    var clickbox = $(this).siblings("input[type='checkbox']");
    if (clickbox.is(':checked') == false) {
        $(".subject-txt").val("");
        $("li.sendTo .company").append('<dl class="edit"><dt><i>' + aTxt + '</i><span class="delete" onclick="removeDl(this)" num=' + numVal + '></span></dt><dd><a href=' + aHref + ' title=' + aTitle + ' target="_blank"><img src=' + imgURL + ' alt=' + imgAlt + ' /></a></dd></dl>');
    } else {
        $("li.sendTo .company dl span[num='" + numVal + "']").parent('dt').parent('dl').remove();
        if ($(".main-form ul li .company dl.edit").length <= 1) {
            $(".main-form ul li .company dl.edit dt span.delete").css("display", "none");
        }
    }

})
$(function() {
    if ($(".main-form ul li .company dl.edit").length <= 1) {
        $(".main-form ul li .company dl.edit dt span.delete").css("display", "none");
    }
    if ($(".main-form ul li .company dl.default").length <= 1) {
        $(".main-form ul li .company dl.default dt span.delete").css("display", "none");
    }
})

function removeDl(event) {
    if ($(".main-form ul li .company dl.edit").length > 1) {
        $(event).parent("dt").parent("dl").remove();
        var editNum = $(event).attr('num');
        $($(".select-suppliers ul li i label.check")[editNum]).siblings("input[type=checkbox]").attr('checked', false);
        if ($(".main-form ul li .company dl.edit").length <= 1) {
            $(".main-form ul li .company dl.edit dt span.delete").css("display", "none");
        }
    }
    if ($(".main-form ul li .company dl.default").length <= 1) {
        $(".main-form ul li .company dl.default dt span.delete").css("display", "none");
    }
}
