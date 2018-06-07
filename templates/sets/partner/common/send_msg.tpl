<div class="send-msg{if isset($send_style)} send1{/if}">
    <span>White a Message</span>
    <div class="form fl-clr">
        <div class="left-input">
            <ul>
                <li><input type="text" class="txt" id="subject" placeholder="subject" /><span id="subject-error">此项必填</span></li>
                <li><input type="text" class="txt" id="email" placeholder="email" /><span id="email-error">请输入有效的邮箱信息</span></li>
                <li><input type="text" class="txt" placeholder="name" /></li>
            </ul>
        </div>
        <div class="right-area">
            <textarea class="area" id="area"></textarea>
            <span id="area-error">此项必填</span>
        </div>
    </div>
    <div class="send-btn"><a href="javascript:void(0)" onclick="boxOut(2)" class="search-btn" title="{$preset_translations.quick_question}">Send Message</a></div>
</div>