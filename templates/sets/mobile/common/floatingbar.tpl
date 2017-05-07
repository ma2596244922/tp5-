<div class="bh_81">
    <div class="pop-button">
{if $contacts[0].skype|default:''}
        <a href="skype:{$contacts[0].skype}?call" class="all">Skype</a>
{else}
        <a href="/products.html" class="all">All Products</a>
{/if}
        <a href="/contactnow.html" class="now">Contact Now</a>
    </div>
</div>
