    <div class="ConBox Request">
      <div class="clear">&nbsp;</div>
      <h2 class="Til">{$preset_translations.send_inquiry}</h2>
      <div class="clear"></div>
      <div class="noPic">
        <form action="/contactsave.html" method="POST">
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
                <div class="msg"></div>
                <textarea id="request_con" maxlength="500" autocomplete="off" name="message" placeholder="{$preset_translations.placeholder_of_inquiry_message}"></textarea>
              </div>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><button>{$preset_translations.send_now}</button></td>
          </tr>
        </table>
        </form>
      </div>
      <div class="clear"></div>
    </div>