<div class="send-msg{if isset($send_style)} send1{/if}">
    <span>White a Message</span>
    <form action="/contactsave.html" id="form1" method="POST" enctype="multipart/form-data">
    <div class="form fl-clr">
        <div class="left-input">
            <ul>
                <li><input type="text" class="txt" id="subject" name="subject" placeholder="{$subject|escape}" /><span id="subject-error">此项必填</span></li>
                <li><input type="text" class="txt" id="email" name="email" placeholder="{$preset_translations.please_enter_your_email_address}" /><span id="email-error">请输入有效的邮箱信息</span></li>
                <li><input type="text" class="txt" name="name" placeholder="First Name  Last Name" /></li>
            </ul>
        </div>
        <div class="right-area">
            <textarea class="area" name="message" id="area"></textarea>
            <span id="area-error">此项必填</span>
        </div>
    </div>
    <div class="send-btn"><a href="javascript:void(0)" onclick="submit()" class="search-btn" title="{$preset_translations.quick_question}">Send Message</a></div>
    </form>
</div>

<script>
    function submit() {
        $(".txt").each(function() {
            if ($(this).val() == "") {
                $(this).siblings("span").addClass("is-visible");
                $(this).css("border-color", "#d41313");
                return false;
            }
        })
        var area_value = $("#area").val();
        if (area_value == "") {
            $("#area_error").addClass("is-visible");
            $("#area").css("border-color", "#d41313");
            return false;
        }
        var subject_value = $("#subject").val();
        if (subject_value == "") {
            $("#subject_error").addClass("is-visible");
            $("#subject").css("border-color", "#d41313");
            return false;
        }
        var username = $("#username");
        if (!valideEmail(username)) {
            $("#username_error").addClass("is-visible");
            $("#username_error").text("Please enter your valid email address.");
            $("#username").css("border-color", "#d41313");
            return false;
        }

        $('#form1').submit();
    }
</script>