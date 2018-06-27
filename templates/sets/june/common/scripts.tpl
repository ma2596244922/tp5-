<script charset="utf-8" type="text/javascript" src="media/sets/june/jquery.min.js"></script>

<script type="text/javascript">
function checknum(c, b, a) {
    maxLength = c.getAttribute("maxlength");
    if (maxLength && c.value.length > maxLength) {
        c.value = c.value.substr(0, maxLength);
    } else {
        c.value = c.value.substr(0, b);
    }
    $("#" + a).html(c.value.length);
}
 function jsSubmit(b) {
 	var a = $(b).find("input[name='email']").val();
    if (a.length < 3) {
        alert("{$preset_translations.please_enter_your_email_address}");
        return false;
    }
    var a = $(b).find("textarea[name='message']").val();
    if (a.length < 20 || a.length > 5000) {
        alert("{$preset_translations.your_inquiry_content_must_be_between_20_to_5000_characters}");
        return false;
    }
    return true;
}
</script>