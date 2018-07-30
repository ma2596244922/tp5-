{if $total_products > $page_size}

<div class="paging_box">
    <div id="Pagination" class="pagination">
        <div class="pagearea"><span class="pageNum">Page {$page_no}/{$total_pages}</span>

            {-if $page_no >1 }
                {-if $phrase|default:''}
                    <a href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" class='rollPage' rel='nofollow' title='{$preset_translations.previous_page}' >{$preset_translations.previous_page}</a>
                {-else}
                    <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" class='rollPage' rel='nofollow' title='{$preset_translations.previous_page}' >{$preset_translations.previous_page}</a>
                {-/if}
            {-/if}

            {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
            {-if $phrase|default:''}
                {if $i==$page_no}<span class="current">{$i}</span>{else}<a href="{$phrase|url:'enterprise_url_product_search':$i}" title='{$i}' rel='nofollow'>{$i}</a>{/if}
            {-else}
                {if $i==$page_no}<span class="current">{$i}</span>{else}<a href="{$group|default:[]|url:'enterprise_url_product_list':$i}" title='{$i}' rel='nofollow'>{$i}</a>{/if}
            {-/if}
            
            {-/for}

            {-if $page_no <$total_pages }
            {-if $phrase|default:''}
                <a href="{$phrase|url:'enterprise_url_product_search':($page_no+1)}" class='rollPage' rel='nofollow' title='{$preset_translations.next_page}' >{$preset_translations.next_page}</a>
            {-else}
                <a href="{$group|default:[]|url:'enterprise_url_product_list':($page_no+1)}" class='rollPage' rel='nofollow' title='{$preset_translations.next_page}' >{$preset_translations.next_page}</a>
            {-/if}
            {-/if}
        </div>
    </div>
</div>
{/if}