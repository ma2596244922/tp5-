<div class="footer">
    <div class="foot-inner fl-clr">
        <div class="widget">
            <div class="fotterTitle">ABOUT US</div>
            <p class="fotinfo">
                Vivamus nisi purus, luctus sit amet scelerisque volutpat,
                malesuada in quam. Morbi vehicula, ligula et consectetur dictum,
                lectus elit ultricies est, ut congue augue risus ac turpis.
            </p>
        </div>
        <div class="widget">
            <div class="fotterTitle">NAVIGATION</div>
            <ul class="navigation">
                <li><a href="/">{$preset_translations.home}</a></li>
                <li><a href="/aboutus.html">{$preset_translations.company_profile}</a></li>
                <li><a href="/contactus.html">{$preset_translations.contact_us}</a></li>
            </ul>
        </div>
        <div class="widget">
            {foreach $groups as $group}{if $group.cnt<=0}{continue}{/if}{if $group@index==2&&$main_products|default:[]}{break}{/if}{if $group@index>=2}{break}{/if}
            <div class="fotterTitle">Latest Twitter</div>
            {foreach $group.products as $product}
            <p class="twitter_text">
                <a href="{$product|url:'enterprise_url_product'}">{$product.caption} </a>&rlm; {$product.tags}
            </p>
            {/foreach}
            {/foreach}
        </div>
        <div class="widget">
            <div class="fotterTitle">Our Newslatter</div>
            <p class="newslatp">
                Sign up for our mailing list to get latest updates and offers.
            </p>
            <div class="form">
                <input type="email" id="sub_email" name="sub_email" placeholder="Your email...">
                <a href="#" class="subs_submit" name="subs_submit"></a>
            </div>
        </div>
    </div>
</div>
<!-- footer -->
<div class="copyright">
    <p>© {$site.start_year} - {$smarty.now|date_format:'%Y'} <a href="http://www.{$site_root_domain}/">{$preset_translations.pc_sites}</a> {$preset_translations.all_rights_reserved}</p>
</div>