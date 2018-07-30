{if $total_news > $page_size}
<div class="paging_box">
    <div id="Pagination" class="pagination">
        <div class="resultNum">Page {$page_no}/{$total_pages}</div>
        <div class="pagearea">
            <span class="pageNum"></span>

            {-if $page_no >1 }
                <a href="{$pager_info['prev_page']|url:'enterprise_url_news_list'}" class='rollPage' rel='nofollow' title='{$preset_translations.previous_page}' >{$preset_translations.previous_page}</a>
            {-/if}

            {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                {if $i==$page_no}<span class="current">{$i}</span>{else}<a href="{$i|url:'enterprise_url_news_list'}" title='{$i}' rel='nofollow'>{$i}</a>{/if}
            {-/for}

            {-if $page_no <$total_pages }
                <a href="{$pager_info['next_page']|url:'enterprise_url_news_list'}" class='rollPage' rel='nofollow' title='{$preset_translations.next_page}' >{$preset_translations.next_page}</a>
            {-/if}
        </div>
    </div>
</div>
{/if}