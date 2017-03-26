                <div class="contact-msg"> <span class="title">{$corporation.name}</span>
                    <ul>
{-if $corporation.address|default:''}
                        <li><i>Address</i>{$corporation.address}</li>
{-/if}
{-if $corporation.factory_address|default:''}
                        <li><i>Factory Address</i>{$corporation.factory_address}</li>
{-/if}
{-if $corporation.worktime|default:''}
                        <li><i>Worktime</i>{$corporation.worktime}</li>
{-/if}
{-if $corporation.tel_wt|default:''}
                        <li><i>Business Phone(Working Time)</i>{$corporation.tel_wt}</li>
{-/if}
{-if $corporation.tel_nwt|default:''}
                        <li><i>Business Phone(Nonworking Time)</i>{$corporation.tel_nwt}</li>
{-/if}
{-if $corporation.fax|default:''}
                        <li><i>Fax</i>{$corporation.fax}</li>
{/if}
                    </ul>
                    <div class="btn"><a href="/contactnow.html">Contact Now</a></div>
                </div>