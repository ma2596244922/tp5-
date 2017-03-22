<div class="no_product_detailmain" id="anchor_product_picture">
        <div class="top_tip">
        <h1>{$product.caption}</h1>
    </div>
    <div class="product_detail_box">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody>
            <tr>
{include file="sets/smm/product_detail/product_wrap_flash.tpl"}
                                <td>
                    <div class="ri">
                        <h3>Product Details:</h3>
{include file="sets/smm/product_detail/product_details.tpl"}
                        
                                                    <h3 class="title_s">Payment & Shipping Terms:</h3>
{include file="sets/smm/product_detail/payment_shipping_terms.tpl"}
                                                <div class="clearfix"></div>

                        <div class="sub">
                            <form action="/contactnow.html" method="POST" id="no_product_detailmain_pform">
                                <input type="hidden" value="{$product.id}" name="pid"/>
                                <input type="hidden" value="1" name="from"/>
                                <input type="submit" value="" class="btn contact_btn">
                            </form>
                        </div>
                        <button chatnow style="display: none" pid={$product.id} type="0" uid="9285" pname="{$product.caption}" purl="{$product|url:'enterprise_url_product'}" picurl="{$product.head_image_id|url:'enterprise_url_image':$product.caption:'s'}"><span></span>Chat Now</button><script type=text/javascript src="/webim/webim.js"></script>                </td>
                            </tr>
            </tbody>
        </table>
    </div>
</div>