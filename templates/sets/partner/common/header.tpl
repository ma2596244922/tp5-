<div class="header">
    <div class="head-inner">
        <div class="logo">
            <a href="/" class="logo"><img src="{$corporation.logo|url:'enterprise_url_image'}" alt="{$corporation.name|escape}" /></a>
            {if $ishome|default:"0"}
            <h1>{$corporation.name|escape}</h1>
            {else}
            <span>{$corporation.name|escape}</span>
            {/if}
        </div>
        <div class="head-right">
            <div class="menu email">
                <i class="email"></i>
                <dl>
                    <dt>EMAIL</dt>
                    {if $contacts[0]|default:[]}
                    <dd>{$contacts[0].email}</dd>
                    {else}
                    <dd>{$preset_translations.please_enter_your_email_address}</dd>
                    {/if}
                </dl>
            </div>
            <div class="menu phone">
                <i class="phone"></i>
                <dl>
                    <dt>PHONE</dt>
                    {if $contacts[0]|default:[]}
                    <dd>{$contacts[0].tel}</dd>
                    {else}
                    <dd>{$preset_translations.business_phone}</dd>
                    {/if}
                </dl>
            </div>
        </div>
    </div>
</div>