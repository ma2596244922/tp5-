                <div class="product-box news-box">
                    <div class="title"><i></i><h2>{$preset_translations.contact_info}</h2></div>
                    <div class="news-detail">
                        <div class="news-art intro-art">
                            <div class="scrollArea" id="scrollArea">
{foreach $photos as $photo}
                                <a class="c1"><img src="{$photo.uri|url:'enterprise_url_photo':'':'c'}" alt="" /></a>
{/foreach}
                                <ul class="small-list" id="small-list">
{foreach $photos as $photo}
                                    <li{if $photo@index==0} class="current"{/if}></li>
{/foreach}
                                </ul>
                            </div>
                            <div class="intro-txt">
                                {$corporation.introduction}
                            </div>
                            <div class="intro-txt">
                                <div class="title"><i></i><h2>{$preset_translations.company_details}</h2></div>
                                <ul class="fl-clr">
                                    <li><label>{$preset_translations.business_type}</label><span>{$corporation.business_type}</span></li>
                                    <li><label>{$preset_translations.main_market}</label><span>{$corporation.main_market}</span></li>
                                    <li><label>{$preset_translations.brands}</label><span>{$corporation.brands}</span></li>
                                    <li><label>{$preset_translations.no_of_employees}</label><span>{$corporation.no_of_employees}</span></li>
                                    <li><label>{$preset_translations.annual_sales}</label><span>{$corporation.annual_sales}</span></li>
                                    <li><label>{$preset_translations.year_established}</label><span>{$corporation.year_established}</span></li>
                                    <li><label>{$preset_translations.export_p_c}</label><span>{$corporation.export_p_c}</span></li>
                                </ul>
                            </div>
                            <div class="intro-txt">
                                <div class="title"><i></i><h2>{$preset_translations.history}</h2></div>
                                {$corporation.history}
                            </div>
                            <div class="intro-txt">
                                <div class="title"><i></i><h2>{$preset_translations.service}</h2></div>
                                {$corporation.service}
                            </div>
                            <div class="intro-txt last-txt">
                                <div class="title"><i></i><h2>{$preset_translations.our_team}</h2></div>
                                {$corporation.our_team}
                            </div>
                            
                        </div>
                    </div>
                </div>    