// JavaScript Document
// 英文站搜索
$(function(){
    var zkey, ztype;
    var searchControl1 = $('[data-role="SearchControl"]');
    if (searchControl1.length) {
        searchControl1.each(searchStyle1);
    }

    function searchStyle1(index){

        var searchControl = searchControl1.eq(index);
        var inputTxt = searchControl.find('[data-role="SearchControl.InputKeywords"]'),
	       searchBtn = searchControl.find('[data-role="SearchControl.ButtonSearch"]'),
	        listType = searchControl.find('[data-role="SearchControl.ListType"]'),
	           allLi = searchControl.find('[data-role="SearchControl.ListType"] a'),
	        showSpan = searchControl.find('[data-role="SearchControl.Show"]'),
	      showParent = searchControl.find('[data-role="SearchControl.ShowParent"]');


	    allLi.click(function(){
	    	/* 获取配置 */
	    	var configString = $(this).data('config');
	    	config = eval('('+ configString +')');

	        /* 设置类型值 */
            searchControl.attr('data-type',config['type']);

	        /* 设置placeholder */
	        inputTxt.attr('placeholder', config['placeholder']);
	        
	        /* 控制效果 */
	        showSpan.text($(this).text());
	        listType.css("display","none");
	        showParent.children('i').removeClass('current');
	        
	        /* 设置placeholder */
	        inputTxt.attr('placeholder',config['placeholder']);

	    })


	    /* 点击搜索按钮，跳转到该搜索页面 */
	    searchBtn.on('click',function(){
            /* 获取搜索类型 */
            ztype = searchControl.attr('data-type');
            console.log($(this).attr('id'));
            console.log(showSpan.text());

            if($(this).attr('id') == 'shop_search' && showSpan.text() == 'On Site' ){
                search_go(inputTxt,ztype,1);
            }else{
                search_go(inputTxt,ztype);
            }

	    });

	    /* 按下enter键，跳转到该搜索页面*/
	    inputTxt.keyup(function(event){
	        /* 获取搜索类型 */
            ztype = searchControl.attr('data-type');

            if($(this).attr('id') == 'search_shop' && showSpan.text() == 'On Site' ){
                if(event.keyCode == 13){
                    search_go(inputTxt,ztype,1);
                }
            }else{
                if(event.keyCode == 13){
                    search_go(inputTxt,ztype);
                }
            }
	    });
    }

    function search_go(inputTxt,ztype,flag){
        zkey = $.trim(inputTxt.val());
        // zkey = zkey.replace(/\s+/g,'-');
        zkey = zkey.replace(/[&\|\\\*^%$#@;:~\'\"\"\!￥\(\)]/g,' ');
        
        /* 如果关键词为空，显示提示信息，搜索框获取焦点 */
        if(zkey == ''){
            alert("Please enter a keyword!");
            $(this).focus();
            return false;
        }else if(!valideChinese(inputTxt)){
			alert("Please input information in english only!");
			$(this).focus();
			return false;
		}
        if(flag){
            shop_search(zkey);
        }else{
            /* 如果关键词不为空，ajax请求获取跳转url */
            ajaxRequest(zkey,ztype);
        }
    };

    /* ajax请求获取页面跳转地址 */
    function ajaxRequest(key,type){
        $.ajax({
            type: "POST",
            url: "/common/trade/api.php7?action=generate_url",
            data: "key="+key+"&"+"entType="+type,
            async : false,
            dataType: "json",
            timeout: "5000",
            success: function(msg){
                // window.open(msg, '', '');
                console.log(msg);
                window.location.href=msg;
            },
            error: function(){
                alert("当前访问用户较多，请稍后重试。");
            }
        })
    }
    
    /* 店铺搜索 url拼接获取跳转地址 */
    function shop_search(key){
        var url = window.location.pathname.split("/")[1];
        var sub = $('input[name="subdomain"]').val();
        var url = "//trade"+DOMAIN_SUFFIX+"/"+ url +"/"+sub+"/product.html?keyword="+encodeURIComponent(key)+"";
        window.location.href = url;
    } 

    /* 非中文验证 */
    function valideChinese(objName){
        var reg = /[\u4e00-\u9fa5]+/;
        var searchPro = objName.val();
        if(reg.test(searchPro)){
            return false;
            }
        else{
            return true;
        }
    }
})