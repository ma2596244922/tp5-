<div class="Product Navigate Shop">
  <div class="Page">
    <ul class="Navs fl tc">
      <li class="fb"><a href="/">{$preset_translations.home}</a></li>
      <li class="subList">
        <a href="/products.html">{$preset_translations.products}</a><i class="icon arrow_down3"></i>
        <div class="subNav" style="overflow-y:scroll; height:550px;">
{foreach $groups as $group}
          <a href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a>
{/foreach}
        </div>
      </li>
      <li><a href="/aboutus.html">{$preset_translations.company_profile}</a></li>
      <li><a href="/contactus.html">{$preset_translations.contact_us}</a></li>
      <li><a href="/news">{$preset_translations.company_news}</a></li>
      <li><a href="/contactnow.html">{$preset_translations.request_a_quote}</a></li>
    </ul>
    <div class="clear"></div>
  </div>
</div>