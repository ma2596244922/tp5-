/**
 *china.cn搜索相关Javascript代码包
 *
 **/
var Search = function(){

    // 配置项相关
    this._lang;               // en 英文 ； zh-cn 中文；
    this._btnText;            // 搜索按钮文本
    this._btnStyle;           // 搜索按钮样式
    this._cache;              // 是否显示缓存
    this._cacheNum;           // 缓存关键词最大值 10
    this._cacheUrl;           // 本地无缓存时ajax URL获取推荐关键词
    this._searchUrl;          // 搜索功能ajax URL获取搜索结果页URL

    // 搜索相关
    this._type;               // 搜索类型 4 =>产品  5=>公司 6=>图片 7=>询盘 
    this._key;                // 搜索关键词
    this._flag;               // 1:店铺搜索 0:全站搜索

    this._searchLog = [];     // 存放搜索记录数据
    this._cacheFlag;          // 1:缓存中有关键词

    this._creatHtml;          // 1:创建过dom结构

    this._firstLog = [];      // 存放首次推荐关键词数据

    this._recommendLog = [];  // 存放推荐关键词数据
    this._recommendFlag;      // 1:有推荐关键词 0:无推荐关键词

    this._currentLog = [];    // 存放匹配推荐关键词数据
    this._currentFlag; 

    this._noRecommend;       

    this._recommendNum = 0;   // cacheAjax请求的

    this._searchKey;          // 无匹配结果的临界值
    
    // 获取参数项
    this.setOption = function(obj){
        this._lang = obj.lang;
        this._btnText = obj.btnText;
        this._btnStyle = obj.btnStyle;
        // this._cache = obj.cache;
        this._cacheNum = obj.cacheNum;
        this._cacheUrl = obj.cacheUrl;
        this._searchUrl = obj.searchUrl;
    }
    
    // 初始化
    this.init = function(){

        // 1.取缓存搜索关键词
        this.getCache(); 

        // 2.取出推荐关键词
        this.getRecommend();

        // console.log('初始化显示（数组）缓存init：' + this._searchLog);
        // console.log('初始化显示推荐关键词历史' + this._recommendLog);

        // 3.节点遍历
        var self = this;
        var searchControls = $('[data-role="SearchControl"]');
        if (searchControls.length) {
            searchControls.each(function(index){

                var searchControl = searchControls.eq(index);
                     var inputTxt = searchControl.find('[data-role="SearchControl.InputKeywords"]'),
                        searchBtn = searchControl.find('[data-role="SearchControl.ButtonSearch"]'),
                         listType = searchControl.find('[data-role="SearchControl.ListType"]'),
                            allLi = searchControl.find('[data-role="SearchControl.ListType"] a'),
                         showSpan = searchControl.find('[data-role="SearchControl.Show"]'),
                       showParent = searchControl.find('[data-role="SearchControl.ShowParent"]');

                // 点击搜索类型下拉菜单
                allLi.click(function(){
                    // 获取配置 
                    var configString = $(this).data('config');
                    config = eval('('+ configString +')');

                    // 设置类型值 
                    searchControl.attr('data-type',config['type']);

                    // 设置placeholder 
                    inputTxt.attr('placeholder', config['placeholder']);
                    
                    // 控制效果 
                    showSpan.text($(this).text());
                    listType.css("display","none");
                    showParent.children('i').removeClass('current');
                    
                    // 设置placeholder 
                    inputTxt.attr('placeholder',config['placeholder']);
                })

                showParent.click(function(){
                    allLi.each(function(index){
                        if( $(this).text() == showSpan.text()){
                            $(this).hide().siblings().show();
                        }
                    })
                    listType.slideToggle('fast');
                    showParent.children('i').toggleClass('current');
                })
                
                // 点击搜索按钮，跳转到该搜索页面 
                searchBtn.on('click',function(){
                    // 获取搜索类型 
                    self._type = searchControl.attr('data-type');
                    
                    // 设置flag标志位，1:店铺搜索 0:全站搜索 
                    if($(this).attr('id') == 'shop_search' && showSpan.text() == 'On Site' ){
                        self._flag = 1;
                    }else{
                        self._flag = 0;
                    }

                    // 验证关键词 
                    self.validate(inputTxt);
                });
                
                // 按下enter键，跳转到该搜索页面
                inputTxt.keyup(function(event){
                    // 获取搜索类型 
                    self._type = searchControl.attr('data-type');
                    
                    if(showSpan.text() == 'On Site' ){
                        if(event.keyCode == 13){
                            self._flag = 1;
                            self.validate(inputTxt);
                        }
                    }else{
                        if(event.keyCode == 13){
                            self.validate(inputTxt);
                        }
                    }
                    // 搜索记录
                    self._cache = searchControl.attr('data-cache');
                    if(self._cache){
                        self.match(inputTxt)
                    }
                });

                // input获取焦点时判断是否存在cache
                inputTxt.focus(function(){
                    self._cache = searchControl.attr('data-cache');
                    if(self._cache){
                        self.match(inputTxt);
                    }
                })
            });
        }
    }
}

