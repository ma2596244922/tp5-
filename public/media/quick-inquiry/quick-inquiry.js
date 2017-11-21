// JavaScript Document
function show_inquiry(){
	var b_height=$(window).height();
	var b_width=$(window).width();
	var scollTop = $(document).scrollTop();
	var objLeft = (b_width - $("#float-layer2").width()) / 2;
	var objTop = (b_height - $("#float-layer2").height()) / 2;
	$("#float-layer2").css({
		left:objLeft + "px",
		top:objTop + "px"
	});
	$("#float-layer2").show();
	$("#opacity-layer").css({"width":b_width,"height":"100%"}).fadeTo(100,0.8).show();
	var corpid=$("#shop_id").val();
	var groupid=$("#groupid").val();
	var $corpname = $('.content .container .header a').attr('title');
	var $corpde = $('.main-content .right-content .product-box ul.product-img li span:first-child');
	var $proname = $corpde.find('a:first-child').attr('title');
	var $prod_img = $corpde.find('a:first-child').children('img').attr('src');
	var $prise = $corpde.parent().find('.price_dd').html().slice(11);
	var $minorder = $corpde.parent().find('dd:last-child').html().slice(11);
	var $prod_id = $corpde.siblings('a').data('role');
    
	var _host= document.domain;
	console.log(_host);

	var _new_host ="";
    
	if(_host.indexOf("en"+DOMAIN_SUFFIX)!=-1)
	{
		var _new_host =window.location.protocol + "//en" +DOMAIN_SUFFIX;
		var isdetail = _host.slice(0, -12);
	}
	if (isdetail == 'detail') {
		$.ajax({
		type: "GET",
		dataType: 'json',
		url: _new_host + '/common/animal/Apigroup.php?op=GetSupplyByGroupid&corpid='+corpid+'&groupid='+groupid,
		success: function (data) {
				var strData=data.res;
				var strHtml ='';
				if(data.code==20){
					for(var i=0;i<strData.length;i++){
						if(strData[i].exprops.length>1){
							strHtml+='<div class="pro-scroll"><div class="pro-title"><span>'+strData[i].caption+'</span><i>'+strData[i].corpname+'</i></div><div class="product-show"><img src='+strData[i].pic+' /><ul><li><label>Price :</label><i>'+strData[i].price+'</i></li><li><label>Min.order :</label><i>'+strData[i].minorder+'</i></li><li><label>'+strData[i].exprops[0].name+':</label>'+strData[i].exprops[0].value+'</li><li><label>'+strData[i].exprops[1].name+':</label>'+strData[i].exprops[1].value+'</li></ul></div><input type="hidden" class="pro_id" value="'+strData[i].id+'" /></div>';
							}else{
								strHtml+='<div class="pro-scroll"><div class="pro-title"><span>'+strData[i].caption+'</span><i>'+strData[i].corpname+'</i></div><div class="product-show"><img src='+strData[i].pic+' /><ul><li><label>Price :</label><i>'+strData[i].price+'</i></li><li><label>Min.order :</label><i>'+strData[i].minorder+'</i></li><li><label>'+strData[i].exprops[0].name+':</label>'+strData[i].exprops[0].value+'</li></ul></div><input type="hidden" class="pro_id" value="'+strData[i].id+'" /></div>';
								}
				        
						}
						$(".scroll-area").append(strHtml);
						//轮播
						var page=1;
						var $p_Div=$(".left-product");
						var $picDiv=$(".scroll-area");
						var picNum=$picDiv.children(".pro-scroll").length;
						$picDiv.css("width",400 * picNum);
						var page_count=Math.ceil(picNum/1);
						var $pDiv_w=$p_Div.width();
						$(".next").click(function(){
							if(page_count>page){
								$picDiv.animate({left:'-'+page*$pDiv_w+"px"},"normal");
								page++;
								$($(".pro-scroll")[page-1]).addClass("current");
								$($(".pro-scroll")[page-1]).siblings(".pro-scroll").removeClass("current");
								$(".prev").addClass("current");
								if(page>=page_count){
									$(this).removeClass("current");
								}else{
									$(this).addClass("current");
								}
							}
						});
						$(".prev").click(function(){
							if(page>1){
								$picDiv.animate({left:"+="+$pDiv_w+'px'},"normal");
								page--;
								$(".next").addClass("current");
								$($(".pro-scroll")[page-1]).addClass("current");
								$($(".pro-scroll")[page-1]).siblings(".pro-scroll").removeClass("current");
								if(page<=1){
									$(this).removeClass("current");
								}else{
									$(this).addClass("current");
								}
							}
						});
					}else if(data.code==10){
							alert("没有数据！");
						}
			 },
			 error: function(data){
					alert("获取失败！");
					}
			});
	} else {
		strHtml = '<div class="pro-scroll"><div class="pro-title"><span>INQUIRY ABOUT'+$proname+'</span><i>'+$corpname+'</i></div><div class="product-show"><img src='+$prod_img+' /><ul><li><label>FOB Price :</label><i>'+$prise+'</i></li><li><label>Min.order :</label><i>'+$minorder+'</i></li></ul></div><input type="hidden" class="pro_id" value="'+$prod_id+'" /></div>';
		$(".scroll-area").append(strHtml);
		$(".scroll-area").find('.pro-scroll:first-child').hide();
		$(".scroll-area").parent().find('.prev-next2').hide();
	}
}


