<div class="ym_end_menu">
    <div class="ym_con_pic">
{foreach $groups_in_links_bar as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index==2&&$main_products|default:[]}{break}{/if}{if $group@index>=3}{break}{/if}
        <!--**dl1**-->
        <dl class="ym_end_menu_dl2">
            <dt>{$group.name}</dt>
    {-foreach $group.products as $product}
            <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {-/foreach}
        </dl>
        <!--**dl1**-->
{/foreach}
{if $main_products|default:[]}
        <!--**dl1**-->
        <dl class="ym_end_menu_dl2">
            <dt>{$preset_translations.top_products}</dt>
    {-foreach $main_products as $mp}
            <dd><a href="{$mp.url}">{$mp.label}</a></dd>
    {-/foreach}
        </dl>
        <!--**dl1**-->
{/if}

        <!--**dl1**-->
        <form action="/contactsave.html" id="form-inquiry" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="message_type" value="text/plain" />
        <input type="hidden" name="subject" value="I want to have a cooperation with your company" />
        <input type="hidden" name="message" value="I want to have a cooperation with your company" />
        <dl class="ym_end_menu_dl3">
            <dt>SIGN UP FOR OUR AWESOME NEWS</dt>
            <dd><input name="email" placeholder="Email Address" required="" type="email" class="input1"><input value="Subscribe" type="submit" class="input2"></dd>
            <dd class="ym_end_menu_dd"><a href=""><i class="iconfont icon-facebookicon"></i></a><a href=""><i class="iconfont icon-twitter"></i></a></dd>

        </dl>
        </form>
        <!--**dl1**-->
      
    </div>

</div>