/**
 * 关键词过滤、校验
 * 英文站：
 * @todo 1.特殊字符过滤
 * @todo 2.非空校验、非中文校验
 * @todo 3.调用搜索方法
 * 中文站：
 */
Search.prototype.validate = function(inputTxt){
    this._key = $.trim(inputTxt.val());
    if(this._lang == 'en'){  // 英文站校验规则 
        // 特殊字符过滤
        this._key = this._key.replace(/[&\|\\\*^%$#@;:~\'\"\"\!￥\(\)]/g,' ');

        // 非空校验、非中文校验
        if(this._key == ''){
            alert("Please enter a keyword!");
            inputTxt.focus();
            return false;
        }else if(!this.valideChinese(this._key)){
            alert("Please input information in english only!");
            inputTxt.focus();
            return false;
        }

        // 调用搜索方法
        if(this._flag){
            // 店铺搜索
            this.shopSearch(this._key);
        }else{
            // 全站搜索
            this.ajax(this._key);
        }
    }else if(this._lang == 'zh-cn'){ // 中文站校验规则 
        console.log('中文验证');
    }
}

/**
 * 关键词非中文校验
 * @param {string} key
 * @returns {boolean}
 */
Search.prototype.valideChinese = function(key){
    var reg = /[\u4e00-\u9fa5]+/;
    if(reg.test(key)){
        return false;
    }else{
        return true;
    }
}

/**
 * 店铺搜索 
 * @todo 1.URL拼接获取跳转地址
 * @todo 2.缓存搜索关键词
 * @todo 3.location.href跳转
 */
Search.prototype.shopSearch = function(key){
    var sub = $('input[name="subdomain"]').val();
    if(subDomain == 'en'){
        var url = '//' + sub + '.'+ subDomain + DOMAIN_SUFFIX + '/product.html?keyword=' + encodeURIComponent(key) + '';
    }else{
        var url = window.location.pathname.split("/")[1];
        var url = "//trade"+DOMAIN_SUFFIX+"/"+ url +"/"+sub+"/product.html?keyword="+encodeURIComponent(key)+"";
    }
    this.saveCache(key);
    window.location.href = url;
}

/**
 * 搜索ajax请求
 * @todo 1.缓存搜索关键词
 * @todo 2.设置recommendFlag标志位，1:有 0:无
 * @todo 3.location.href跳转
 */
Search.prototype.ajax = function(key){
    var self = this;
    $.ajax({
        type: "POST",
        url: this._searchUrl,
        data: "key="+key+"&"+"entType="+this._type,
        async : true,
        dataType: "json",
        timeout: "5000",
        success: function(msg){
            // 缓存搜索关键词
            self.saveCache(key);
            // 设置recommendFlag标志位，1:有 0:无
            self._recommendFlag = 0;
            // location.href跳转
            window.location.href=msg;
        },
        error: function(){
            alert("当前访问用户较多，请稍后重试。");
            self.saveCache(key); //测试cache
            self._recommendFlag = 0;
        }
    })
}

/**
 * 缓存搜索关键词
 * @todo 1.条件判断，存储至：searchLog数组  条件：1.重复不存 2.至多10个（先进先出） 3.不区分大小写
 * @todo 2.searchLog数组存储至本地
 */
Search.prototype.saveCache = function(key){
    // 条件判断，存储至：searchLog数组
    if($.inArray(key.toLowerCase(), this._searchLog) == -1 && $.inArray(key.toUpperCase(), this._searchLog)){  // 关键词重复不存、不区分大小写
        if(this._searchLog.length < this._cacheNum){  // 至多存10个
            this._searchLog.push(key);
        }else{
            this._searchLog.shift();
            this._searchLog.push(key);
        }
    }

    // searchLog数组存储至本地
    if(window.localStorage){
        localStorage.setItem('searchLog',this._searchLog);
        // console.log('搜索词存储' + localStorage.getItem('searchLog'));
    }else{
        $.cookie('searchLog',this._searchLog, {
            'expires': 1,
            'path': '/', 
            'domain': ((typeof(COOKIE_DOMAIN)=='undefined')?'china.cn':COOKIE_DOMAIN)
        })
    }
}

/**
 * 取出缓存搜索关键词
 * @todo 1.获取本地搜索关键词，存储至：searchLog数组
 * @todo 2.设置cacheFlag标志位，1:有 0:无 
 */ 
Search.prototype.getCache = function(){
    if(window.localStorage){
        var datas = localStorage.getItem('searchLog');
    }else{
        var datas = $.cookie('searchLog');
    }

    if(datas){
        this._cacheFlag = 1;
        var dataArr = datas.split(',');
        for(var i = 0; i < dataArr.length; i++){
            this._searchLog.push(dataArr[i]);
        }
    }else{
        this._cacheFlag = 0;
    }
}

/**
 * 清空缓存搜索关键词（全部）
 */
Search.prototype.clearCache = function(){
    if(window.localStorage){
        localStorage.removeItem('searchLog');
    }else{
        $.removeCookie('searchLog');
    }
    this._searchLog = []; 
}

/**
 * 清空缓存中的搜索关键词（某个）
 */
Search.prototype.deleteKey = function(removeData){
    if(window.localStorage){
        this._searchLog.splice( $.inArray(removeData, this._searchLog),1);
        localStorage.setItem('searchLog',this._searchLog);
    }else{
        this._searchLog.splice( $.inArray(removeData, this._searchLog),1);
        $.cookie('searchLog',this._searchLog, {
            'expires': 1,
            'path': '/', 
            'domain': ((typeof(COOKIE_DOMAIN)=='undefined')?'china.cn':COOKIE_DOMAIN)
        })
    }
}

/**
 * 创建搜索记录dom节点
 */
Search.prototype.creatHtml = function(datas,inputTxt){
    var self = this;
    // 已存在html
    if(self._creatHtml){
        // 显示搜索记录层
        var searchCache = inputTxt.closest('ul').siblings('[data-role="searchCache"]');
        searchCache.show();
        // 缓存中有关键词
        if(self._cacheFlag){
            var sameData;
            $searchLog = $('[data-role="searchLog"]');
            $('[data-role="searchLog"] li').each(function(index){
                if($(this).children('span').text() == datas[datas.length-1]){
                    sameData = 1;  // 值无改变
                }else{
                    sameData = 0;
                }
            })
            // 删除推荐关键词
            $('[data-role="searchLog"] li.recommend').remove();
            
            // 值改变的情况，将搜索记录中的最后一个词加入到li中
            if(!sameData){
                $li = $('<li>');
                $span = $('<span>');
                $span.html(datas[datas.length-1]);
                console.log(datas[datas.length-1]);
                $li.append($span);

                $delete = $('<a href="javascript:;">');
                $delete.text('Delete');
                $li.append($delete);
                $delete.click(function(){
                    var removeData = $(this).siblings('span').text();
                    $(this).parent('li').remove();
                    self.deleteKey(removeData);
                });
                
                $searchLog.append($li);
                
                $li.hover(function(){
                    $(this).children('a').show();
                },function(){
                    $(this).children('a').hide();
                })

                $span.click(function(){
                    inputTxt.val($(this).text());
                    self.ajax($(this).text());
                })               
            }

            if(searchCache.find('[data-role="clearLog"]').length == 0){
                $clearLog = $('<div class="clearlog">');
                $clearLogBtn = $('<a data-role="clearLog" href="javascript:;">');
                $clearLogBtn.text('Clear History');
                $clearLog.append($clearLogBtn);
                $searchCache.append($clearLog);

                $clearLogBtn.click(function(){
                    self.clearCache();
                    $(this).parent().siblings('ul').children('li').remove();
                    $(this).parent().remove();
                    self.cacheAjax(inputTxt);
                })
            }
        }
        // 有推荐关键词
        if(self._recommendFlag){
            $searchLog = $('[data-role="searchLog"]');
            $('[data-role="searchLog"] li').remove();
            for(var i = 0; i < datas.length; i++){
                $li = $('<li class="recommend">');
                $span = $('<span>');
                $span.html(datas[i]);
                $li.append($span);
                $searchLog.append($li);

                $span.click(function(){
                    inputTxt.val($(this).text());
                    self.ajax($(this).text());
                })
            }
            if(self._searchLog.length == 0){
                searchCache.find('[data-role="clearLog"]').parent('div').remove();
            }
        }
    }else{
        // 不存在html
        if(self._cacheFlag || self._recommendFlag){
            $searchCache = $('<div class="searchcache" data-role="searchCache">');
            $recent = $('<div class="recent">');
            $recent.html('Recent Searches');
            $searchCache.append($recent);
            $searchLog = $('<ul class="searchlog" data-role="searchLog">');

            for(var i = 0; i < datas.length; i++){
                if(self._recommendFlag != 1){
                    $li = $('<li>');
                }else{
                    $li = $('<li class="recommend">');
                }
                
                $span = $('<span>');
                $span.html(datas[i]);
                $li.append($span);
                if(self._recommendFlag != 1){
                    $delete = $('<a href="javascript:;">');
                    $delete.text('Delete');
                    $li.append($delete);

                    $delete.click(function(){
                        var removeData = $(this).siblings('span').text();
                        $(this).parent('li').remove();
                        self.deleteKey(removeData);
                    });
                }
                
                $searchLog.append($li);

                $li.hover(function(){
                    $(this).children('a').show();
                },function(){
                    $(this).children('a').hide();
                })

                $span.click(function(){
                    inputTxt.val($(this).text());
                    self.ajax($(this).text());
                })
            }

            $searchCache.append($searchLog);

            if(self._recommendFlag != 1){
                $clearLog = $('<div class="clearlog">');
                $clearLogBtn = $('<a data-role="clearLog" href="javascript:;">');
                $clearLogBtn.text('Clear History');
                $clearLogBtn.click(function(){
                    self.clearCache();
                    $(this).parent().siblings('ul').children('li').remove();
                    $(this).parent().remove();
                    self.cacheAjax(inputTxt);
                })
                $clearLog.append($clearLogBtn);
                $searchCache.append($clearLog);
            }
            inputTxt.closest('[data-role="SearchControl"]').parent('div').append($searchCache);
        }
    }
}

/**
 * 本地无搜索记录时，ajax获取推荐关键词
 * @todo 1.设置cacheFlag标识位，1:有 0:无
 * @todo 2.设置recommendFlag标志位，1:有 0无
 * @todo 3.缓存搜索推荐关键词
 * @todo 4.展示搜索推荐关键词
 * @todo 5.设置creatHtml标志位，1:有 0:无
 */
Search.prototype.cacheAjax = function(inputTxt){
    var self = this;
    var searchKey = inputTxt.val();
    searchKey == 'undefined' ? '' : searchKey;
    $.ajax({
        type: "POST",
        url: this._cacheUrl,
        data: "w="+searchKey,
        async: true,
        dataType: "json",
        success: function(msg){
            if(msg.code == 0){
                self._cacheFlag = 0;
                self._recommendFlag = 1;
                if(searchKey == ''){
                    self.saveFirst(msg.result);
                }else{
                    self.saveRecommend(msg.result);
                }
                self.creatHtml(msg.result.slice(0,self._cacheNum),inputTxt);
                self._creatHtml = 1;
                console.log(msg.result);
            }else{
                console.log(msg.message);
                var searchCache = inputTxt.closest('ul').siblings('[data-role="searchCache"]');
                searchCache.hide();
                self._searchKey = searchKey;
            }
        },
        error: function(){
            self._cacheFlag = 0;    //测试recommend
            self._recommendFlag = 1;
            var key = ['afood','aoodb','ooafdc','afoodd','foode','oodf'];  
            self.saveRecommend(key);
            self.creatHtml(key,inputTxt);
            self._creatHtml = 1; 
        }
    })
}

/**
 * 超出匹配长度再次获取焦点时，防止ajax请求发送多次
 */
Search.prototype.noRecommend = function(inputTxt){ 
    if(inputTxt.val().indexOf(this._searchKey) == 0){
        return true;
    }else{
        return false;
    }
}

/**
 * 缓存初次搜索推荐关键词
 * 缓存条件：input内容为空
 */
Search.prototype.saveFirst = function(key){
    this._firstLog = key;
    if(window.localStorage){
        localStorage.setItem('firstLog',this._firstLog);
        // console.log('推荐关键词存储' + localStorage.getItem('recommendLog'));
    }else{
        $.cookie('firstLog',this._firstLog, {
            'expires': 1,
            'path': '/', 
            'domain': ((typeof(COOKIE_DOMAIN)=='undefined')?'china.cn':COOKIE_DOMAIN)
        })
    }
}

/**
 * 缓存搜索推荐关键词
 * 缓存条件：推荐关键词有变动
 */
Search.prototype.saveRecommend = function(key){
    // 推荐关键词有变动存储
    if(!this.isContained(this._recommendLog,key)){
        this._recommendLog = this._recommendLog.concat(key);
    }

    if(window.localStorage){
        localStorage.setItem('recommendLog',this._recommendLog);
        // console.log('推荐关键词存储' + localStorage.getItem('recommendLog'));
    }else{
        $.cookie('recommendLog',this._recommendLog, {
            'expires': 1,
            'path': '/', 
            'domain': ((typeof(COOKIE_DOMAIN)=='undefined')?'china.cn':COOKIE_DOMAIN)
        })
    }
}

/**
 * 判断推荐词是否存在于recommendLog中
 */
Search.prototype.isContained = function(arrA,arrB){
    if(!(arrA instanceof Array) || !(arrB instanceof Array)) return false;
    if(arrA.length < arrB.length) return false;
    var aStr = arrA.toString();
    for(var i = 0, len = arrB.length; i < len; i++){
       if(aStr.indexOf(arrB[i]) == -1) return false;
    }
    return true;
}

/**
 * 取出推荐关键词
 * @todo 1.获取本地推荐关键词，存储至：recommendLog数组
 */
Search.prototype.getRecommend = function(){
    if(window.localStorage){
        var datas = localStorage.getItem('recommendLog');
    }else{
        var datas = $.cookie('recommendLog');
    }

    if(datas){
        // this._recommendFlag = 1;
        var dataArr = datas.split(',');
        for(var i = 0; i < dataArr.length; i++){
            this._recommendLog.push(dataArr[i]);
        }
    }else{
        // this._recommendFlag = 0;
    }
}

/**
 * 匹配数据并展示
 * 
 */
Search.prototype.match = function(inputTxt){
    // 有缓存搜索关键词 
    if(this._searchLog.length > 0){
        // 1.设置cacheFlag标志位，1:有 0:无 
        this._cacheFlag = 1;
        // 2.展示
        this.creatHtml(this._searchLog,inputTxt);
        // 3.设置creatHtml标志位，1：有 0：无
        this._creatHtml = 1;
    }else{
        // 1.设置cacheFlag标志位，1:有 0:无 
        this._cacheFlag = 0;
        // 有本地推荐关键词
        if(this._recommendFlag){
            // 输入框值为空
            if(inputTxt.val() == ''){
                // 展示本地初次推荐关键词
                this.creatHtml(this._firstLog,inputTxt);
            }else{
                // 推荐关键词中搜索匹配关键词
                this.getCurrent(inputTxt);
                
                // 匹配关键词成功
                if(this._currentLog && this._currentLog.length > this._recommendNum){
                    // 设置currentFlag标志位，1：有 0：无
                    this._currentFlag = 1;
                    // 展示匹配关键词
                    this.creatHtml(this._currentLog.slice(0,this._cacheNum),inputTxt);
                }else{
                    // cacheAjax获取推荐关键词 条件：1.>=2个字母 2.延迟2s 3.ajaxing不发/排队
                    if( inputTxt.val().length >= 2 && this.valideChinese(inputTxt.val()) && this.noRecommend(inputTxt) != 1){
                        setTimeout(this.cacheAjax(inputTxt),2000);
                    }
                }
            }
        }else{
            if(( inputTxt.val() == '' || inputTxt.val().length >= 2) && this.valideChinese(inputTxt.val()) && this.noRecommend(inputTxt) != 1){
                setTimeout(this.cacheAjax(inputTxt),2000);
            }
        }
    }
}

/**
 * 推荐关键词中搜索匹配关键词
 * @todo 1.匹配关键词，存储至：currentLog数组
 */
Search.prototype.getCurrent = function(inputTxt){
    this._currentLog = [];
    for(var i = 0; i < this._recommendLog.length; i++){
        if(this._recommendLog[i].indexOf(inputTxt.val()) == 0 && $.inArray(this._recommendLog[i],this._currentLog) == -1){
            this._currentLog.push(this._recommendLog[i]);
        }
    }
}

/**
 * 控制搜索记录隐藏、搜索类型隐藏
 */
$(function(){
    $(document).bind('click',function(e){
        var target = $(e.target);
        if(target.attr('data-role') == 'SearchControl.InputKeywords'){
            return;
        }else{
            $('[data-role="searchCache"]').hide();
        }

        if(target.closest('li.select').length == 0){
            $('[data-role="SearchControl.ListType"]').hide();
            $('[data-role="SearchControl.ShowParent"]').children("i").removeClass("current");
        }
    })
})