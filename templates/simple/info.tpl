{include file="simple/common/header.tpl"}
<body>
{include file="simple/common/top.tpl"}

<div class="Content Page">
{include file="simple/common/left.tpl"}

  <div class="Right">
    <h2 class="BoxTil">内容完整度 <span class="blue">100%</span></h2>
    <ul class="Integrity">
      <li class="cur"><span>3%</span>基本信息</li>
      <li><span>3%</span>图片信息</li>
      <li><span>3%</span>公司资料</li>
      <li><span>3%</span>公司简介</li>
    </ul>
    <p><i class="icon quest fr"></i>标记 <span class="red">*</span> 为必填项</p>
  </div>
  <div class="Main">
     <form action="?action=info" method="POST" enctype="multipart/form-data"> 
    <h2 class="BoxTil">公司信息</h2>
    <dl class="MainBox">
      <dt><span class="red">*</span> 基本信息</dt>
      <dd>
        <div class="Tr">
          <p class="ph">公司名称：</p>
          <input type="text" name="name" placeholder="填写公司名称" value="{$corporation.name}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">公司品牌：</p>
          <input type="text" name="brands" placeholder="填写公司品牌" value="{$corporation.brands}">
          <p class="error">请输入3-60字符</p>
        </div>
        <div class="Tr">
          <p class="ph">公司标语：</p>
          <input type="text" name="slogan" placeholder="填写公司标语" value="{$corporation.slogan}">
          <p class="error">请输入3-60字符</p>
          <i class="icon quest"><div>Tips提示信息<strong></strong></div></i>
        </div>
        <!-- <div class="Tr">
          <div class="btn add">新增关键词</div>
        </div> -->
      </dd>
    </dl>
    <dl class="MainBox">
      <dt>公司资料</dt>
      <dd>
        <div class="Tr">
          <dl class="SelectDL">
            <dt><p>
              {if $corporation.business_type neq ''}
                 {$corporation.business_type}
              {else}
                  公司类型
              {/if}

            </p><input type="hidden" name="business_type" value="{$corporation.business_type}"></dt>
            <dd>
              <ul>
                <li val="">请选择公司类型</li>
                <li val="Manufacturer">Manufacturer</li>
                <li val="Trading Company">Trading Company </li>
                <li val="Buying Office">Buying Office</li>
                <li val="Business Service">Business Service</li>
                <li val="Other">Other</li>
                         
              </ul>
            </dd>
          </dl>
          <dl class="SelectDL">
            <dt><p>
               {if $corporation.year_established neq ''}
                 {$corporation.year_established}
              {else}
                  成立时间
              {/if}
            </p><input type="hidden" name="year_established" value="{$corporation.year_established}"></dt>
            <dd>
              <ul>
                <li val="">请选择成立时间</li>
                {$years = range(1951,2018)}
                {foreach $years as $year}
                <li val="{$year}">{$year}</li>
                {/foreach}
              </ul>
            </dd>
          </dl>
          <dl class="SelectDL">
            <dt><p>
               {if $corporation.overseas_offices neq ''}
                 {if $corporation.overseas_offices eq 1}
                   Yes

                 {else}
                   No
                 {/if}
              {else}
                  海外办事处
              {/if}
            </p><input type="hidden" name="overseas_offices" value="{$corporation.overseas_offices}"></dt>
            <dd>
              <ul>
                <li val="">请选择海外办事处</li>
                <li val="0">No</li>
                <li val="1">Yes</li>
              </ul>
            </dd>
          </dl>
        </div>
        <div class="Tr">
          <dl class="SelectDL">
            <dt><p>
               {if $corporation.annual_sales neq ''}
                 {$corporation.annual_sales}
              {else}
                 年出口总额
              {/if}
            </p><input type="hidden" name="annual_sales" value="{$corporation.annual_sales}"> </dt>
            <dd>
              <ul>

                <li val="">请选择年出口总额</li>
                <li val="0 - $1 Million">0 - $1 Million</li>
                <li val="$1 Million - $5 Million">$1 Million - $5 Million</li>
                <li val="$5 Million - $20 Million">$5 Million - $20 Million</li>
                <li val="$20 Million - $100 Million">$20 Million - $100 Million</li>
                <li val="Above $100 Million">Above $100 Million</li>
                
              </ul>
            </dd>
          </dl>
          <dl class="SelectDL">
            <dt><p>
               {if $corporation.no_of_employees neq ''}
                 {$corporation.no_of_employees}
              {else}
                 业务员数量
              {/if}
            </p><input type="hidden" name="no_of_employees" value="{$corporation.no_of_employees}"></dt>
            <dd>
              <ul>
                <li val="">请选择业务员数量</li>
                <li val="1-15 People">1-15 People</li>
                <li val="15-50 People">15-50 People</li>
                <li val="50-100 People">50-100 People</li>
                <li val="Above 100 People">Above 100 People</li>
              </ul>
            </dd>
          </dl>
        </div>
      </dd>
    </dl>
    <dl class="MainBox">
      <dt>主要市场</dt>
         <dd>
          <input type="hidden" name="main_market" id="main_market">
        <ul class="checkboxList">
          <li>usa</li>
          <li>asia</li>
          <li>Africa</li>
          <li>eu</li>
          <li>japan</li>
        </ul>
      </dd>
    </dl>
    <dl class="MainBox">
      <dt><span class="red">*</span> 图片信息</dt>
      <dd>
        <div class="Tr pics" id="fileList">
            {if $corporation.logo neq false}
               <div  class="fl pic"><img src="{$corporation.logo|url:'enterprise_url_photo':'':'t'}"></div>
                  </div>
            {else}
              <div  class="fl pic"><img src="simple/images/default_pic.png"></div>
                  </div>
            {/if}
          
        <div class="Tr">
            <div class="Btn" id="filePicker">上传Logo</div>
          <p class="BtnTips fl">*建议220px * 60px,最大200K,最高100px</p>
       


        </div>
        <div class="Tr pics" >
          <div id="fileList1">

       

          {if $photos neq false}
              {foreach $photos as $photo}
                 <div class="fl pic"><img src="{$photo.uri|url:'enterprise_url_photo':'':'t'}"><div class="pMask" value="{$photo.id}"><button></button></div></div> 
              {/foreach}
          {else}
            <div class="fl pic default"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
            <div class="fl pic default"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
            <div class="fl pic default"><img src="simple/images/default_pic.png"><div class="pMask"><button></button></div></div>
          {/if}

          
          </div>
        </div>
        <div class="Tr">
          
           <label>
          <div class="Btn add" id="filePicker1">新增公司图片
            
          </div>
        </label>
          <p class="BtnTips fl">*建议220px * 60px,最大200K,最高100px</p>
        </div>
      </dd>
    </dl>
    <dl class="MainBox">
      <dt><span class="red">*</span> 公司简介</dt>
        <div id="editor">
        <p>{$corporation.introduction}</p>
    </div>
     <textarea id="intro" name="introduction" style="display:none;"></textarea>

   
    </dl>
    <input type="hidden" name="submit" value="update">
    <button class="submit">提交</button>
  </form>
  </div>
  <div class="clear"></div>
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


 var main_market = '{$corporation.main_market}';

  if(main_market !="")
  {
        main_market = JSON.parse(main_market);
        var hidden_main_market=Array();
        $(".checkboxList li").each(function(){
          var this_text = $(this).text();
            
            if(main_market.indexOf(this_text)!=-1)
            {
             $(this).addClass('ed');
              hidden_main_market.push($(this).text());
            }
        });
         $('#main_market').val(JSON.stringify( hidden_main_market ));

  }



