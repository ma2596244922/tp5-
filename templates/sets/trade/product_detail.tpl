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
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/big-img.jpg" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/index/big11.png" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/index/big22.png" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/index/img_big.png" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/shop/big-img.jpg" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/index/big11.png" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/index/big22.png" alt="" /></a></li>
                        <li><a href="#" title=""><img src="http://himg.china.cn/img/env2/main/index/img_big.png" alt="" /></a></li>
                        </ul>
                    </div>
                    <div class="small-img">
                        <div class="scroll">
                            <div class="img-box">
                                <ul>
                                <li class="current"><img src="http://himg.china.cn/img/env2/main/shop/small-img.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img2.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img3.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img4.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img2.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img4.jpg" alt="" /></li>
                                <li><img src="http://himg.china.cn/img/env2/main/shop/small-img3.jpg" alt="" /></li>
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
                <div class="contact-btn fl-clr"><a href="#">Contact Now</a><a href="javascript:" data-role="565626" class="add single_an" onclick="aclick(565626)">Add to My Cart</a></div>
                <div class="ad-box">
                <img src="http://himg.china.cn/img/env2/main/shop/ad.jpg" alt="" />
                </div>
            </div>
        </div>
        <!--produce-show-->
        <div class="product-detail">
            <div class="title"><i></i>Product Details</div>
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td width="11%" class="title-td">Place of Origin:</td>
                    <td width="23%">Sichuan China (Mainland)</td>
                    <td width="12%" class="title-td">Upper Material:</td>
                    <td width="24%">PU</td>
                    <td width="10%" class="title-td">Size:</td>
                    <td width="20%">36-41#</td>
                </tr>
                <tr>
                    <td width="11%" class="title-td">Brand Name:</td>
                    <td width="23%">Carolie Rossi</td>
                    <td width="12%" class="title-td">Lining Material:</td>
                    <td width="24%">PU</td>
                    <td width="10%" class="title-td">Heel Type:</td>
                    <td width="20%">Slim</td>
                </tr>
                <tr>
                    <td width="11%" class="title-td">Model Number:</td>
                    <td width="23%">bt05-f335</td>
                    <td width="12%" class="title-td">Insole Material:</td>
                    <td width="24%">PU</td>
                    <td width="10%" class="title-td">MOQ:</td>
                    <td width="20%">24pcs</td>
                </tr>
                <tr>
                    <td width="11%" class="title-td">Gender:</td>
                    <td width="23%">Women</td>
                    <td width="12%" class="title-td">Outsole Material:</td>
                    <td width="24%">Rubber</td>
                    <td width="10%" class="title-td">Main Market:</td>
                    <td width="20%">America</td>
                </tr>
                <tr>
                    <td width="11%" class="title-td">Style:</td>
                    <td width="23%">Pumps</td>
                    <td width="12%" class="title-td">Season:</td>
                    <td width="24%">Autumn, Spring, Summer, Winter</td>
                    <td width="10%" class="title-td">&nbsp;</td>
                    <td width="20%">&nbsp;</td>
                </tr>
            </table>
        </div>
        <!--product-detail-->
        <div class="product-description">
            <div class="title"><i></i>Product Description</div>
            <span>Painless 940nm Diode Laser For Hair Removal For Chest , Leg</span>
            <p>940nm wavelength effectively penetrates deep into and absorbed by the target chromophore. The adequate pulse duration, energy density and epidermal cooling ensure an adequate thermal damage to the target tissue without damaging the surrounding tissue to achieve effective hair removal. (More effective and safer than 810nm diode laser)</p>
            <img src="http://himg.china.cn/img/env2/main/shop/product-img.jpg" alt="" />
            <p>Our Service</p>
            <p>1. High quality with competitive price.</p>
            <p>2. E-catalog be provided pleasurably.</p>
            <p>3. Sample order is available for our first cooperation</p>
            <p>4. Any idea of design, let's have a discussion!</p>
            <p>5. Sample production time about 15 days</p>
            <p>6. Mass production time about 20-25 days</p>
            <p>7. Payment term: T/T ( Total amount over USD 5000.00, we accept 30% deposit, 70% balance pay before shipment )</p>
            <p>8. Sample order payment accept Paypal, Western Union, Alibaba Escrow.</p>
            <p>9. Our pleasure to provide EXW, FOB, CIF price as reference.</p>
            <p>10. Urgently order, pls contact us by Skype: carmen_tang30 </p>
            <p>2. Confirm the Product detail, Price, Lead time, Payment term etc.</p>
            <p>3. Receive our proforma Invoice by mail.</p>
            <p>4. Confirm the payment and send us bank copy.</p>
            <p>5. Payment confirmed, we start production!</p>
            <p>6. Production finished, confirm the product's photos by mail again.</p>
            <p>7. Goods be delivered via Sea / Air / Express. Receive the track number and document for pick up packages from us.</p>
            <p>8. Receive the goods and test immediately, any problem pls contact us ASAP.</p>
            <p>9. Feedback Quality, Service, Market Feedback and Suggestion. These info could help us do better and better in the future!</p>
        </div>
        <!--product-description-->
        <div class="contact-us">
            <div class="title"><i></i>Contact Us</div>
            <div class="contact-info fl-clr">
                <div class="left-list">
                    <img src="http://himg.china.cn/img/env2/main/shop/contact.jpg" alt="" />
                    <dl>
                        <dt>Top Biology Pharmacy Co.,Ltd GuangZhou[China]</dt>
                        <dd><span>Address</span>No.6 XiWan Road LinWan District Guangzhou Guangdong  China</dd>
                        <dd><span>Phone</span>86-20-81480691</dd>
                        <dd><span>Contact name</span>Med,market</dd>
                    </dl>
                </div>
                <div class="right-list">
                    <ul class="fl-clr">
                        <li><label><i>*</i>Email</label><input type="text" class="txt1" value="Enter a keyword to search products" /></li>
                        <li><label><i></i>To</label>Top Biology Pharmacy Co.,Ltd</li>
                        <li><label><i></i>Subject</label><input type="text" class="txt1 txt-val" value="Edison light ce rohs ul led filament bulb light st58 in 2016" /></li>
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
                        <textarea class="area">For the best results, we recommend including the following details:
