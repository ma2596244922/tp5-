{if $site.contact_content|default:''}
        <div class="product-description">
            {$site.contact_content}
        </div>
{else}
    {-foreach $contacts as $contact}
        <div class="contact-communication fl-clr">
            <div class="left-intro">
                <img src="/media/sets/trade/default_photo.jpg" />
                <span>{$contact.name}</span>
            </div>
            <div class="right-intro">
                <ul>
        {-foreach $contact as $f => $v}{if $f=='name'}{continue}{/if}
            {-if isset($contact_desc.$f) && $contact.$f}
                    <li><label>{$preset_translations.{$contact_desc.$f}|default:{$contact_desc.$f}}</label>{$v}</li>
            {-/if}
        {-/foreach}
                </ul>
            </div>
        </div>
    {-/foreach}
        <!--contact-msg-->
        <div class="contact-us contact-us1">
            <div class="title"><i></i><h2>{$preset_translations.send_inquiry}</h2></div>
            <div class="contact-info contact-info1 fl-clr">
                <div class="right-list">
                    <form action="/contactsave.html" id="form-inquiry" method="POST">
                    <input type="hidden" id="subject" name="subject" value="{$preset_translations.can_you_provide_me_a_quote}" />
                    <ul class="fl-clr">
                        <li><label><i></i>{$preset_translations.to}</label>{$corporation.name}</li>
                        <li><label><i>*</i>{$preset_translations.from}</label><input type="text" class="txt1 txt-val" id="email" name="email" value="" /></li>
                        <li class="area-li"><label><i>*</i>{$preset_translations.message}</label>
                        <textarea class="area" id="message" name="message"></textarea></li>
                    </ul>
                    <div class="send-btn"><a href="">{$preset_translations.send_now}</a></div>
                    </form>
                </div>
            </div> 
        </div>
{/if}