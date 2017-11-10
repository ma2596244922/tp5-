    <div class="CompanyProfile">
      <div class="ConBox Left">
        <div class="clear">&nbsp;</div>
        <h2 class="Til">{$preset_translations.company_profile}</h2>
        <div class="clear"></div>
        <img src="{$corporation.logo|url:'enterprise_url_image'}" class="fl"  alt="{$corporation.name}">
        <div class="info" >
          <a href="/aboutus.html" title="{$corporation.name|escape}"><h1>{$corporation.name|escape}</h1></a>
          <table>
{if $contacts[0]|default:[]}
            <tr>
              <th>Email</th>
              <td>{$contacts[0].email}</td>
            </tr>
{/if}
            <tr>
              <th>{$preset_translations.address}</th>
              <td>{$corporation.address}</td>
            </tr>
            <tr>
              <th>{$preset_translations.business_phone}</th>
              <td>{$corporation.tel_wt}</td>
            </tr>
            <tr>
              <th>{$preset_translations.fax}</th>
              <td>{$corporation.fax}</td>
            </tr>
          </table>
        </div>
      </div>
{if $contacts[0]|default:[]}
      <div class="Right">
        <img src="/media/sets/trade/default_photo.jpg"  alt="" title="">
        <table>
        {-foreach $contacts[0] as $f => $v}
            {-if isset($contact_desc.$f) && $contacts[0].$f}
                    <li><label></label></li>
          <tr>
            <th>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</th>
            <td>{$v}</td>
          </tr>
            {-/if}
        {-/foreach}
        </table>
        <a href="/contactnow.html" class="btn" rel="nofollow" style="margin:30px auto 0 auto;">{$preset_translations.send_inquiry}</a>
      </div>
{/if}
    </div>