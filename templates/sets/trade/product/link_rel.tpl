{-if $page_no > 1}
    {-if $phrase|default:''}
<link rel="prev" href="{$phrase|url:'enterprise_url_product_search':($page_no-1)}" />
    {-else}
<link rel="prev" href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}" />
    {-/if}
{-/if}
{-if $page_no < $total_pages}
    {-if $phrase|default:''}
<link rel="next" href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" />
    {-else}
<link rel="next" href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" />
    {-/if}
{-/if}