<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>{$title}</title>
    <meta name="keywords" content="{$keywords|escape}" />
    <meta name="description" content="{$description|escape}" />
{include file="sets/peony/common/styles.tpl"}
</head>
<body>

{include file="sets/peony/common/topbar.tpl"}
{include file="sets/peony/common/logobar.tpl"}
{include file="sets/peony/common/navbar.tpl" page_name="news_detail"}
        <div class="crumb">
            <p ><a href="/" data-scode="34101" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<a href="/news" title="{$preset_translations.news}" data-scode="34101">{$preset_translations.news}</a>&gt;<strong>{$news.caption}</strong></p>
        </div>
        <!--crumb-->

<div class="main-content fl-clr">
    <div class="left-content">
{include file="sets/peony/common/left_menu.tpl" page_name="news_detail"}
<!--menu-list-->
{include file="sets/peony/common/contact_panel.tpl"}
</div>
<!--contact-msg-->
    <!--left-content-->
    <div class="right-content">
        <div class="product-box news-box">
            <div class="title"><i></i><h1>{$preset_translations.company_news}</h1></div>
            <div class="news-detail">
                <div class="title-news"><span>{$news.caption}</span><i>{$news.created}</i></div>
                <div class="news-art">
{if $news.head_image_id}
                    <div class="imgdiv"><img src="{$news.head_image_id|url:'enterprise_url_image':$news.caption:''}" width="700" alt="{$news.caption}" /></div>
{/if}
                    {$news.content}
                </div>
            </div>
            <div class="next-prev">
                <ul>
{if $prev_news|default:[]}
                    <li><span>{$preset_translations.previous_page}</span><a href="{$prev_news|url:'enterprise_url_news'}">{$prev_news.caption}</a></li>
{/if}
{if $next_news|default:[]}
                    <li class="next"><span>{$preset_translations.next_page}</span><a href="{$next_news|url:'enterprise_url_news'}">{$next_news.caption}</a></li>
{/if}
                </ul>
                <i></i>
            </div>
        </div>
    </div>
    <!--right-content--> 
</div>
<!--main-content-->
{include file="sets/peony/common/footer.tpl"}
<!--footer-->
<!--footer-->

{include file="sets/peony/common/scripts.tpl"}

<script>
        
            var inputTxt = $("#search-text");
            /*searchBtn.on('click',function(){
                 
                    // 验证关键词 
                    validate(inputTxt);
            });*/
                
            // 按下enter键，跳转到该搜索页面
            inputTxt.keyup(function(event){
              
                    if(event.keyCode == 13){
                        
                        self.validate(inputTxt);
                     }
            });

            function validate(inputTxt){
                    var _key = $.trim(inputTxt.val());
                    // 英文站校验规则 
                    // 特殊字符过滤
                    _key = _key.replace(/[&\|\\\*^%$#@;:~\'\"\"\!￥\(\)]/g,' ');

                    // 非空校验、非中文校验
                    if(_key == ''){
                        alert("Please enter a keyword!");
                        inputTxt.focus();
                        return false;
                    }else if(!valideChinese(_key)){
                        alert("Please input information in english only!");
                        inputTxt.focus();
                        return false;
                    }

                    // 调用搜索方法
                    var url = 'http://user.china.cn/test/hizo.com/products.html';
                     
                    window.location.href = url+"?keyword="+encodeURIComponent(_key)+"";
                
                    
                
            }

            function valideChinese(key){
                    var reg = /[\u4e00-\u9fa5]+/;
                    if(reg.test(key)){
                        return false;
                    }else{
                        return true;
                    }
            }

</script>
</body>
</html>
