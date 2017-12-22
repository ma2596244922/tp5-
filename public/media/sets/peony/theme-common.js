// JavaScript Document
$(function() {
    // 搜索 add by dulixia 2017-8-3
    var mySearch = new Search();
    var option = {
        lang : 'en' ,                    // en 为英文； zh-cn为中文
        btnText : 'searching',           // 搜索按钮禁用时文本
        btnStyle : { 
            backgroundColor : '#d20000'  // 搜索按钮禁用时样式
        },             
        // cache : true, // 是否开启本地缓存。  默认存储local storage； 不支持时存cookie
        cacheNum: 10, // 缓存关键词最大个数
        cacheUrl : '/common/animal/api_words.php', // 本地无记录 - 推荐关键词ajax请求地址
        searchUrl : '/common/trade/api.php7?action=generate_url' // 搜索ajax请求地址
    };
    mySearch.setOption(option);
    mySearch.init();
})

// 搜索相关 处理搜索类型定位
$(function(){
    var url = window.location.search;
    if (url == "") {
        return false;
    }
    var key = url.split("?")[1].split("=")[0];
    if (key == "keyword") {
        var letter = url.substring(9);
        var space = letter.indexOf(" ").length;
        if (space != -1) {}
        $('[data-role="SearchControl.InputKeywords"]').val(letter);
        $('[data-role="SearchControl.Show"]').text('On Site');
    }
})