/*页面加载完3S执行*/
setTimeout(function(){show_inquiry()},3000);

$(".close-btn2").click( function(){
	$("#float-layer2").hide();
	$("#opacity-layer").fadeOut(100);
})
$("#username2").focus(function(){
	$("#username_error2").removeClass("is-visible");
	$(this).css("border-color","#ddd");
	})
$("#area2").focus(function(){
	$("#area_error2").removeClass("is-visible");
	$(this).css("border-color","#ddd");
	})
$("span.erro_alert").click(function(){
	$(this).removeClass("is-visible");
	$(this).siblings(".txt").css("border-color","#ddd");
	$(this).siblings(".txt").focus();
	$(this).siblings(".area").css("border-color","#ddd");
	$(this).siblings(".area").focus();
	})
//提交

function send(){
	$(".txt").each(function(){
		if($(this).val()==""){
			$(this).siblings("span").addClass("is-visible");
			$(this).css("border-color","#d41313");
			}else{
				$(this).siblings("span").removeClass("is-visible");
			    $(this).css("border-color","#ddd");
				}
		})
	$(".area").each(function(){
		if($(this).val()==""){
			$(this).siblings("span").addClass("is-visible");
			$(this).css("border-color","#d41313");
			}else{
				$(this).siblings("span").removeClass("is-visible");
			    $(this).css("border-color","#ddd");
				}
		})
	var username = $("#username2");
	if($.trim(username.val())==''){
		$("#username_error2").addClass("is-visible");
		username.css("border-color","#d41313");
		return false;
		}else if(!valideEmail(username)){
		$("#username_error2").text("Please enter your valid email address.");
		$("#username_error2").addClass("is-visible");
		username.css("border-color","#d41313");
		return false;
		}
	var area=$("#area2");
	if($.trim(area.val())==''){
		area.css("border-color","#d41313");
		$("#area_error2").addClass("is-visible");
		return false;
		}else if(area.val().length<20){
			area.css("border-color","#d41313");
			$("#area_error2").addClass("is-visible");
			$("#area_error2").text("The content must be between 20 to 5000 characters.")
			return false;
		}else if(area.val().length>5000){
			area.css("border-color","#d41313");
			$("#area_error2").addClass("is-visible");
			$("#area_error2").text("The content must be between 20 to 5000 characters.")
			return false;
		}
	var email=$("#username2").val();
	var message=$("#area2").val();
	var subject=$(".scroll-area .current").children(".pro-title").children("span").html();
	var isquick=$('[data-role="isquick"]').val();
	var sellinfoid=$(".scroll-area .current").children(".pro_id").val();
	$.ajax({
	type: "GET",
	dataType:'jsonp',
	url: window.location.protocol+'//' + SUPPLIER_DOMAIN + '/ajaxapi.php?op=sendEquiry&sellinfoid='+ sellinfoid +'&email='+ email +'&message='+ message +'&subject='+ subject +'&isquick='+ isquick,
	success: function (data) {
         if(data.code==0){
			 alert(data.message);
			 }
			 else if(data.code==1){
				 $("#inquiry_id").val(data.id);
				 $(".step1").css("display","none");
				 $(".prev-next2").css("display","none");
				 $(".step2").css("display","block");
				 $(".step2 .txt1").val('');
				 }
             else if(data.code==2){
				 alert(data.message);
				 }
		     else if(data.code==3){
				 alert(data.message);
				 }
		     else if(data.code==4){
				 alert(data.message);
				 }
			 else if(data.code==5){
				 alert(data.message);
				 }
			 else if(data.code==6){
				 alert(data.message);
				 }
			 else if(data.code==7){
				 alert(data.message);
				 }
		 },
		 error: function(data){
				alert(data.message);
				}
		});
	}
