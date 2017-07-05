
/*表单验证*/
var strategies = {
  isEmpty : function(value,msg){
    var m = msg?msg:'请输入';
    if(value.length==0) return m;
    return true;
  },
  isNum: function(value,len,msg){
    var m = msg?msg:'';
    var trueValue = parseInt(value),Length = 1;
    for(var i=1;i<len;i++){
        Length+='0';
    }
    if(isNaN(trueValue)) return m;
    if(trueValue<parseInt(Length)) return m;
    return true;
  },
  min : function(value,len,msg){
    var m = msg?msg:'';
    if(value.length<len) return m;
    return true;
  },
  max : function(value,len,msg){
    var m = msg?msg:'';
    if(value.length>len) return m;
    return true;
  },
  len : function(value,len,msg){
    var m = msg?msg:'';
    if(value.length!=len) return m;
    return true;
  },
  isMobile : function(value,msg){
    var reg = /^0?1[3|4|5|6|7|8][0-9]\d{8}$/;
    var m = msg?msg:'格式不正确';
    if(!reg.test(value)) return m;
    return true;
  },
  isEmail : function(value,GapReg,msg){
    var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    if(!reg.test(value)){
      var m = msg?msg:'格式不正确';
      return m;
    }
    if(GapReg!='false'){
      if(GapReg.indexOf(value.replace(/\S*@/,''))==-1){
        var m = '请您输入QQ、163、126、sina、gmail等常用邮箱';
        return m;
      }
    }
    return true;
  },
  same : function(value,dom,msg){
    var m = msg?msg:'两次输入密码不一致';
    var re = $("#"+dom).val();
    if(value!=re) return m;
    return true;
  },
  isId : function(code,msg){
    var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
    var tip = "";
    var pass= true;
    if(code.length==0){
      tip = "请输入身份证号码";
      pass = false;
    }else if(!/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
      tip = "身份证号格式错误";
      pass = false;
    }else if(!city[code.substr(0,2)]){
      tip = "地址编码错误";
      pass = false;
    }else{
      //18位身份证需要验证最后一位校验位
      if(code.length == 18){
        code = code.split('');
        //∑(ai×Wi)(mod 11)
        //加权因子
        var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
        //校验位
        var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
        var sum = 0;
        var ai = 0;
        var wi = 0;
        for (var i = 0; i < 17; i++)
        {
          ai = code[i];
          wi = factor[i];
          sum += ai * wi;
        }
        var last = parity[sum % 11];
        if(parity[sum % 11] != code[17]){
          tip = "校验位错误";
          pass =false;
        }
      }
    }
    if(!pass){
      return tip;
    }else{
      return pass;
    }
  },
  isUrl : function(value,msg){
    var reg = /^(http|https):\/\/(([A-Z0-9][A-Z0-9_-]*)(\.[A-Z0-9][A-Z0-9_-]*)+)/i
    value = value.indexOf('http://')>-1?value:'http://'+value
    if(!reg.test(value)){
      var m = msg?msg:'请输入正确的';
      return m;
    }
    return true;
  },
  isBlogUrl : function(value,msg){
    if(value.length>0 && value.indexOf('.')==-1){
      return msg?msg:'请输入正确的';
    }
    return true;
  },
  isNumber: function(value,msg){
    var len = value.length,
    val = parseInt(value)
    if(isNaN(val)||val.toString().length!=len){
      return msg?msg:'必须是数字';
    }
    return true
  }
}


//依赖于 prototype_create.js || prototype.js
var rule = Class.create();
rule.prototype.initialize = function(dom){
  this.dom = dom;
  this.events = [];
}
rule.prototype.add = function(rules){
  this.rules = rules;
  var me = this;
  for(var i=0,rule;rule = rules[i++];){
    (function(rule){
      me.events.push(function(v){
        var sAry = rule.split(':');
        var ruleName = sAry.shift();
        sAry.unshift(v);
        return strategies[ruleName].apply(me,sAry);
      });
    })(rule);
  }
}

rule.prototype.start = function(){
  var value = $.trim($("#"+this.dom).val());
  for(var i=0,rFun;rFun = this.events[i++];){
    var status = rFun(value);
    if(status!=true) return status;
    if(this.rules.join(',').search('isEmpty:true')>-1&&value=='') break;
  }
  return true;
}

/*
* 批量验证
* By Ravens @ 2015-12-16
*/
function BatchCheck(ds,fn){
  var datas = {};
  for(var i=0,d;d=ds[i++];){
    var dom = d[0];
    var r = new rule(dom);
    r.add(d.slice(1));
    var status = r.start();
    var Dom = $("#"+dom);
    if(fn&&typeof(status)=='string') fn(status,Dom)
    // if(status!=true){
    //   return status;
    // }
    datas[Dom.attr('name')] = Dom.val();
  }
  return datas;
}

/*
* 发送验证码倒计时
* By Ravens @ 2015-12-15
*/
function countdown(){
  var s = 60;
  var btn = this;
  btn.addClass('gray').text('重新发送校验码('+s+')');
  var djs = setInterval(function(){
    s--;
    btn.text('重新发送校验码('+s+')');
    if(s==0){
      clearInterval(djs);
      btn.text('重新发送校验码').removeClass('gray');
    }
  },1000);
  return djs
}

//设置COOKIE
function setCookie(name, value, iDay) {
    var oDate = new Date();
    oDate.setTime(oDate.getTime() + iDay*1000); 
    var dateStr = ( iDay == 0 ) ? '' : ';expires='+oDate.toGMTString();
    document.cookie = name+'='+value+dateStr+';path=/';
}
//获取cookie
function getCookie(name) {
  var arr = document.cookie.split('; ');
  var i = 0;
  for(i=0; i<arr.length; i++) {
    var arr2 = arr[i].split('=');
    if(arr2[0] == name) {return arr2[1];}
  }
  return '';
}
//删除cookie
function removeCookie(name) {
  setCookie(name,'',-1);
}