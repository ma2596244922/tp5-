{if $user_voices|default:[]}
    <div class="our-testimonials">
        <div class="h2-title">
            <span>{$preset_translations.our_customer_say}</span>
            <i></i>
        </div>
        <div class="test-inner fl-clr">
            <div class="swiper-container">
                <div class="swiper-wrapper" style=" width:1000%">
                    <div class="swiper-slide">
                        {foreach $user_voices as $uv}
                        <div class="singleTest">
                            <p>
                                {$uv['voice']}
                            </p>
                            <div class="testmonialinner">
                                <span class="h2">daniel amokachi</span>
                                <p>{$uv['title']}</p>
                            </div>
                        </div>
                        {if $uv@index/2 % 1}
                    </div>
                    <div class="swiper-slide">
                        {/if}
                        {/foreach}
                    </div>
                </div>
                <!-- swiper-wrapper -->
                <div class="swiper-pagination"></div>
                <!-- swiper-pagination -->
            </div>
            <!-- swiper-container -->
        </div>
        <!-- test-inner -->
    </div>
{/if}
<!-- our-testimonials -->