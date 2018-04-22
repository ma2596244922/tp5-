
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>产品发布</title>
  <link rel="stylesheet" type="text/css" href="simple/style.css">
  <script type="text/javascript" src="simple/js/jquery.min.js"></script>
  <script type="text/javascript" src="simple/js/prototype_create.js"></script>
  <script type="text/javascript" src="simple/js/jquery.nicescroll.min.js"></script>
  <script type="text/javascript" src="simple/js/plugins.js"></script>
  <script type="text/javascript" src="webuploader/webuploader.js"></script>
</head>
<body>

<div class="Top">
  <div class="Page">
    <h1 class="logo fl"><a href="">　　　　　　　　　　　</a></h1>
    <div class="userInfo fr">
      <img src="./images/tmp/head1.jpg">
      <span>Hello,David</span>
    </div>
  </div>
</div>
<div class="Content Page">
  <div class="Left">
    <a href="" class="s1"><i></i>首页</a>
    <a href="" class="s2"><i></i>询盘中心</a>
    <a href="" class="s3 cur"><i></i>产品管理<i class="more"></i></a>
    <a href="" class="s4"><i></i>公司管理</a>
    <a href="" class="s5"><i></i>新闻中心</a>
    <a href="" class="s6"><i></i>图片中心</a>
    <a href="" class="s7"><i></i>Banner管理</a>
    <div class="line"></div>
    <a href="" class="s8"><i></i>Webmaster验证</a>
    <a href="" class="s9"><i></i>页面代码</a>
    <a href="" class="s10"><i></i>SEO设置</a>
    <div class="qrcode tc">
      <p>创业不易·我要打赏</p>
      <img src="./images/qrcode.png">
    </div>
  </div>
  <div class="Right">
    <h2 class="BoxTil">内容完整度 <span class="blue">100%</span></h2>
    <ul class="Integrity">
      <li class="cur"><span>3%</span>基本信息</li>
      <li><span>3%</span>产品图片</li>
      <li><span>3%</span>产品属性</li>
      <li><span>3%</span>交易信息</li>
      <li><span>3%</span>产品描述</li>
    </ul>
    <p><i class="icon quest fr"></i>标记 <span class="red">*</span> 为必填项</p>
  </div>
  <div class="Main">
    <h2 class="BoxTil">产品信息</h2>
    <form action="?action=edit_product&product_id={$product_id}" method="POST" enctype="multipart/form-data" class="form-horizontal" id="form-edit-product">
    <dl class="MainBox">
      <dt><span class="red">*</span> 基本信息</dt>
      <dd>
        <div class="Tr ">
          <p class="ph">公司名称：</p>
          <input type="text" name="caption" value="{$product.caption|default:''}">
          
          <i class="icon quest"><div>Tips提示信息<strong></strong></div></i>
        </div>
        <div class="Tr">
          <dl class="SelectDL fl" style="width:300px;">
            <dt>
              <p id="group_name">
                {if !empty($product.group_id) }
                  {foreach $groups as $group}
                    {if $group.id==$product.group_id}
                      {$group.name}
                    {/if}
                  {/foreach}
                {else}
                产品分组
                {/if}
              </p>
              <input type="hidden" name="group_id" value="{$product.group_id}"></dt>
            <dd>
              <ul id="group">
                {section name=i loop=$groups}{assign var="gid" value={$groups[i].id|default:$groups[i].group_id}}
                <li val="{$gid}">{$groups[i].name}</li>
                {/section}
                
              </ul>
            </dd>
          </dl>

          <div class="Btn add" id="appendGroup">新建分组</div>
        </div>
        <div class="Tr">
          <p class="ph">
            关键词：
            
          </p>
          <input type="text" name="tags" value="{$product.tags}">
          <i class="icon quest"><div>Tips:多关键字使用,分割<strong></strong></div></i>
        </div>
        <!--<div class="Tr">
          <div class="Btn add">新增关键词</div>
        </div>-->
      </dd>
    </dl>
    <dl class="MainBox">
      <dt><span class="red">*</span> 产品图片 <span class="f12">(*建议使用 1:1 比例，600像素以上，按住图片可以调整默认图片和图片顺序)</span></dt>
      <dd>

        <div id="fileList1" class="Tr pics pics2">

       
          {if isset($product_images)}
              {foreach  $product_images  as $image_id}
                 <div class="fl pic pic2">
                  <img src="{$image_id|default:''|url:'enterprise_url_image':{$product.caption|default:''}:'c'}">
                  <div class="pMask" value="{$image_id}">
                    <button></button>
                  </div>
                </div> 
                <input type="hidden" name="images[]" value ="{$image_id}">
              {/foreach}
          {else}
            <div class="fl pic pic2 default"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
            <div class="fl pic pic2 default"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
            <div class="fl pic pic2 default"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
          {/if}

          
          </div>
          <!--
        <div class="Tr pics pics2">
          <div class="fl pic pic2"><img src="./images/default_pic2.png"><div class="pMask"><button></button></div></div>
          <div class="fl pic pic2"><img src="./images/default_pic2.png"><div class="pMask"><button></button></div></div>
          <div class="fl pic pic2"><img src="./images/default_pic2.png"><div class="pMask"><button></button></div></div>
          <div class="clear"></div>
        </div>-->
        <div class="Tr" >
            <label>
           <div class="Btn add" id="filePicker1">新增公司图片
            
            </div>
          </label>
         <!-- <div class="Btn add">新增产品图片</div>-->
        </div>
      </dd>
    </dl>
    <dl class="MainBox font2">
      <dt>产品属性</dt>
      <dd>
        <div class="Tr">
          <p class="ph">品牌：</p>
          <input type="text" name="brand_name" value="{$product.brand_name}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">型号：</p>
          <input type="text" name="model_number" value="{$product.model_number}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">证书：</p>
          <input type="text" name="certification" value="{$product.certification}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">产地：</p>
          <input type="text" name="place_of_origin" value="{$product.place_of_origin}">
          <p class="error">请输入3-60字符</p>
        </div>

        {if isset($product_specifications)}{foreach $product_specifications as $s}
        <div class="Tr font3" id="itemAttr">
          <div class="fl name">
            <p class="ph">属性名：</p>
            <input type="text" name="attr_keys[]" value="{$s@key}">
            <p class="error">请输入3-60字符</p>
          </div>
          <div class="fl value">
            <p class="ph">属性值：</p>
            <input type="text" name="attr_values[]" value="{$s}">
            <p class="error">请输入3-60字符</p>
          </div>
          <button class="del" type="button"></button>
        </div>

        {/foreach}{/if}
        <div class="Tr">
          <div class="Btn add" id="addAttr">新增产品属性</div>
        </div>
      </dd>
    </dl>
    <dl class="MainBox">
      <dt>交易信息</dt>
      <dd>
        <div class="Tr font5">
          <p class="ph">最小起订单：</p>
          <input type="text" placeholder="【示例：1ton】" name="min_order_quantity" value="{$product.min_order_quantity}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr font2">
          <p class="ph">价格：</p>
          <input type="text" placeholder="【示例：$1 ~ $1000】" name="price" value="{$product.price}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">付款方式：</p>
          <input type="text" placeholder="【示例：点击右侧选择】" name="input-payment-terms" value="{$product.input-payment-terms}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">供货能力：</p>
          <input type="text" placeholder="【建议：数量 + 计量单位 + per 时间单位】" name="supply_ability"
           value="{$product.supply_ability}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">发货期限：</p>
          <input type="text" placeholder="【示例：7-10 Days】" name="delivery_time" value="{$product.delivery_time}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">常规包装：</p>
          <input type="text" placeholder="【建议：包装形式、尺寸，各类集装箱能装载的产品件数等信息】" name="packaging_details" value="{$product.packaging_details}">
          <p class="error">请输入3-60字符</p>
        </div>
      </dd>
    </dl>
    <dl class="MainBox">
      <dt><span class="red">*</span>产品描述</dt>
      <dd>
         <div id="editor">
        <p>{$product.description}</p>
    </div>
     <textarea id="intro" name="description" style="display:none;"></textarea>

      </dd>
    </dl>
    <input type="hidden" name="submit" value="1">
    <button class="submit" >提交</button>
  </form>
  </div>
  <div class="clear"></div>
