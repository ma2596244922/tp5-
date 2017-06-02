{if $main_products|default:[]}
    <section class="popular-searches">
        <div class="title"><h2>Top Products</h2></div>
        <div class="search-box fl-clr">
    {-foreach $main_products as $mp}
            <a href="{$mp.url}" title="{$mp.label}"><strong>{$mp.label}</strong></a>
    {-/foreach}
        </div>
    </section>
{/if}