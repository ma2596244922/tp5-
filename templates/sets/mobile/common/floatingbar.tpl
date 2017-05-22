<div class="bh_81">
    <div class="pop-button">
{if $contacts[0].skype|default:''}
        <a href="skype:{$contacts[0].skype}?call" class="all">Skype</a>
{else}
        <a href="/products.html" class="all">{$preset_translations.all_products}</a>
{/if}
        <a href="/contactnow.html" class="now">{$preset_translations.contact_now}</a>
    </div>
</div>
