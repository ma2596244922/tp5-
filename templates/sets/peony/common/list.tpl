

                    <div class="product-all{if !$products|default:[]} quality-none{/if}">
                        {-if $group|default:[]&&$group.desc|default:''}
                        <div class="intro-txt" style="padding-top: 15px; padding-left: 15px;">{$group.desc}</div>
                        {-elseif $keyword|default:[]&&$keyword.desc|default:''}
                        <div class="intro-txt" style="padding-top: 15px; padding-left: 15px;">{$keyword.desc}</div>
                        {-else}
                        {-/if}
                        {foreach $products as $product}
                    </div>