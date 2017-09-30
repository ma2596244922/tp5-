                <div class="product-box quality-box">
                    <div class="title"><i></i><h2>{$preset_translations.quality_control}</h2></div>
                    <div class="quality-list">
                        {$corporation.qc_profile}
                    </div>
                </div>
                <!--products-box-->
                <div class="product-box certification-box">
                    <div class="title"><i></i><h2>{$preset_translations.certifications}</h2></div>
                    <div class="certification-list fl-clr">
{foreach $certifications as $cert}
                        <div class="certification-detail">
                            <div class="left-img">
                                <a href="{$cert.uri|url:'enterprise_url_photo'}" title="{$cert.standard|default:''}" data-lightbox="certificate-set">
                                    <img src="{$cert.uri|url:'enterprise_url_photo':'':'t'}" alt="{$cert.standard|default:''}" width="120" height="168" style="margin: 10px auto;" />
                                </a>
                            </div>
                            <ul>
    {if $cert.standard|default:''}
                                <li><label>Standard</label><span>{$cert.standard}</span></li>
    {/if}
    {if $cert.number|default:''}
                                <li><label>Number</label><span>{$cert.number}</span></li>
    {/if}
    {if $cert.issue_date|default:''}
                                <li><label>Issue Date</label><span>{$cert.issue_date}</span></li>
    {/if}
    {if $cert.expiry_date|default:''}
                                <li><label>Expiry Date</label><span>{$cert.expiry_date}</span></li>
    {/if}
    {if $cert.scope_n_range|default:''}
                                <li><label>Scope/Range</label><span>{$cert.scope_n_range}</span></li>
    {/if}
    {if $cert.issued_by|default:''}
                                <li><label>Issued By</label><span>{$cert.issued_by}</span></li>
    {/if}
                            </ul>
                        </div>
{/foreach}
                    </div>
                </div>
                <!--products-box-->