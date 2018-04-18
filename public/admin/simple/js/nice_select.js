$(function(){
  $(".SelectDL").unbind().each(function(){
    var s=$(this);
    var z=parseInt(s.css("z-index"));
    var dt=$(this).children("dt");
    var dd=$(this).children("dd");
    var _show=function(){dd.slideDown(200);s.addClass("cur");s.css("z-index",z+1);};   //展开效果
    var _hide=function(){dd.slideUp(200);s.removeClass("cur");s.css("z-index",z);};    //关闭效果
    dt.unbind().click(function(){dd.is(":hidden")?_show():_hide();});
    dd.unbind().click(function(e){if(e.target.tagName=='LI'){if($(e.target).hasClass('disabled')){return false;};dt.children('p').html($(e.target).html()).removeClass('default').next('input').val($(e.target).attr('val'));_hide();}});     //选择效果（如需要传值，可自定义参数，在此处返回对应的“value”值 ）
    $("body").click(function(i){ !$(i.target).parents(".SelectDL").first().is(s) ? _hide():"";});
    dd.niceScroll({autohidemode:'leave'});
    $(this).mouseleave(function(){_hide();})
  })
})
function niceSelect(dom){
  var s=dom;
  var z=parseInt(s.css("z-index"));
  var dt=dom.children("dt");
  var dd=dom.children("dd");
  var _show=function(){dd.slideDown(200);s.addClass("cur");s.css("z-index",z+1);};   //展开效果
  var _hide=function(){dd.slideUp(200);s.removeClass("cur");s.css("z-index",z);};    //关闭效果
  dt.unbind().click(function(){dd.is(":hidden")?_show():_hide();});
  dd.unbind().click(function(e){if(e.target.tagName=='LI'){if($(e.target).hasClass('disabled')){return false;};dt.children('p').html($(e.target).html()).removeClass('default').next('input').val($(e.target).attr('val'));_hide();}});     //选择效果（如需要传值，可自定义参数，在此处返回对应的“value”值 ）
  $("body").unbind().click(function(i){ !$(i.target).parents(".SelectDL").first().is(s) ? _hide():"";});
  dd.niceScroll({autohidemode:'leave'});
  dom.mouseleave(function(){_hide();})
}