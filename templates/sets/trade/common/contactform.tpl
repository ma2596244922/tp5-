{if $site.desc_4_inquiry_sender|default:''}
        <div class="product-description">
            <div class="title"><i></i><h2>{$preset_translations.special_note}</h2></div>
            {$site.desc_4_inquiry_sender}
        </div>
{/if}

        <div class="contact-us">
            <div class="title"><i></i><h2>Contact Us</h2></div>
            <div class="contact-info fl-clr">
                <div class="left-list">
                    <img src="{$corporation.logo|url:'enterprise_url_image'}" alt="" />
                    <dl>
                        <dt>{$corporation.name}</dt>
{if $contacts[0]|default:[]}
                        <dd><span>Email</span>{$contacts[0].email}</dd>
{/if}
                        <dd><span>{$preset_translations.address}</span>{$corporation.address}</dd>
                        <dd><span>{$preset_translations.business_phone}(Working Time)</span>{$corporation.tel_wt}</dd>
                        <dd><span>{$preset_translations.fax}</span>{$corporation.fax}</dd>
                    </dl>
                </div>
                <div class="right-list">
                    <form action="/contactsave.html" id="form-inquiry" method="POST">
                    <ul class="fl-clr">
                        <li><label><i>*</i>Email</label><input type="text" class="txt1" id="email" name="email" value="" placeholder="Please Enter your Email Address" /></li>
                        <li><label><i></i>{$preset_translations.to}</label>{$corporation.name}</li>
                        <li><label><i>*</i>{$preset_translations.subject}</label><input type="text" class="txt1 txt-val" id="subject" name="subject" value="Inquiry About {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if}" /></li>
                        <li class="fl-clr"><label><i></i>{$preset_translations.quick_question}</label><div class="select fl-clr">
                            <ul class="fl-clr">
                                <li class="select">
                                    <a class="select-box" id="slt2" onclick="boxOut(2)">
                                        <span class="selectTxt" id="selectTxt2">{$preset_translations.quick_question}</span>
                                        <i class="select-btn"><a href="javascript:void(0)" class="search-btn"></a></i>
                                    </a>
                                    <span class="selectMenu" id="selectMenu2" style="display:none;">
                                       <a href="javascript:void(0)" onclick="getvalue('{$preset_translations.quick_question}','2')">{$preset_translations.quick_question}</a>
{foreach $quick_questions as $q}
                                       <a href="javascript:void(0)" onclick="getvalue('{$q|escape}','2')">{$q}</a>
{/foreach}
                                    </span>
                                </li>
                            </ul>
                        </div>
                        <div class="tips">What is this?<em>This feature is Quick question function, select the corresponding question types, automatically enter the corresponding problem, remove your trouble of typing<i></i></em></div></li>
                        <li class="area-li"><label><i>*</i>{$preset_translations.message}</label>
                        <textarea class="area" id="area" name="message" placeholder="For the best results, we recommend including the following details:
    -Self introduction  
    -Required specifications 
    -Inquire about price/MOQ
                                "></textarea></li>
                    </ul>
                    <div class="send-btn"><a href="">SENG NOW</a></div>
                    </form>
                </div>
            </div>
        </div>