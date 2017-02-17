{section name=i loop=$groups}
    <div class="item ">
        <strong>
            <a title="China {$groups[i].name} on sales" href="{$groups[i]|url:'enterprise_url_product_list'}">{$groups[i].name}</a>                     <span class="num">({$groups[i].cnt})</span>
        </strong>
    </div>
{/section}