</div>

<div class="mask" id="appendGroupDiv">
  <div class="main">
    <p class="tit fl">添加分组</p>
    <button class="close fr closeBtn">x</button>
    <div class="clear"></div>
    <div class="Tr font6">
      <p class="ph">输入分组名称：</p>
      <input type="text">
      <p class="error">请输入3-60字符</p>
    </div>
    <div class="btns">
      <button class="submit">提交</button>
      <button class="cancel closeBtn">取消</button>
    </div>
  </div>
</div>

<script type="text/javascript" src="simple/js/nice_select.js"></script>
<script type="text/javascript" src="wangEditor-3.1.1/release/wangEditor.min.js"></script>

    <script type="text/javascript">
        var E = window.wangEditor
        var editor = new E('#editor')

        var $intro = $('#intro')
        editor.customConfig.onchange = function (html) {
            // 监控变化，同步更新到 textarea
            $intro.val(html)
        }


        editor.customConfig.showLinkImg = false
        //editor.customConfig.debug = location.href.indexOf('wangeditor_debug_mode=1') > 0
        // editor.customConfig.uploadImgShowBase64 = true   // 使用 base64 保存图片
        editor.customConfig.uploadImgServer = '?action=upload_image_wang'
        editor.create()
        $intro.val(editor.txt.html())
    </script>
