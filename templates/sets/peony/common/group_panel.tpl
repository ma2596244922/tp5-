<div class="menu-list">
    <dl>
        <dt>{$preset_translations.product_groups}</dt>
{foreach $groups as $g}{assign var="gid" value={$g.id|default:$g.group_id}}
        <dd><strong><a href="{$g|url:'enterprise_url_product_list'}"{if isset($group)&&$gid=={$group.id|default:'0'}} class="current"{/if} title="{$g.name}">{$g.name}</a></strong><span>({$g.cnt})</span></dd>
{/foreach}
    </dl>
    <div class="see-more"><a href="javascript:void(0);">see more</a><i></i></div>
</div>