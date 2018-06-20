<div class="fl-clr send-msg{if isset($send_style)} send1{/if}">
    <span>White a Message</span>
    <form action="/contactsave.html" id="form1" method="POST" enctype="multipart/form-data">
    <div class="form fl-clr">
        <div class="left-input">
            <ul>
                <li><input type="text" class="txt txt1" id="subject" name="subject" placeholder="{$subject|escape}" /><span id="subject-error">Please Enter your Subject.</span></li>
                <li><input type="text" class="txt txt1" id="email" name="email" placeholder="{$preset_translations.please_enter_your_email_address}" /><span id="email-error">Please enter Your valid email address.</span></li>
                <li><input type="text" class="txt" name="name" placeholder="First Name  Last Name" /></li>
            </ul>
        </div>
        <div class="right-area">
            <textarea class="area" name="message" id="area" placeholder="Your inquiry content..."></textarea>
            <span id="area-error">Your inquiry content must be between 20 to 5000 characters.</span>
        </div>
    </div>
    <div class="send-btn"><a href="javascript:void(0)" onclick="submit()" class="search-btn" title="{$preset_translations.quick_question}">Send Message</a></div>
    </form>
</div>

<script>
    function submit() {
        $(".txt1").each(function() {
            if ($(this).val() == "") {
                $(this).siblings("span").css("display", "block");
                $(this).css("border-color", "#d41313");
                return false;
            }
        })
        var area_value = $("#area").val();
        if (area_value == "") {
            $("#area-error").css("display", "block");
            $("#area").css("border-color", "#d41313");
            return false;
        }
        var subject_value = $("#subject").val();
        if (subject_value == "") {
            $("#subject-error").addClass("is-visible");
            $("#subject").css("border-color", "#d41313");
            return false;
        }
        var username = $("#email");
        if (!valideEmail(username)) {
            $("#email-error").css("display", "block");
            $(this).css("border-color", "#d41313");
            return false;
        }
        $('#form1').submit();
    }
</script>