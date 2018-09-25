<div class="ym_end_menu">
    <div class="ym_con_pic">
{foreach $groups_in_links_bar as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index>=3}{break}{/if}
        <!--**dl1**-->
        <dl class="ym_end_menu_dl2">
            <dt>{$group.name}</dt>
    {-foreach $group.products as $product}
            <dd><a href="{$product|url:'enterprise_url_product'}">{$product.caption}</a></dd>
    {-/foreach}
        </dl>
        <!--**dl1**-->
{/foreach}

        <!--**dl1**-->
        <form action="/contactsave.html" id="form-inquiry" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="message_type" value="text/plain" />
        <input type="hidden" name="subject" value="I want to have a cooperation with your company" />
        <input type="hidden" name="message" value="I want to have a cooperation with your company" />
        <dl class="ym_end_menu_dl3">
            <dt>SIGN UP FOR OUR AWESOME NEWS</dt>
            <dd><input name="email" placeholder="Email Address" required="" type="email" class="input1"><input value="Subscribe" type="submit" class="input2"></dd>
        </dl>
        </form>
        <!--**dl1**-->
      
    </div>
    {include file="sets/trade/common/alphabet.tpl"}
</div>