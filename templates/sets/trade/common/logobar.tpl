        <div class="header fl-clr">
            <a href="/" class="shop-logo" title="{$corporation.name|escape}"><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name|escape}" /></a>
            <dl>
{-if ($page_name|default:''=='product_list' && $group|default:[]) || $page_name|default:''=='product_detail'}
                <dt>{$corporation.name}</dt>
{-else}
                <dt><h1>{$corporation.name}</h1></dt>
{-/if}
                <dd>This is a verified supplier can provide quality products and have passed the Business License Check.</dd>
            </dl>
        </div>