<script type="text/javascript">

{literal} 
$(".checkboxList li").click(function(){
  $(this).toggleClass('ed')
})

$("#addAttr").click(function(){
  var item = $("#itemAttr").clone().removeAttr('id')

  $(this).parent().before(item)
  item.find('input').val("")
  item.find('button').click(function(){item.remove()})
})
$("#itemAttr").find('button').click(function(){alert('默认属性不能删除')})

$("#appendGroup").click(function(){
  $("#appendGroupDiv").fadeIn(500)
})
$("#appendGroupDiv").find('.submit').click(function(){
  var v = $("#appendGroupDiv").find('input').val()
  if(v!=''){
 
      $.ajax({
          url: "?action=edit_group_ajax&group_id=0",
          dataType: 'json',
          type: 'POST',
          data: {"name":v,"submit":"edit_group_ajax"},
          success:function(result){
            if(result.code==1)
            {
              $("#group").prepend('<li val="'+v+'">'+v+'</li>')
              $("#appendGroupDiv").fadeOut(500).find('input').val('')
              $('#group_name').text(v);

              
        
            }else{
              alert(result.msg);
            }
           
          }
      })

  }else{
    alert('请输入分组名称')
  }
}).end().find('.closeBtn').click(function(){
  $("#appendGroupDiv").fadeOut(500).find('input').val('')
})
{/literal}
</script>

<script type="text/javascript">
  //
  var uploader1 = WebUploader.create({

    // 选完文件后，是否自动上传。
    auto: true,

    // swf文件路径
    swf: '/webuploader/Uploader.swf',

    // 文件接收服务端。
    server: '?action=product_photo_upload_ajax',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker1',

    formData: {  
        type: 1 ,
        desc: 'product desc'

    },
    fileNumLimit:3-{count($photos)},

    // 只允许选择图片文件。
    accept: {
        title: 'Images',
        extensions: 'gif,jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    }
});
// 当有文件添加进来的时候
// <div class="fl pic"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
uploader1.on( 'fileQueued', function( file ) {
    var $li = $(
            '<div id="' + file.id + '" class="fl pic pic2 file-item thumbnail">' +
                '<img>' +
            '<div class="pMask"><button></button></div></div>'
            ),
        $img = $li.find('img');


    // $list为容器jQuery实例
       $('.default').hide();
       $('#fileList1').append( $li );

    // 创建缩略图
    // 如果为非图片文件，可以不用调用此方法。
    // thumbnailWidth x thumbnailHeight 为 100 x 100
    uploader1.makeThumb( file, function( error, src ) {
        if ( error ) {
            $img.replaceWith('<span>不能预览</span>');
            return;
        }

        $img.attr( 'src', src );
    }, 100, 100 );
});

uploader1.on('uploadSuccess',function(file,response){
   if(response instanceof Array)
    {
       $('#'+file.id).after(
            '<input type="hidden" name="images[]" value ="'+response[0]+'">'
        )
    }   

});
$('.webuploader-pick').css('background','');
$('.webuploader-pick').css('color','#000');

</script>
</body>
</html>