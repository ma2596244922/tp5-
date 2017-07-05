(function(){
  $("#request_email,#request_con").keyup(function(){
    if(this.value.length > 0){
      $(this).prev('.msg').hide().parent().removeClass('error')
    }
  })
  var rules = []
  var email = new rule('request_email');
  email.add(['isEmpty:Please Enter Your Email Address','isEmail:false:Please Enter A valid Email Address'])
  var con = new rule('request_con');
  con.add(['isEmpty:Please Enter The content for your inquiry','min:20:Please enter at least 20 characters','max:500:Please enter up to 500 characters'])
  rules.push(email)
  rules.push(con)
  $("#request_email,#request_con").each(function(i,e){
    $(e).blur(function(){
      var s = rules[i].start()
      if(s!==true){
        $(this).prev('.msg').html(s).show().parent().addClass('error')
      }
    })
  })
})()

/*************************************************************************************/
/*预定义*/

//首页Banner轮换
var IndexBanner = function(parms,time,hideBtn){
  this.init(parms,time,hideBtn);
}
IndexBanner.prototype.init = function(parms,time,hideBtn) {
  var me = this;
  this.Prefix = '.'+parms+'_'
  this.mouseInPic = false;
  this.total = $(this.Prefix+"item").length;
  this.items = $(this.Prefix+"item");
  this.mouseStatus = false;
  this.t = typeof(time)!='undefined'?time:8000
  $(this.Prefix+'prev').click(function(){
    me.showPrev();
  });
  $(this.Prefix+'next').click(function(){
    me.showNext();
  });
  $(this.Prefix+"dot").mouseenter(function(){
    if(!$(this).hasClass("cur")){
      me.showExact($(this).index())
    }
  });
  this.items.eq(0).stop(true,true).fadeIn(500);
  this.show = 0;
  if(this.t != 0){
    var autoNext = setInterval(function(){
      if(!me.mouseInPic) me.showNext();
    },8000);//轮播图片间隔时间(ms)
  }

  $('.'+parms).mouseover(function(e){
    if(hideBtn) $(me.Prefix+"prev,"+me.Prefix+"next").stop(true,true).fadeIn(300);
    me.setMousState(true);
  }).mouseout(function(e){
    if(hideBtn) $(me.Prefix+"prev,"+me.Prefix+"next").hide();
    me.setMousState(false);
  });
};
IndexBanner.prototype.showPrev = function() {
  this.items.eq(this.show).hide();
  this.show--;
  this.show = this.show<0?this.total-1:this.show;
  this.showAct();
};
IndexBanner.prototype.showNext = function() {
  this.items.eq(this.show).hide();
  this.show++;
  this.show = this.show>=this.total?0:this.show;
  this.showAct();
};
IndexBanner.prototype.showExact = function(n) {
  this.items.eq(this.show).hide();
  this.show = n;
  this.showAct();
};
IndexBanner.prototype.showAct = function() {
  this.items.eq(this.show).fadeIn(2000).siblings().stop(true,true);
  $(this.Prefix+"dot").eq(this.show).addClass('cur').siblings().removeClass('cur');
}
IndexBanner.prototype.setMousState = function(b) {
  this.mouseInPic = b;
};
//首页Banner轮换 End



/*cur*/
var Cur = function(tag,list){
  this.init(tag,list);
}
Cur.prototype.init = function(tag,list) {
  tag.mouseenter(function(){
    var i = $(this).index()
    $(this).addClass('cur').siblings().removeClass('cur')
   list.eq(i).addClass('cur').siblings().removeClass('cur')
  });
}


