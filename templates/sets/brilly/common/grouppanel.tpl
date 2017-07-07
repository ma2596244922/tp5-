        <div class="ConBox">
          <div class="clear">&nbsp;</div>
          <h2 class="Til">{$preset_translations.product_groups}</h2>
          <div class="clear">&nbsp;</div>
          <ul class="TextList">
{foreach $groups as $g}{assign var="gid" value={$g.id|default:$g.group_id}}
            <li><a href="{$g|url:'enterprise_url_product_list'}" title="{$g.name}"><strong>{$g.name}</strong>({$g.cnt})</a></li>
{/foreach}
          </ul>
        </div>