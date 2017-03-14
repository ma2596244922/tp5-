<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$product.caption}</title>
{include file="sets/trade/common/styles.tpl"}
</head>
<body>

<div class="content">
    <div class="container">
{include file="sets/trade/common/logobar.tpl"}
        <!--header-->
{include file="sets/trade/common/navbar.tpl"}
        <!--nav-->
        <div class="crumb">
            <p><a href="/">Home</a>&gt;<a href="/products.html">Products</a>&gt;<a href="{$product_group|url:'enterprise_url_product_list'}">{$product_group.name}</a>&gt;<span>{$product.caption}</span></p>
        </div>
        <!--crumb-->
        <div class="produce-show fl-clr">
            <div class="img-show">
                <div class="tabContent">
                    <div class="big-img">
                        <ul>
{foreach $product_images as $image_id}
                        <li><a href="#" title=""><img src="{$image_id|url:'enterprise_url_image':$product.caption:'t'}" alt="" /></a></li>
{/foreach}
                        </ul>
                    </div>
                    <div class="small-img">
                        <div class="scroll">
                            <div class="img-box">
                                <ul>
{foreach $product_images as $image_id}
                                <li{if $image_id@index == 0} class="current"{/if}><img src="{$image_id|url:'enterprise_url_image':$product.caption:'d'}" alt="" /></li>
{/foreach}
                                </ul>
                            </div>
                        </div>
                        <div class="prev-next">
                        <a href="javascript:void(0);" class="prev"></a>
                        <a href="javascript:void(0);" class="next"></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="simple-intro">
                <div class="title">{$product.caption}</div>
                <ul>
                    <!-- Product Details -->
                    {if $product.place_of_origin|default:''}<li><label>Place of Origin:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.brand_name|default:''}<li><label>Brand Name:</label><span>{$product.brand_name}</span></li>{/if}
                    {if $product.certification|default:''}<li><label>Certification:</label><span>{$product.certification}</span></li>{/if}
                    {if $product.model_number|default:''}<li><label>Model Number:</label><span>{$product.model_number}</span></li>{/if}

                    <!-- Payment & Shipping Terms -->
                    <li><label>Min.Order Quantity:</label><span>{$product.min_order_quantity|default:'Negotiation'}</span></li>
                    <li><label>Price:</label><span>{$product.price|default:'Negotiation'}</span></li>
                    {if $product.packaging_details|default:''}<li><label>Packaging Details:</label><span>{$product.packaging_details}</span></li>{/if}
                    {if $product.delivery_time|default:''}<li><label>Delivery Time:</label><span>{$product.delivery_time}</span></li>{/if}
                    {if $product.place_of_origin|default:''}<li><label>Place of Origin:</label><span>{$product.place_of_origin}</span></li>{/if}
                    {if $product.payment_terms|default:''}<li><label>Payment Terms:</label><span>{$product.payment_terms}</span></li>{/if}
                    {if $product.supply_ability|default:''}<li><label>Supply Ability:</label><span>{$product.supply_ability}</span></li>{/if}
                </ul>
                <div class="contact-btn fl-clr"><a href="/contactnow.html">Contact Now</a></div>
            </div>
        </div>
        <!--produce-show-->
{if count($product_specifications)>0}
        <div class="product-detail">
            <div class="title"><i></i>Product Details</div>
            <table cellpadding="0" cellspacing="0">
    {foreach $product_specifications as $k=>$v}
        {if $v@index%3==0}
                <tr>
        {/if}
                    <td width="11%" class="title-td">{$k}:</td>
                    <td width="22%">{$v}</td>
        {if $v@index%3==2}
                </tr>
        {/if}
    {/foreach}
            </table>
        </div>
{/if}
        <!--product-detail-->
        <div class="product-description">
            <div class="title"><i></i>Product Description</div>
            {$product.description}
        </div>
        <!--product-description-->
        <div class="contact-us">
            <div class="title"><i></i>Contact Us</div>
            <div class="contact-info fl-clr">
                <div class="left-list">
                    <img src="{$corporation.logo|url:'enterprise_url_photo'}" alt="" />
                    <dl>
                        <dt>{$corporation.name}</dt>
                        <dd><span>Address</span>{$corporation.address}</dd>
                        <dd><span>Factory Address</span>{$corporation.factory_address}</dd>
                        <dd><span>Worktime</span>{$corporation.worktime}</dd>
                        <dd><span>Business Phone(Working Time)</span>{$corporation.tel_wt}</dd>
                        <dd><span>Business Phone(Nonworking Time)</span>{$corporation.tel_nwt}</dd>
                        <dd><span>Fax</span>{$corporation.fax}</dd>
                    </dl>
                </div>
                <div class="right-list">
                    <form action="/contactsave.html" id="form-inquiry" method="POST">
                    <ul class="fl-clr">
                        <li><label><i>*</i>Email</label><input type="text" class="txt1" id="email" name="email" value="" /></li>
                        <li><label><i></i>To</label>{$corporation.name}</li>
                        <li><label><i>*</i>Subject</label><input type="text" class="txt1 txt-val" id="subject" name="subject" value="" /></li>
                        <li class="fl-clr"><label><i></i>Quick question</label><div class="select fl-clr">
                            <ul class="fl-clr">
                                <li class="select">
                                    <a class="select-box" id="slt2" onclick="boxOut(2)">
                                        <span class="selectTxt" id="selectTxt2">Quick question</span>
                                        <i class="select-btn"><a href="javascript:void(0)" class="search-btn"></a></i>
                                    </a>
                                    <span class="selectMenu" id="selectMenu2" style="display:none;">
                                       <a href="javascript:void(0)" onclick="getvalue('Quick question','2')">Quick question</a>
                                       <a href="javascript:void(0)" onclick="getvalue('Supplier','2')">Supplier</a>
                                       <a href="javascript:void(0)" onclick="getvalue('Buying Leads','2')">Buying Leads</a>
                                    </span>
                                </li>
                            </ul>
                        </div>
                        <div class="tips">What is this?<em>This feature is Quick question function, select the corresponding question types, automatically enter the corresponding problem, remove your trouble of typing<i></i></em></div></li>
                        <li class="area-li"><label><i>*</i>Message</label>
                        <textarea class="area" id="area" name="message"></textarea></li>
                    </ul>
                    <div class="send-btn"><a href="">SENG NOW</a></div>
                    </form>
                </div>
            </div>
        </div>
        <div class="product-categories">
            <div class="title"><i></i>Product Categories</div>
            <table cellpadding="0" cellspacing="0">
{foreach $groups as $group}
    {if $group@index%3==0}
                <tr>
    {/if}
                    <td width="33%"><a href="{$group|url:'enterprise_url_product_list'}">{$group.name}</a></td>
    {if $group@index%3==2}
                </tr>
    {/if}
{/foreach}
            </table>
        </div>
        <!--product categories-->
        <div class="new-products">
            <div class="title"><i></i>New Products</div>
            <div class="tab-content">
                <div class="tabs-new" id="tabs-new">
                        <a href="javascript:void(0)" class="current"></a>
                        <a href="javascript:void(0)"></a>
                        <a href="javascript:void(0)"></a>
                        <a href="javascript:void(0)"></a>
                    </ul>
                </div>
                <div class="tabs-list" id="tabs-list">
                    <ul class="fl-clr">
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting Guangzhou Lighting</i></a></li>
                    </ul>
                    <ul class="fl-clr">
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i> 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 46 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting Guangzhou Lighting</i></a></li>
                    </ul>
                    <ul class="fl-clr">
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C2324 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 674637 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting Guangzhou Lighting</i></a></li>
                    </ul>
                    <ul class="fl-clr">
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 400lm 560lm Guangzhou Lighting</i></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/new-product.jpg" alt="" /><i>C37 240lm 679876 560lm Guangzhou Lighting Guangzhou Lighting</i></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!--new-products-->
        <div class="search-product">
        <div class="similar-product">
            <dl>
                <dt>Find Similar Products By Category</dt>
                <dd><a href="#" title="">Auto, Motorcycle Parts & Accessories</a>&gt;<a href="#" title="">Auto Electrical System</a>&gt; <a href="#" title="">Car Battery (9314)</a></dd>
                <dd><a href="#" title="">Sporting Goods & Recreation</a>&gt;<a href="#" title="">Sports Field Equipment & Facilities</a>&gt; <a href="#" title="">Artificial Grass (19481)</a></dd>
            </dl>
        </div>
        <div class="hot-search">
            <dl>
                <dt>Hot Searches:</dt>
                <dd><a href="#" title="">China Grass</a></dd>
                <dd><a href="#" title="">China Soccer</a></dd>
                <dd><a href="#" title="">Artificial Grass</a></dd>
            </dl>
        </div>
        </div>
    </div>
    <!--container-->
