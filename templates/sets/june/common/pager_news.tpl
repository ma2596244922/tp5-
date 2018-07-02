{if $total_news > $page_size}
<div class="public_pages">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody><tr>
                <td>
                    <strong>Page {$page_no} of {$total_pages} :</strong>&nbsp;&nbsp;
                    <a href="{1|url:'enterprise_url_news_list'}"> |&lt; </a>
                    {-if isset($pager_info['prev_page'])}
                    <a href="{$pager_info['prev_page']|url:'enterprise_url_news_list'}" class="prev"> &lt;&lt; </a>
                    {-/if}
                   
                    {-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                    <a{if $i==$page_no} class="cur"{/if} href="{$i|url:'enterprise_url_news_list'}">{$i}</a>
                    {-/for}

                    {-if isset($pager_info['next_page'])}
                        <a href="{$pager_info['next_page']|url:'enterprise_url_news_list'}" class="next"> &gt;&gt; </a>
                    {-/if}
                    <a href="{1|url:'enterprise_url_news_list'}"> &gt;| </a>

                </td>
            </tr>
        </tbody>
    </table>
</div>
<div class="cb_10"></div>
{/if}