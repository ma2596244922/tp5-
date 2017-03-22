                <td class="product_wrap_flash">
                    <dl class="le r_flash">
                        <dt>
                            <a id="largeimg" class="thickbox" pid="{$product.id}" title="China {$product.caption} supplier" href="{$product.head_image_id|url:'enterprise_url_image':$product.caption}"><div style='max-width:312px; max-height:222px;'><img id="productImg" src="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'c'}" alt="China {$product.caption} supplier" /></div></a>                        </dt>
                        <dd>
                            <div class="blk_18">
{if count($product_images)>1}
                                                                <div class="pro">
                                    <div class="leb fleft">
                                        <a rel="nofollow" href="javascript:void(0)"
                                           onmousedown="ISL_GoUp_1({$product_images|count})"
                                           onmouseup="ISL_StopUp_1()"
                                           onmouseout="ISL_StopUp_1()"
                                           target="_self">
                                        </a>
                                    </div>
                                    <div class="pcont" id="ISL_Cont_1">
                                        <div class="ScrCont">
                                            <div id="List1_1">
                                                <table cellspacing="5" class="fleft">
                                                    <tbody>
                                                    <tr>
    {section name=i loop=$product_images}
                                                                                                                    <td>
                                                                <a rel="nofollow" title="{$product.caption} supplier"><img onclick="change_img({$smarty.section.i.index})" src="{$product_images[i]|url:'enterprise_url_image':$product.caption:'m'}" alt="{$product.caption} supplier" /></a>                                                            </td>
    {/section}
                                                                                                            </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div id="List2_1">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="rib fright">

                                        <a rel="nofollow" onmousedown="ISL_GoDown_1({$product_images|count})" onmouseup="ISL_StopDown_1()" onmouseout="ISL_StopDown_1()" target="_self" title="good quality {$product.caption} suppliers" href="javascript:void(0)"></a>                                    </div>
                                </div>
{/if}
                                                            </div>
                                                                                        <p class="sear">
                                <span class="fleft">Large Image :&nbsp;</span>
                                <a id="large" class="thickbox" pid="{$product.id}" title="China {$product.caption} supplier" href="{$product.head_image_id|url:'enterprise_url_image':$product.caption}">{$product.caption}</a>                            </p>
                                                            
                            <div class="clearfix"></div>
                        </dd>
                    </dl>
                </td>