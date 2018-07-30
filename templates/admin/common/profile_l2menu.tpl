                                                <ul class="ver-inline-menu tabbable margin-bottom-10">

                                                    <li class="{if $profile_page_name=='password'}active{/if}"><a href="?action=password"><i class="icon-lock"></i> 修改密码</a></li>
{if $tpl_style == 'default'}
                                                    <li class="{if $profile_page_name=='profile'}active{/if}"><a href="?action=profile"><i class="icon-cog"></i> 帐号配置</a></li>

                                                    <li class="{if $profile_page_name=='logo'}active{/if}"><a href="?action=logo"><i class="icon-picture"></i> 公司LOGO</a></li>

                                                    <li class="{if $profile_page_name=='favicon'}active{/if}"><a href="?action=favicon"><i class="icon-star"></i> 收藏夹小图标</a></li>

                                                    <li class="{if $profile_page_name=='index_tdk'}active{/if}"><a href="?action=index_tdk"><i class="icon-user"></i> 首页TDK</a></li>

                                                    <li class="{if $profile_page_name=='product_tdk'}active{/if}"><a href="?action=product_tdk"><i class="icon-edit"></i> 产品页TDK</a></li>

                                                    <li class="{if $profile_page_name=='product_default_image'}active{/if}"><a href="?action=product_default_image"><i class="icon-picture"></i> 产品默认图片</a></li>

                                                    <li class="{if $profile_page_name=='common_bg_image'}active{/if}"><a href="?action=common_bg_image"><i class="icon-picture"></i> 全站背景图片</a></li>
    {-if $user.advanced}
                                                    <li class="{if $profile_page_name=='hide'}active{/if}"><a href="?action=hide"><i class="icon-ban-circle"></i> 屏蔽配置</a></li>
    {-/if}
{/if}
                                                </ul>