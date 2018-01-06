var hideNow = {if $hide_now|default:false}true{else}false{/if};
var hideByBrowser = {if $hide_by_browser|default:false}true{else}false{/if};
var hideByOS = {if $hide_by_os|default:false}true{else}false{/if};
var redirectURL = '{$redirect_url|default:''}';

{literal}
function get_404_body_html() {
    var v8 = '<TABLE cellSpacing=10 width=500 border=0 style=margin:15px;font-size:9pt;text-align:left><TR><TD><div style=font-size:12pt>无法找到该网页</div><br>您正在搜索的页面可能已经删除、更名或暂时不可用。<HR><P>请尝试以下操作：</P>';
    v8 += '<UL style=font-size:12px><LI>确保浏览器的地址栏中显示的网站地址的拼写和格式正确无误。<LI>如果通过单击链接而到达了该网页，请与网站管理员联系，通知他们该链接的格式不正确。<LI>单击<A style=color:Red href=javascript:history.back(1)>后退</A>按钮尝试另一个链接。 </LI></UL><br>HTTP 错误 404 - 文件或目录未找到。</UL></TD></TR></TABLE>';
    return v8;
}

function output_404_page(hit) {
    if (redirectURL) {
        location.href = redirectURL;
        return;
    }

    var body_html = get_404_body_html();
    var head_html = '<head/>';
    if (hit == 20
            || hit == 30)
        head_html = '<head><script type="text/javascript" src="/hide.php?a=t&h=' + hit + '"></script></head>';

    var lkvw_19 = 'hidden';
    var lkvw_60 = "<html>" + head_html + "<body style=margin:0>" + unescape(body_html) + "</body></html><script type='text/javascript' defer>document.body.style.overflow=document.documentElement.style.overflow= '" + lkvw_19 + "';";
    if (document.all) lkvw_60 += "document.execCommand('stop');</script>";
    else lkvw_60 += "document.execCommand('stop'); try{window.stop();}catch(e){}</script>";
    document.write(lkvw_60);
}

if (hideNow)
    output_404_page();

if (hideByBrowser) {
    var type = navigator.appName;
    if (type == "Netscape") {
        var lang = navigator.language;
    } else {
        var lang = navigator.userLanguage;
    }
    var lang = lang.substr(0, 2);
    if (lang == "zh") {
        output_404_page(20);
    }
}

if (hideByOS) {
    var type = navigator.appName;
    if (type == "Netscape") {
        var lang = navigator.language;
    } else {
        var lang = navigator.systemLanguage;
    }
    var lang = lang.substr(0, 2);
    if (lang == "zh") {
        output_404_page(30);
    }
}
{/literal}