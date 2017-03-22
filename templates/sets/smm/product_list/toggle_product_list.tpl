                    <div class="no_product_list toggle_product_list">
    <div class="main_title">
        <span class="main_con"><h1>{$group.name}</h1> <span class="num">({$group.cnt})</span></span>
                            <div class="title_other_con">
                                    <form action="" method="POST" onsubmit="return jsWidgetSearch(this,'', 'buy');">
    <input type="text" name="keyword" class="text-inner" value="" placeholder="What are you looking for…">
    <input type="submit" name="submit" value="" class="btn search_btn" style="vertical-align: top">
</form>                            </div>
            </div>
    <div class="list_wrap grid_wrap">
{section name=i loop=$products}
                    <div class="item-wrap">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                    <tr>
                        <td class="product_img_td">
                <a title="China {$products[i].caption} factory" href="{$products[i]|url:'enterprise_url_product'}"><img alt="China {$products[i].caption} factory" src="{$products[i].head_image_id|url:'enterprise_url_image':$products[i].caption:'d'}" /></a>            </td>
                        <td>
                            <div class="product_detail">
                                <h2 class="product_name">
                                    <a class="texta4" title="good quality {$products[i].caption} distributor" href="{$products[i]|url:'enterprise_url_product'}">{$products[i].caption}</a>                                    <div class="btn_wrap">
                                        <form action="/contactnow.html"
                                              method="POST">
                                            <input type="hidden" value="{$products[i].id}" name="pid"/>
                                            <input type="hidden" value="1" name="from"/>
                                            <input type="submit" name="submit"
                                                   value=""
                                                   class="btn submit_4">
                                        </form>
                                    </div>
                                </h2>
                                <div class="intr hidden_box" >{$products[i].caption} {$products[i].description|strip_tags|truncate:150}                                    <a class="more" title="China {$products[i].caption} sales" href="{$products[i]|url:'enterprise_url_product'}">Read More</a>                                </div>
                                                                <span class="time">{$products[i].created}</span>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
{/section}
            </div>
    <div class="page_box" >
{include file="sets/smm/product_list/pager.tpl"}
</div>


</div>