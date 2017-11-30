<!--float-layer-->
<div class="float-layer float-layer2" id="float-layer2">
    <div class="left-product">
        <div class="scroll-area">
            <div class="pro-scroll current">
                <input type="hidden" class="pro_id"  value='{$product.id}'/>
                <div class="pro-title"><span>INQUIRY ABOUT {$product.caption}</span><i>{$corporation.name}</i></div>
                <div class="product-show">
                    <img src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'d'}" alt="{$product.caption}" />
                    <ul>
    {-assign var="total_items" value="0"}
    {-foreach $product_desc as $k => $meta}
        {-if $total_items>=4}{break}{/if}
        {-if $product.$k|default:$meta.default}
                        <li><label>{$meta.label}:</label><i>{$product.$k|default:$meta.default}</i></li>
            {-assign var="total_items" value=$total_items+1}
        {-/if}
    {-/foreach}
                    </ul>
                </div>
            </div>
            <!--pro-scroll-->
        </div>
        <!--scroll-area-->
        <div class="prev-next2">
            <a href="javascript:void(0);" class="prev"></a>
            <a href="javascript:void(0);" class="next current"></a>
        </div>
    </div>
    <div class="form">
        <a href="javascript:void(0);" class="close-btn2"></a>
        <div class="step1">
            <form action="/contactsave.html" id="form-quick-inquiry" method="POST">
            <input type="hidden" name="subject" value="Inquiry About {if $product.caption|default:''}{$product.caption}{else}{$corporation.name}{/if}" />
            <ul class="form-main">
                <input type="hidden" data-role="isquick" value="0">
                <li><label><i>*</i>Email</label><input type="text" class="txt" id="username2" name="email" placeholder="Please Enter your Email Address"><span class="erro_alert" id="username_error2">Please Enter your Email Address</span></li>
                <li class="fl-clr"><label><i></i>Quick question</label>
                    <div class="select fl-clr">
                        <ul class="fl-clr">
                            <li class="select">
                                <a class="select-box" id="slt3" onclick="boxOut(3)">
                                    <span class="selectTxt" id="selectTxt3">Please select FAQ</span>
                                    <i class="select-btn"><em class="search-btn"></em></i>
                                </a>
                                <span class="selectMenu" id="selectMenu3" style="display: none;">
                        <a href="javascript:void(0)" title="Please select FAQ">Please select FAQ</a>
{foreach $quick_questions as $q}
                        <a href="javascript:void(0)" title="{$q|escape}" >{$q}</a>
{/foreach}
                                </span>
                            </li>
                        </ul>
                    </div>
                    <span class="tips">No typing, "Quick question" Help you!</span>
                </li>
                <li class="area"><label><i>*</i>Message</label>
                    <textarea class="area" id="area2" name="message" placeholder="We recommend including Self introduction,
Required specifications and MOQ."></textarea>
                    <span class="erro_alert erro_alert1" id="area_error2">Please enter the content for your inquiry.</span>
                </li>
            </ul>
            <ul class="check-list">
                <li><input type="checkbox" value="1" id="checkboxFiveInput" checked="checked" name="iscontact" /><label for="checkboxFiveInput"  class="check" num="0"></label>Please reply me within 24 hours. </li>
                <li><input type="checkbox" value="1" id="checkboxFiveInput2" name="newsletter" class="English" /><label for="checkboxFiveInput2" class="check" num="1"></label>Yes! I would like verified suppliers matching service!</li>
            </ul>
            <a href="javascript:void(0);" class="send-now" onclick="$('#form-quick-inquiry').submit(); return false;">{$preset_translations.send_now}</a>
            </form>
        </div>

        <!--step1-->
        <div class="step2">
            <p>Be contacted easily by perfecting the information.</p>
            <ul class="form-optional">
                <input type="hidden" id="inquiry_id" value="" />
                <li><label>Name</label><input type="text" class="txt1" id="name_id" name=""></li>
                <li><label>Company</label><input type="text" class="txt1" id="company_id" name=""></li>
                <li><label>Telephone</label><input type="text" class="txt1" id="tel_id" name=""></li>
                <li><label>Address</label><input type="text" class="txt1" id="address_id" name=""></li>
            </ul>
            <a href="javascript:void(0)" class="send-now" onclick="send2()">Finish</a>
        </div>
        <!--step2-->
        <div class="step3">
            <p class="icon"><span></span>Successfully!</p>
            <p>Thank you for your enquiry and you will be contacted soon.</p>
            <a href="javascript:void(0)" class="send-now" onclick="continue_view()">Continue View</a>
        </div>
    </div>
    <!--form-->
</div>
<div class="opacity-layer" id="opacity-layer"></div>