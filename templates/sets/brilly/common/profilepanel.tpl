    <div class="CompanyProfile">
      <div class="ConBox Left ProductIntro">
        <div class="clear">&nbsp;</div>
        <h2 class="Til" id="tianjia">{$preset_translations.company_profile}</h2>
        <div class="clear"></div>
        
          <dl>
            <dd>
             <img src="{$corporation.logo|url:'enterprise_url_image'}" class="fl"  alt="{$corporation.name}">

                <div class="content cur Right_ma_ul">
                    <ul>
                        <li><label>{$preset_translations.business_type}</label>:<span>{$corporation.business_type}</span></li>
                        <li><label>{$preset_translations.main_market}</label>:<span>{$corporation_main_market}</span></li>
                        <li><label>{$preset_translations.brands}</label>:<span>{$corporation.brands}</span></li>
                        <li><label>{$preset_translations.no_of_employees}</label>:<span>{$corporation.no_of_employees}</span></li>
                        <li><label>{$preset_translations.annual_sales}</label>:<span>{$corporation.annual_sales}</span></li>
                        <li><label>{$preset_translations.year_established}</label>:<span>{$corporation.year_established}</span></li>
                        <li><label>{$preset_translations.export_p_c}</label>:<span>{$corporation.export_p_c}</span></li>
                    </ul>
                </div>
            </dd>
          </dl>
      </div>

    </div>