<div class="menu-list">
    <dl class="company-dl">
        <dt>Company Overview</dt>
        <dd><a href="/aboutus.html" {if page_name=="aboutus"} class="current"{/if} title="{$preset_translations.company_introduction}" data-scode=""><strong>{$preset_translations.company_introduction}</strong></a></dd>
        <dd><a href="/news" {if page_name=="news_list" || page_name=="news_detail"} class="current"{/if} title="{$preset_translations.company_news}" data-scode=""><strong>{$preset_translations.company_news}</strong></a></dd>
    </dl>
</div>