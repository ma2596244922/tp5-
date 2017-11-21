<!--float-layer-->
<div class="float-layer float-layer2" id="float-layer2">
    <div class="left-product">
        <div class="scroll-area">
            <div class="pro-scroll current">
                <input type="hidden" class="pro_id"  value='{$product.id}'/>
                <div class="pro-title"><span>INQUIRY ABOUT {$product.caption}</span><i>{$corporation.name}</i></div>
                <div class="product-show">
                    <img src="<?=\common\StatUrl::pic($supply['firstpic'], \common\StatUrl::IMG_SMALL)?>" alt="<?=$supply['caption']?>" />
                    <ul>
                        <li><label>Price :</label><i><?=(isset($supply['price']['low']) && $supply['price']['low'])?('$'.$supply['price']['low'].' - $'.$supply['price']['high'].($supply['unit'] ? " / {$supply['unit']}" : '')):'Negotiable'?></i></li>
                        <li><label>Min.order :</label><i><?="{$supply['minamount']} {$supply['units']}"?></i></li>
                        <?php
                        $count = count($supply['exprops']);
                        $paged = floor($count/2);
                        $rand = $count > 2 ? array_splice($supply['exprops'],(rand(1,$paged)-1)*2,2) : (Empty($supply['exprops']) ? array() : $supply['exprops']);
                        ?>
                        <?php foreach($rand as $v): ?>
                            <?php
                            if(!isset($v['attrname']) || Empty($v['attrname'])) continue;
                            $attrValue = (isset($v['attrvalue']) && !Empty($v['attrvalue'])) ? ((is_array($v['attrvalue']) ? implode(', ',$v['attrvalue']) : $v['attrvalue'])) : '';
                            $other = (isset($v['other']) && !Empty($v['other'])) ? $v['other'] : '';
                            ?>
                            <li><label><?=$v['attrname']?> :</label><?=implode(', ',array_filter(array($attrValue,$other)))?></li>
                        <?php endForeach; ?>
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
                        <a href="javascript:void(0)" title="I'm very interested in your products; could you send me some detail reference information?">I'm very interested in your products; could you send me some detail reference information?</a>
                        <a href="javascript:void(0)" title="Please send me detail product specification, thank you!">Please send me detail product specification, thank you!</a>
                        <a href="javascript:void(0)" title="May I be an agency of your products,and what's yourterms?">May I be an agency of your products,and what's yourterms?</a>
                        <a href="javascript:void(0)" title="We intend to purchase this product, would you please send me the quotation and minimum order quantity?">We intend to purchase this product, would you please send me the quotation and minimum order quantity?</a>
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
                <li><input type="checkbox" value="1" id="checkboxFiveInput" checked="checked" name="" /><label for="checkboxFiveInput"  class="check" num="0"></label>Please reply me within 24 hours. </li>
                <li><input type="checkbox" value="1" id="checkboxFiveInput2" name="" class="English" /><label for="checkboxFiveInput2" class="check" num="1"></label>Yes! I would like verified suppliers matching service!</li>
            </ul>
            <a href="javascript:void(0);" class="send-now" onclick="send();">Send Now</a>
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