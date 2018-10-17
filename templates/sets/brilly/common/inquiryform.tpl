    <div class="ConBox Request">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">{$preset_translations.send_inquiry}</h2>
      <div class="clear"></div>
      <div class="noPic">
        <form action="/contactsave.html" method="POST" data-role="inquiry-form">
        <table>
          <tr>
            <th><span>*</span>Email</th>
            <td>
              <div class="typeIn">
                <p class="msg">{$preset_translations.please_enter_your_email_address}</p>
                <input type="text" id="request_email" name="email" autocomplete="off">
              </div>
            </td>
          </tr>
          <tr>
            <th>{$preset_translations.subject}</th>
            <td>
              <div class="typeIn">
                <p class="msg"> I would like to know more about your product [ CE Certification and Refrigerant Type refrigerant rec</p>
                <input type="text" id="Subject" name="subject" autocomplete="off">
              </div>
            </td>
          </tr>
          <tr>
            <th>{$preset_translations.quick_question}</th>
            <td>
              <dl class="quickSelect" id="quickSelect">
                <dt>{$preset_translations.please_select_faq}<i class="icon arrow_down2"></i></dt>
                <dd>
                  <p>{$preset_translations.quick_question_1}</p>
                  <p>{$preset_translations.quick_question_2}</p>
                  <p>{$preset_translations.quick_question_3}</p>
                  <p>{$preset_translations.quick_question_4}</p>
                  <i class="icon arrow_down2"></i>
                </dd>
              </dl>
            </td>
          </tr>
          <tr>
            <th><span>*</span>{$preset_translations.message}</th>
            <td>
              <div class="typeIn typeIn2">
              	<div>I want to buy <script>
x=document.getElementById("tianjia");
document.write("<span>"+ x.innerHTML+ "</span>");
</script></div>
                <p class="msg" style="padding-top:30px">{$preset_translations.placeholder_of_inquiry_message}</p>
                <textarea id="request_con" style="padding-top:30px" maxlength="500" autocomplete="off" name="message"></textarea>
              </div>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><button type="submit">{$preset_translations.send_now}</button></td>
          </tr>
        </table>
        </form>
      </div>
      <div class="clear"></div>
    </div>