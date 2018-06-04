<div class="nav">
    <div class="nav-inner">
        <ul>
            <li><a href="/">HOME</a></li>
            <li><a href="/products.html">OUR PRODUCTS</a></li>
            <li><a href="/aboutus.html">ABOUT COMPANY</a></li>
            <li><a href="/quality.html">QUALITY CONTROL</a></li>
            <li><a href="/contactus.html">CONTACT US</a></li>
            <li><a href="/contactnow.html">REQUEST A QUOTE</a></li>
        </ul>
        <div class="search">
            <input type="text" class="search-txt" placeholder="search..." />
            <span class="search-icon"></span>
        </div>
        <div class="select-flag current" data-role="selectParent">
            <div class="select-box fl-clr" data-role="ShowParent">
                <span class="selectTxt" data-role="SearchShow"><img src="/media/sets/partner/images/langflags/en.png" width="16" height="11">English</span>
                <i></i>
            </div>
            <div class="selectMenu" style="display:none;" data-role="ListType">
                {foreach $supported_lang_codes as $lc => $meta}{if $site_lang_codes.$lc|default:'0'=='0'}{continue}{/if}
                {if $meta@index==1}
                <a href="http://{$lc}.{$site_root_domain}/" style="display: none;"><img src="/media/sets/partner/images/langflags/{$lc}.png" width="16" height="11">{$meta.locale_label}</a>
                {else}
                <a href="http://{$lc}.{$site_root_domain}/" style="display: block;"><img src="/media/sets/partner/images/langflags/{$lc}.png" width="16" height="11">{$meta.locale_label}</a>
                {/if}
                {/foreach}
            </div>
        </div>
        <!-- select-flag -->
    </div>
</div>