-Self introduction\n
-Required specifications\n
-Inquire about price/MOQ</textarea></li>
                    </ul>
                    <div class="send-btn"><a href="#">SENG NOW</a></div>
                </div>
            </div>
        </div>
        <div class="product-categories">
            <div class="title"><i></i>Product Categories</div>
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td width="33%"><a href="#">Tom Dixon Mirror Ball Pendant Light</a></td>
                    <td width="34%"><a href="#">YUDA 3W GU10 LED Indoor Spotlighting</a></td>
                    <td width="33%"><a href="#">Grain Products</a></td>
                </tr>
                <tr>
                    <td width="33%"><a href="#">Food Ingredients</a></td>
                    <td width="34%"><a href="#">Fruit Products</a></td>
                    <td width="33%"><a href="#">Other Food & Beverage</a></td>
                </tr>
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
<div class="footer">
    <div class="foot">
        <ul>
            <li><a href="#" rel="nofollow">About Us</a>|</li>
            <li><a href="#" rel="nofollow">Contact Us</a>|</li>
            <li><a href="#" rel="nofollow">Intellectual Property Policy</a>|</li>
            <li><a href="#" rel="nofollow">Privacy Policy</a>|</li>
            <li><a href="#" rel="nofollow">Terms of Use</a>|</li>
            <li><a href="#" rel="nofollow">Advertise</a>|</li>
            <li><a href="#" rel="nofollow">Partners</a></li>
        </ul>
        <p>京ICP证 040089号 京公网安备11010802017131</p>
    </div>
</div>
<div class="nav nav-fixed">
            <ul>
                <li><a href="#" title="">Home</a></li>
                <li><a href="#" title="">Product Categories<i></i></a>
                    <ul class="nav-list" style="width:228px;">
                        <li><a href="#" title="">Bean & Preparation</a></li>
                        <li><a href="#" title="">Cereal</a></li>
                        <li><a href="#" title="">Cigarette & Tobaccot shirtturkey 100% Cotton</a></li>
                        <li><a href="#" title="">Dried Fruit</a></li>
                        <li><a href="#" title="">Econ-valuable Vegetable</a></li>
                        <li><a href="#" title="">Edible Fungus & Algae</a></li>
                        <li><a href="#" title="">Flour & Preparation</a></li>
                        <li><a href="#" title="">Flower & Gardening Plant</a></li>
                    </ul>
                </li>
                <li><a href="#" title="">Company Profile<i></i></a>
                    <ul class="nav-list nav-list1">
                <li><a href="#" title="">Company Introduction</a></li>
                <li><a href="#" title="">Company News </a></li>
                <li><a href="#" title="">Photo Gallery</a></li>
            </ul>
                </li>
                <li><a href="#" title="">Quality Control</a></li>
                <li><a href="#" title="">Contacts</a></li>
            </ul>
        </div>
{include file="sets/trade/common/scripts.tpl"}
</body>
</html>