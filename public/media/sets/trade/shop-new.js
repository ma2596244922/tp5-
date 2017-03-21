// JavaScript Document//图片轮播
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

function searchInner(){
    var searchInner =$("#search-inner");
	var searchInner_value = $.trim(searchInner.val());
	if(searchInner_value==''){
		alert("Please input information in english only!");
            return false;
	} else if (!valideChinese(searchInner)) {
        alert("Please input information in english only!");
        return false;
    }
	}
	
//非中文验证
function valideChinese(objName) {
    var reg = /[\u4e00-\u9fa5]+/;
    var searchPro = objName.val();
    if (reg.test(searchPro)) {
        return false;
    } else {
        return true;
    }
}

$(".all-categories ul li").hover(function(){
	$(this).children("span").css("display","block");
	},function(){
		$(this).children("span").css("display","none");
		})
