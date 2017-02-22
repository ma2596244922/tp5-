{if $total_products > $page_size}
    <div class="text13">
        Page {$page_no} of {$total_pages}
    {if $page_no > 1}
<a class="first" href="{$group.id|url:'enterprise_url_group'}">|<</a>
<a class="previous" href="{$group.id|url:'enterprise_url_group'}"><<</a>
    {/if}
    {for $i=1 to $total_pages}
<a class="page{if $i==$page_no} cur{/if}" href="{$group.id|url:'enterprise_url_group':$i}">{$i}</a>
    {/for}
    {if $page_no < $total_pages}
<a class="next" href="{$group.id|url:'enterprise_url_group':$total_pages}">>></a>
<a class="last" href="{$group.id|url:'enterprise_url_group':$total_pages}">>|</a>
    {/if}
    </div>
{/if}