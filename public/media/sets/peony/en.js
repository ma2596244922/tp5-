/**
 *trade.china.cn
 *中国供应商英文站顶条处理代码
 *
 * @dependancy config.js
 * @package chinacn\resource_v2
 */
/* ----------------------------------------------------------------------------------------- */
/**
 * 中国供应商顶条英文站处理代码
 */
$(function() {
    var u = deterLogin($.cookie("EU"), "id"),
        logname = deterLogin($.cookie("EU"), "n"), //账户名
        contact = deterLogin($.cookie("EU"), "contact"), //联系人姓名
        usertype = deterLogin($.cookie("EU"), "usertype"), //买卖家类型
        lognfou = deterLogin($.cookie("EU"), "l"), //登录状态(1:登录 , 0:未登录)
        topBar = $("[data-name=topaBar]"),
        signin = $("[data-name=sign_in]"), //登录
        signout = $("[data-name=sign_out]"), //退出
        logspans = $("[data-name=loginname]"); //账户名
    shopsurl = $("[data-url=shopsurl]"); //商铺链接
    loading = $("[data-loading=loading]"); //加载中
    signin.hide();
    signout.hide();

    function onBar() {
        if (!topBar.length) {
            return
        } else {
            loading.hide();
            if (u == "" || u == undefined) {
                signin.show();
                signout.hide();
                logspans.html("Welcome to China Suppliers!")
            } else {
                if (lognfou == 0) {
                    signin.show();
                    signout.hide();
                    logspans.html("Welcome to China Suppliers!");
                } else {
                    signin.hide();
                    signout.show();
                    logspans.html(logname);
                    //判断是否登录

                    $.ajax({
                        type: "POST",
                        url: "//" + SUPPLIER_DOMAIN + "/ajaxapi.php?op=isLogin",
                        async: true,
                        dataType: "jsonp",
                        success: function(data) {
                            if (data.code == 0) {
                                signin.show();
                                signout.hide();
                                logspans.html("Welcome to China Suppliers!");
                                return;
                            } else if (data.code == 1) {
                                signin.hide();
                                signout.show();
                                logspans.html("<a href='//" + SUPPLIER_DOMAIN + "/index.php?op=index' target='_blank'>" + logname + "</a>");
                                shopsurl.attr({ href: data.storeUrl });
                            }
                        }
                    });

                }
            }
        }
    }

    function deterLogin(vl, name) {
        var self = this,
            cookiename = decodeURIComponent(vl),
            str = cookiename.split("&"),
            strValue;

        for (var i = 0; i < str.length; i++) {
            strValue = str[i].split("=");
            if (strValue[0] == name) {
                return strValue[1];
            }
        }
    }
    onBar();
});