$(".checkboxList li").click(function(){
  $(this).toggleClass('ed')
  var main_market=Array();
  $(".checkboxList li").each(function(){
      
      if($(this).hasClass('ed'))
      {
        main_market.push($(this).text());

      }
  });
  $('#main_market').val(JSON.stringify( main_market ));
  console.log($('#main_market').val());
  
})



</script>
<script type="text/javascript">
  
  // 初始化Web Uploader    

var uploader = WebUploader.create({

    // 选完文件后，是否自动上传。
    auto: true,

    // swf文件路径
    swf: '/webuploader/Uploader.swf',

    // 文件接收服务端。
    server: '?action=logo_corp_upload',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker',

    // 只允许选择图片文件。
    accept: {
        title: 'Images',
        extensions: 'gif,jpg,jpeg,bmp,png',
        mimeTypes: 'image/*'
    }
});
// 当有文件添加进来的时候
// <div class="fl pic"><img src="./images/default_pic.png"></div>
uploader.on( 'fileQueued', function( file ) {
    var $li = $(
            '<div id="' + file.id + '" class="fl pic file-item thumbnail">' +
                '<img>' +
            '</div>'
            ),
        $img = $li.find('img');


    // $list为容器jQuery实例
    $('#fileList').empty();
    $('#fileList').append( $li );

    // 创建缩略图
    // 如果为非图片文件，可以不用调用此方法。
    // thumbnailWidth x thumbnailHeight 为 100 x 100
    uploader.makeThumb( file, function( error, src ) {
        if ( error ) {
            $img.replaceWith('<span>不能预览</span>');
            return;
        }

        $img.attr( 'src', src );
    }, 100, 100 );
});
$('.webuploader-pick').css('background','#F5F5F5');
$('.webuploader-pick').css('color','#000');

$('.Btn').css('line-height','24px');
</script>

<script type="text/javascript">
  //
  var uploader1 = WebUploader.create({

    // 选完文件后，是否自动上传。
    auto: true,

    // swf文件路径
    swf: '/webuploader/Uploader.swf',

    // 文件接收服务端。
    server: '?action=photo_corp_upload',

    // 选择文件的按钮。可选。
    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
    pick: '#filePicker1',

    formData: {  
        type: 1 ,
        desc: 'corp desc'

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
            '<div id="' + file.id + '" class="fl pic file-item thumbnail">' +
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
$('.webuploader-pick').css('background','#F5F5F5');
$('.webuploader-pick').css('color','#000');

$('.Btn').css('line-height','20px');

</script>

<script type="text/javascript">
 {literal} 
  $(".pMask").on('click',function(){
       var photo_id =$(this).attr('value');
    
      $.ajax({
          url: "?action=delete_photo_ajax",
          dataType: 'json',
          type:"GET",  
          data: {"photo_id": photo_id},
          success:function(result){
            console.log(result);
            if(result.code==1)
            {
              alert("删除成功");
              window.location.reload();

            }
          }
      })
  })
  {/literal}
</script>
</body>
</html>