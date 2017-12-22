<div class="footer">
    <div class="foot">
        <div class="service fl-clr">
            <dl>
                <dt>About</dt>
                <dd><a href="/aboutus.html">{$preset_translations.about_us}</a></dd>
                <dd><a href="/contactus.html">{$preset_translations.contact_us}</a></dd>
                <dd><a href="/quality.html">{$preset_translations.quality_control}</a></dd>
                <dd><a href="/directory.html">{$preset_translations.site_map}</a></dd>
                <dd><a href="//{$alternate_mobile_host}" title="Mobile">Mobile</a></dd>
            </dl>
            <dl>
                <dt>Most Popular</dt>
{foreach $products as $product}{if $product@index>=5}{continue}{/if}
                    <dd>
                        <a href="{$product|url:'enterprise_url_product'}" title="{$product.caption}">{$product.caption|truncate:30}</a>
                    </dd>
{/foreach}
            </dl>
            <dl>
                <dt>Hot Categories</dt>
{foreach $groups as $group}{if $group@index>=5}{continue}{/if}
                <dd><a href="{$group|url:'enterprise_url_product_list'}" title="{$group.name}">{$group.name|truncate:30}</a></dd>
{/foreach}
            </dl>
            <div class="information">
                <span class="title">Informations</span>
                <ul>
                    <li><em class="location"></em><span>No. 192, Zhengyang Road, Chengyang Dist.</span></li>
                    <li><em class="phone"></em><span>86-0532-67766030</span></li>
                </ul>
                <div class="share">
                    <a href="#" class="face"></a>
                    <a href="#" class="twitter"></a>
                    <a href="#" class="google"></a>
                    <a href="#" class="linkIn"></a>
                </div>
            </div>
        </div>
        <div class="copyright">
            <p>Copyright © 2016 - 2017 hizo.com. All  Rights Reserved.</p>
        </div>
    </div>
</div>