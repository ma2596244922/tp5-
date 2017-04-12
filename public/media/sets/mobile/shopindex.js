//切换
var $tab_li = $('.tab .tab_ul li');
	$tab_li.click(function(){
		$(this).addClass('current').siblings().removeClass('current');
		var index = $tab_li.index(this);
		$('.tab_box .div').eq(index).show().siblings().hide();
});


function opene(id){
	if(id==1){
		$('[data-role=txt]').addClass('auto');
		$('[data-role=text-a]').attr({"onClick":"opene(2)"}).html("Less<i></i>").addClass('x');
	}else if(id==2){
		$('[data-role=txt]').removeClass('auto');
	    $('[data-role=text-a]').attr({"onClick":"opene(1)"}).html("View more<i></i>").removeClass('x');
	}
}

var b_height=$(window).height();
var b_width=$(window).width();
var page_height=document.body.scrollHeight;
$("html,body").css({ width: b_width, overflowX: "hidden" });
$(".showCategories").click(function(){
	$(".categories").css("height",page_height).removeClass("show1").addClass("show");
	$("#opacity-layer").css({"width":b_width,"height":b_height}).fadeTo(100,0.5).show();	
	$("html,body").css({ width: b_width, overflowX: "hidden" });
	})
$(".categories dd a").click(function(){
	$(this).addClass("current");
	$(this).parent().siblings().children().removeClass("current");
	})
$("#opacity-layer,.categories dt span").click(function(){
	$(".categories").removeClass("show").addClass("show1");
	$("#opacity-layer").fadeOut(100);
	$("html,body").css({ width: "6.4rem", overflowX: "hidden" });
	})
$(".click-more p").click(function(){
		$(this).parent().hide();
		$(".spinner").show();
	})
//图片轮播
if($(".swiper-container").length>0){
	var swiper = new Swiper('.swiper-container', {
		autoplay: 5000,//可选选项，自动滑动
		pagination: '.swiper-pagination',
		paginationClickable: true,
		loop : true
	});

	}

