
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>首页产品管理</title>
  <link rel="stylesheet" type="text/css" href="simple/style.css">
</head>
<body>

{include file="simple/common/top.tpl"}
<div class="Content Page">
  {include file="simple/common/left.tpl"}
  <div class="MaxMain">
    <div class="MaxMainBox">
      <h2 class="BoxTil fl">首页产品管理</h2>
    </div>
    <table class="GoodsListTb home-list">
      <thead>
        <tr>
          <td class="pic" width="15%">产品图片</td>
          <td width="30%">产品名称</td>
          <td width="13%">发布时间</td>
          <td width="13%">更新时间</td>
          <td width="15%">操作</td>
          <td width="14%"><p>排序</p></td>
        </tr>
      </thead>
      <tbody>

{section name=i loop=$products}

     <tr class="on">

          <td class="pic">
            <img class="gp" src="{$products[i].head_image_id|default:''|url:'enterprise_url_image':{$product.caption|default:''}:'c'}">
          </td>
          <td class="name">
            <a href="{$products[i]|url:'enterprise_url_product'}">{$products[i].caption}</a>
          </td>
          <td class="time">{$products[i].created}</td>
          <td class="time2">{$products[i].updated}</td>
          <td class="acts">
            <a href="" class="homepage">排至首页</a>
          </td>
          <td class="sortTD">
            <input type="text">
          </td>
        </tr>
{sectionelse}
        <tr>
            <td colspan="6">暂无任何产品</td>
        </tr>
{/section}  

      </tbody>
    </table>


    <div class="MaxMainBox">
      <div class="Pager ConBox tr">
        <button class="fr" id="goto">Go</button>
        <input class="fr tc" type="" id="goto_input">
        <span class="fr">Go to Page</span>
       


<div class="lists">


{-for $i=$pager_info['min_page'] to $pager_info['max_page']}
                                              <a href="?action=index_products_new&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$i}">{$i}</a>
{-/for}
{-if isset($pager_info['next_page'])}
                                                <a  title="下一页" class="right" href="?action=index_products_new&group_id={$smarty.get.group_id|default:''}&keywords={$smarty.get.keywords|default:''|urlencode}&page={$pager_info['next_page']}">&gt;</a>
{-/if}
                                        
    </div>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!-- content -->
<div class="footer">
    <div class="foot-inner">
        <ul>
            <li>主办单位:中国互联网新闻中心 网络传播视听节目许可证号:0105123 京ICP证 040089号</li>
            <li>版权所有 中国互联网新闻中心 中国供应商(trade.china.cn)</li>
        </ul>
    </div>
</div>
<!-- footer -->
</body>
</html>