function send2(){
	var name=$("#name_id").val();
	var company=$("#company_id").val();
	var telephone=$("#tel_id").val();
	var address=$("#address_id").val();
	var id=$("#inquiry_id").val();
	$.ajax({
	type: "GET",
	dataType:'jsonp',
	url: window.location.protocol+'//' + SUPPLIER_DOMAIN + '/ajaxapi.php?op=equiryContact&id='+ id +'&name='+ name +'&company='+ company +'&telephone='+ telephone +'&address='+ address,
	success: function (data) {
         if(data.code==0){
			 alert(data.message);
			 }
			 else if(data.code==1){
				 $(".step2").css("display","none");
	             $(".step3").css("display","block");
				 }
             else if(data.code==2){
				 alert(data.message);
				 }
		     else if(data.code==3){
				 alert(data.message);
				 }
		 },
		 error: function(data){
				alert(data.message);
				}
		});
	}
function continue_view(){
	$(".step3").css("display","none");
	$(".prev-next2").css("display","block");
	$(".step1").css("display","block");
	$("#username2").val('');
	$("#area2").val('');
	$("#selectTxt3").text('');
	}
function valideEmail(objName) {
	var i, strDomain, cChar;
	var nDotCount=0;
	var bFindAlpha=false;
	var bLastIsDot=false;
	var strValid="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.";
	var value = objName.val();

	if(value=="") return true;
	i=value.indexOf("@");
	if(i==-1 || i==0 || i==value.length-1) return false;
	strDomain = value.substring(i+1,value.length);

	if(strDomain.indexOf("@")!=-1) return false;
	if(strDomain.charAt(0)==".") return false;
	if(strDomain.charAt(strDomain.length-1)==".") return false;
	for(i=0;i<strDomain.length;i++) {
	cChar = strDomain.charAt(i);
	if(strValid.indexOf(cChar)==-1) return false;
	if(cChar==".") {
		if(bLastIsDot) return false;
		bLastIsDot=true;
		nDotCount++;
	}else bLastIsDot=false;
	if( (("a"<=cChar) && (cChar<="z")) || (("A"<=cChar)&&(cChar<="Z")) )
	  bFindAlpha=true;
	}
	if(bFindAlpha && (0==nDotCount)) return false;
	var pa = /^[A-Za-z0-9]+([A-Za-z0-9-_.]+[A-Za-z0-9]+)*@([A-Za-z0-9]+[-.])+[A-Za-z0-9]{2,5}$/;
	// /^(?:\w+\.?)*-?\w+@(?:-?\w+\.?)*\w+$/;
	if(!pa.test(value)){
		return false;
	}
	return true;
}
//浏览器判断
　　var type = navigator.appName;
　　if (type == "Netscape"){
    　　var lang = navigator.language;//获取浏览器配置语言，支持非IE浏览器
　　}else{
    　　var lang = navigator.userLanguage;//获取浏览器配置语言，支持IE5+ == navigator.systemLanguage
　　};
　　var lang = lang.substr(0, 2);//获取浏览器配置语言前两位
　　if (lang == "en"){
   　　 $(".float-layer2 ul.check-list li .English").attr('checked',true);
　　};

function boxOut1(id){
	var val_menu=$("#selectTxt"+id).text();
	var select_menu=$("#selectMenu3 a");
	$("#selectMenu3 a").each(function(i){
				var val = $(this).text();
				if(val_menu==val){
					$(this).css("display","none");
					$(this).siblings().css("display","block");
					}
		});
	$("#selectMenu3").slideToggle('fast');
	}
$("#selectMenu3 a").click(function(){
	var index=$(this).text();
	$("#selectTxt3").html(index);
	$("#selectMenu3").css("display","none");
	$("#area2").val("");
	if(index=="Please select FAQ"){
		$("#area2").val("");
        $('[data-role="isquick"]').val(0);
		return false;
	}else{
        $('[data-role="isquick"]').val(1);
	}
    $("#area2").val(index);
	$("#area_error2").removeClass("is-visible");
	$("#area2").css("border-color","#ddd");
	})

var c = 0
$(function(){
    var n = $(".scroll-area .pro-scroll").size()
	$(".scroll-area").css("width",400 * n)
	$("#focus .number li:first").addClass("current")
    $("#focus .number li").css("right",function(i){ return (n-i) * 20})
	$("#focus .number li").click(function(){
	    $(this).addClass("current")
		$(this).siblings().removeClass("current")
		c =  $(this).index()
		$("#scrollArea").animate({scrollLeft: 490*c}, 200);
	})

})
