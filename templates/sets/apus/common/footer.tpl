<div class="foot_0">
    <div class="foot fl-clr">
        <dl class="fl-clr">
            <dt>{$corporation.name|escape}</dt>
            {if $contacts[0]|default:[]}
            <dd>Mobile : {$contacts[0].tel}</dd>
            <dd class="lst">Mail : {$contacts[0].email}</dd>
            <dd class="lst">Add : {$contacts[0].address}</dd>
            {/if}
        </dl>

        <!--  浮动层    -->
        <div class="sideBar" id="1"><span class="close">Call Me<i></i></span>
            <div class="txt">
                <div class="pa_10_15"></a>
                    <a href="/contactus.html" rel="nofollow" target="_blank" class="a xp"><span>{$preset_translations.contact_now}</span></a>
                    <a href="javascript:;" rel="nofollow"">
                    <span></span>
                    </br>
                </div>
                <a class="top" id="back-to-top" href="javascript:;">Go Top</a></div>
        </div>
    </div>
</div>