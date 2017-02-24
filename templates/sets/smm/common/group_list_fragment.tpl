{foreach $groups as $group}{if $group.cnt<=0}{continue}{/if}
    <div class="item {if isset($product) && $product.group_id==$group.id}active{/if}">
        <strong>
            <a title="China {$group.name} on sales" href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a>                     <span class="num">({$group.cnt})</span>
        </strong>
    </div>
{/foreach}