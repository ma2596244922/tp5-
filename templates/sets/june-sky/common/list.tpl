
                    <div class="product-all{if !$products|default:[]} quality-none{/if}">
{-if $group|default:[]&&$group.desc|default:''}
                        <div class="intro-txt" style="padding-top: 15px; padding-left: ;eft: 15px;border-bottom: solid 1px #ddd;padding-bottom: 15px;">{$group.desc}</div>
{-/if}
{foreach $products as $product}

