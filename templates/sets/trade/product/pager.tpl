{if $total_products > $page_size}
                <div class="view-page fl-clr">
                    <div class="page">
                        <label>Page</label><span><i>{$page_no}</i>/{$total_pages}</span>
    {-if $page_no > 1}
        {-if $phrase|default:''}
                        <a href="{$phrase|url:'enterprise_url_product_search':($page_no-1)}" class="prev"></a>
        {-else}
                        <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}" class="prev"></a>
        {-/if}
    {-/if}
    {-if $page_no < $total_pages}
        {-if $phrase|default:''}
                        <a href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" class="next"></a>
        {-else}
                        <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" class="next"></a>
        {-/if}
    {-/if}
                    </div>
                </div>
{/if}