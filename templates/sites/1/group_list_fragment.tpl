{section name=i loop=$groups}
    <div class="item {if isset($product) && $product.group_id==$groups[i].id}active{/if}">
        <strong>
            <a title="China {$groups[i].name} on sales" href="{$groups[i]|url:'enterprise_url_product_list'}">{$groups[i].name}</a>                     <span class="num">({$groups[i].cnt})</span>
        </strong>
    </div>
{/section}