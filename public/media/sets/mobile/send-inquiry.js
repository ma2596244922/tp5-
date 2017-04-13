// JavaScript Document
$(function(){
	$('#email').validation('register', {
        method: 'noblank',
        message: 'Please Enter your Email Address',
		failureLayer: '#email_info'
    }).validation('register', {
        method: 'email',
        message: 'Please enter your valid email address.',
		failureLayer: '#email_info'
    });
	$('#area').validation('register', {
        method: 'noblank',
        message: 'Please enter the content for your inquiry.',
		failureLayer: '#area_error'
    }).validation('register', {
        method: 'text',
        message: 'Your inquiry content must be between 20 to 5000 characters.',
        min: 20,
		failureLayer: '#area_error'
    }).validation('register', {
        method: 'text',
        message: 'Your inquiry content must be between 20 to 5000 characters.',
        max: 5000,
		failureLayer: '#area_error'
    });
	$.validation('validateOnBlur');
})
//提交
function send_inquiry(){
	var inquiry = $.validation('validate');
	if(!inquiry){
		return false;
		}
	$(".send-default").css("display","block");
	$(".send-inquiry").css("display","none");
	$("#form-inquiry").submit();
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
   　　 $("#checkboxFiveInput2").attr('checked',true);
　　};
$(".inquiry-detail dl dd").click(function(){
	var dd_value=$(this).children("span").text();
	$("#area").val("");
	$("#area").val(dd_value);
	$("input[name='quick']").val(1);
	})
$('#area').blur(function(){
	var area_val=$(this).val();
	$(".inquiry-detail dd").each(function(){
		var dd_val=$(this).html();
		if(area_val==dd_val){
			$("input[name='quick']").val(1);
			}else{
				$("input[name='quick']").val(0);
				}
		})
	})