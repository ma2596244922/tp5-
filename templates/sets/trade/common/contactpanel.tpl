                <div class="contact-msg"> <span class="title">{$corporation.name}</span>
                    <ul>
{-if $corporation.address|default:''}
                        <li><i>{$preset_translations.address}</i>{$corporation.address}</li>
{-/if}
{-if $corporation.factory_address|default:''}
                        <li><i>{$preset_translations.factory_address}</i>{$corporation.factory_address}</li>
{-/if}
{-if $corporation.worktime|default:''}
                        <li><i>{$preset_translations.worktime}</i>{$corporation.worktime}</li>
{-/if}
{-if $corporation.tel_wt|default:''}
                        <li><i>{$preset_translations.business_phone}(Working Time)</i>{$corporation.tel_wt}</li>
{-/if}
{-if $corporation.tel_nwt|default:''}
                        <li><i>{$preset_translations.business_phone}(Nonworking Time)</i>{$corporation.tel_nwt}</li>
{-/if}
{-if $corporation.fax|default:''}
                        <li><i>Fax</i>{$corporation.fax}</li>
{/if}
                    </ul>
                    <div class="btn"><a href="/contactnow.html" rel="nofollow">Contact Now</a></div>
                </div>