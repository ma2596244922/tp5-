// JavaScript Document
//html 根字号计算
var deviceWidth = document.documentElement.clientWidth;
if(deviceWidth > 640) deviceWidth = 640;
document.documentElement.style.fontSize = deviceWidth / 6.4 + 'px';

// 搜索验证
// $(".search-btn").click(function(){
// 	var search_value=$(".search-txt");
// 	var txt_value = $.trim(search_value.val());
// 	if(txt_value == ""){
// 		alert("Please input information in english only!");
// 		return false;
// 	}else if(!valideChinese(search_value)){
// 		alert("Please input information in english only!");
// 		return false;
// 	}
// 	})
// function valideChinese(objName){
// 	var reg = /[\u4e00-\u9fa5]+/;
// 	var searchPro = objName.val();
// 	if(reg.test(searchPro)){
// 		return false;
// 		}
// 	else{
// 		return true;
// 	}
// }