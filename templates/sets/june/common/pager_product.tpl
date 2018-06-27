{if $total_products > $page_size}
<div class="public_pages">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody><tr>
                <td>
                    <strong>Page {$page_no} of {$total_pages} :</strong>&nbsp;&nbsp;
                    {-if $phrase|default:''}
                        <a href="{$phrase|url:'enterprise_url_product_search':1}">|&lt;</a>
                    {-else}
                        <a href="{$group|default:[]|url:'enterprise_url_product_list':1}">|&lt;</a>
                    {-/if}

                    {-if $page_no > 1}
                        {-if $phrase|default:''}
                            <a href="{$phrase|url:'enterprise_url_product_search':($page_no-1)}" class="prev">&lt;&lt;</a>
                        {-else}
                            <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no-1)}" class="prev">&lt;&lt;</a>
                        {-/if}
                    {-/if}

                    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                    {-if $phrase|default:''}
                        <a{if $i==$page_no} class="cur"{/if} href="{$phrase|url:'enterprise_url_product_search':$i}">{$i}</a>
                    {-else}
                        <a{if $i==$page_no} class="cur"{/if} href="{$group|default:[]|url:'enterprise_url_product_list':$i}">{$i}</a>
                    {-/if}
                    
                    {-/for}


                    {-if $page_no < $total_pages}
                        {-if $phrase|default:''}
                            <a href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" class="next"> &gt;&gt; </a>
                        {-else}
                            <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" class="next"> &gt;&gt; </a>
                        {-/if}
                    {-/if}

                    {-if $phrase|default:''}
                        <a href="{$phrase|url:'enterprise_url_product_search':$total_pages}"> &gt;| </a>
                    {-else}
                        <a href="{$group|default:[]|url:'enterprise_url_product_list':$total_pages}"> &gt;| </a>
                    {-/if}
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div class="cb_10"></div>
{/if}