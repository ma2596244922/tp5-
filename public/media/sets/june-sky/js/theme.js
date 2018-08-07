// JavaScript Document

resizeea();
function resizeea(){
	var cc=2000-$(window).width();
	$("#wowslider-container a.ws_next").css({right:cc/2});
	$("#wowslider-container a.ws_prev").css({left:cc/2});
}
//首页
var $tab_li = $('.tab_nws .tab-tit li');
$tab_li.hover(function(){
	$(this).addClass('now').siblings().removeClass('now');
	var index = $tab_li.index(this);
	$('div.tab-show > .tab-cont-1').eq(index).show().siblings().hide();
});

// 返回顶部
$("#back-to-top").click(function() {
	$('body,html').animate({
		scrollTop: 0
	},
	200);
	return false;
});


$(".left_nav li .t i").click(function(){
	$(this).parent(".t").toggleClass("hover");
	$(this).parent(".t").next(".txt").slideToggle()
})



$(".sideBar_top .close").click(function(){
	$(this).parent(".sideBar_top").fadeOut();

})

$(".sideBar .close").click(function(){
	$(this).toggleClass("hover");
	if($(".sideBar").attr("id")==1){
		$(this).parent(".sideBar").animate({right:0});
		$(".sideBar").attr({id:2})
	}else if($(".sideBar").attr("id")==2){
		$(this).parent(".sideBar").animate({right:-150});
		$(".sideBar").attr({id:1})
	}
})


var sl=$(".left_nav li").length;
if(sl>6){
	$(".left_nav li").each(function(index){
		if(index>5){
			$(this).hide(0)
		}
	})
	$(".left_nav .more").show()
}else{
	$(".left_nav .more").hide()
}

function opene(){
	$(".left_nav li").each(function(index){
		if(index>5){
			$(this).slideToggle(300);
			$(this).find(".t").removeClass("hover");
			$(this).find(".txt").slideUp();
		}
	})
}

$(".left_nav .more").click(function() {
	opene();
	$(this).toggleClass("hover");
	var text=$(this).find("span").text();
	if(text=="展开"){
		$(this).find("span").text("收起");
	}else if(text=="收起"){
        $(this).find("span").text("展开");
	}
});

if($("div").hasClass("owl-carousel")){
	$('#scroll').owlCarousel({
		items:4,
		autoPlay:false,
		navigation:true,
		navigationText: ["",""],
		scrollPerPage:true
	});
}


$(".details_box ul li .more").hover(function(){
	$(this).find(".txt").fadeIn()
},function(){
	$(this).find(".txt").fadeOut()
});


if($('.product_show').length > 0){
var showproduct = {
"boxid":"showbox",
"sumid":"showsum",
"boxw":400,//大图宽度,该版本中请把宽高填写成一样
"boxh":400,//大图高度,该版本中请把宽高填写成一样
"sumw":96,//列表小图每个宽度,该版本中请把宽高填写成一样
"sumh":96,//列表小图每个高度,该版本中请把宽高填写成一样
"href":1,//列表是否显示链接  0：不显示 1：显示
"sumi":12,//列表间隔
"sums":3,//列表显示个数
"sumsel":"sel",
"sumborder":2,//列表边框，没有边框填写0，边框在css中修改
"lastid":"showlast",
"nextid":"shownext"
};//参数定义	 
$.ljsGlasses.pcGlasses(showproduct);//方法调用，务必在加载完后执行

}
$('.product_h2 .e_code').on("mouseover",function(){
        $(this).find(".thumb_img").css({opacity:0})
		$(this).find(".e_code_box").stop().fadeIn()
    }).on("mouseout",function(){
        $(this).find(".thumb_img").css({opacity:1})
		$(this).find(".e_code_box").stop().fadeOut()
    });

function opena(numa,num,cid){
	if(numa>0){
		$(".album_box,.album_box .imgs-list-contact").fadeIn();
		$("body,html").css({"overflow":"hidden"});
		if(typeof(Album) != "undefined"){
			var album = new Album();
			var url = '//'+document.domain+'?action=getphotos';
			album.SetUrl(url,num,cid);
		}  
	}else{
		$(".album_box,.album_box .no_picture").fadeIn();	
	}
	
};


$(".close_i").click(function() {
	$(".album_box,.album_box .imgs-list-contact,.album_box .no_picture").fadeOut();
	$("body,html").css({"overflow":"auto"});
});


$(".hidden_group .more span").click(function() {
	var a_text=$(this).html();
    if(a_text=="see more"){
        $(".hidden_group dl").addClass("current");
        $(this).html("less");
        $(".hidden_group .more").addClass("hover");
    }else if(a_text=="less"){
        $(".hidden_group dl").removeClass("current");
        $(this).html("see more");
        $(".hidden_group .more").removeClass("hover");
    }
});

if($(".hidden_groups dd").outerHeight()<=60){
	$(".hidden_group .more").hide();
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
$(document).bind("click",function(e){
    var target  = $(e.target);
    if(target.closest('[data-role="selectParent"]').length == 0){
        $('[data-role="ListType"]').slideUp('fast');
    }
})