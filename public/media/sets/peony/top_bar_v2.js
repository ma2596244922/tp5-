//商铺顶条询盘篮数量  2017-6-6
$(document).ready(function(){
	//创建头部 Inquiry Basket
	$("#top_bar").html("");
	var a=$("<a>");
	    a.attr({href:'javascript:'});
	    $("#top_bar").append(a);
	    a.html("<i></i>Inquiry Basket&nbsp;&nbsp;(<span id='number_top'></span>)");
	
	var count=$.cookie('iw_cnt');
	if(count==undefined){
		count=0
	};
	$("#number_top").text(count);
})