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
{include file="sets/peony/common/navbar.tpl" page_name="news_list"}

        <div class="crumb">
            <p ><a href="/" data-scode="34001" title="{$preset_translations.home}">{$preset_translations.home}</a>&gt;<strong>{$preset_translations.news}</strong></p>
        </div>
        <!--crumb-->

<div class="main-content fl-clr">
    <div class="left-content">
{include file="sets/peony/common/left_menu.tpl" page_name="news_list"}
<!--menu-list-->
{include file="sets/peony/common/contact_panel.tpl"}
</div>
<!--contact-msg-->
    <!--left-content-->
    <div class="right-content">
        <div class="product-box news-box">
            <div class="title"><i></i><h1>{$preset_translations.company_news}</h1></div>
            <div class="news-list">
{foreach $news as $n}
                <dl>
                    <dt><a href="{$n|url:'enterprise_url_news'}" title="{$n.caption}" data-scode="34004">{$n.caption}</a><span class="time">{$n.created}</span></dt>
                    <dd>{$n.content|strip_tags|truncate:260}</dd>
                </dl>
{foreachelse}
                <p><i></i>{$preset_translations.the_user_has_not_provide_such_information}.</p>
{/foreach}
            </div>
{if $total_news > $page_size}
            <div class="news-page">
                <ul>
                    <li>Page<i>{$page_no}</i>of<i>{$total_pages}</i></li>
    {-if isset($pager_info['prev_page'])}
                    <li><a href="{$pager_info['prev_page']|url:'enterprise_url_news_list'}" class="prev"></a></li>
    {-/if}
    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                    <li{if $i==$page_no} class="current"{/if}><a href="{$i|url:'enterprise_url_news_list'}">{$i}</a></li>
    {-/for}
    {-if isset($pager_info['next_page'])}
                    <li><a href="{$pager_info['next_page']|url:'enterprise_url_news_list'}" class="next"></a></li>
    {-/if}
                </ul>
            </div>
{/if}
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