</div>
<!--content-->
<div class="service-box">
    <div class="service-list product-list fl-clr">
        <dl>
            <dt>Buy on china.cn</dt>
            <dd><a href="#" rel="nofollow">How to buy</a></dd>
            <dd><a href="#">Browse by catagories</a></dd>
            <dd><a href="#">Browse by Hot regoins</a></dd>
            <dd><a href="#" rel="nofollow">Private Sourcing Events</a></dd>
        </dl>
        <dl>
            <dt>Selling on china.cn</dt>
            <dd><a href="#" rel="nofollow">How to sell</a></dd>
            <dd><a href="#" rel="nofollow">Premium Member</a></dd>
            <dd><a href="#" rel="nofollow">Post Products</a></dd>
            <dd><a href="#" rel="nofollow">Manage Products</a></dd>
        </dl>
        <dl>
            <dt>Services</dt>
            <dd><a href="#" rel="nofollow">Post buying lead</a></dd>
            <dd><a href="#" rel="nofollow">Product Alert</a></dd>
            <dd><a href="#" rel="nofollow">Dispute and Complaint Assistance</a></dd>
        </dl>
        <dl>
            <dt>About</dt>
            <dd><a href="#" rel="nofollow">About us</a></dd>
            <dd><a href="#" rel="nofollow">Link to us</a></dd>
            <dd><a href="#" rel="nofollow">Contact us</a></dd>
            <dd><a href="#">Site map</a></dd>
        </dl>
    </div>
</div>
<!--service-box-->
{include file="sets/trade/common/footer.tpl"}
{include file="sets/trade/common/navbar.tpl" position="fixed"}
{include file="sets/trade/common/scripts.tpl"}
</body>
</html>