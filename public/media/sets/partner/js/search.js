$("#search-btn").click(function(){
    searchMe();
    })
$('#search-txt').bind('keyup', function(event) {
        if (event.keyCode == "13") {
            //回车执行查询
            searchMe();
        }
    });
//过滤空格
String.prototype.ResetBlank=function(){
    var regEx = /\s+/g; 
    return this.replace(regEx, '-'); 
};
function searchMe(){
    var search_txt=$("#search-txt");
    var txt_value=search_txt.val();
    txt_value = txt_value.replace(/[`~!@#$%^&*()_+<>?:"{},-=.\/;'[\]]/g,' ');//特殊字符边空格
    txt_value=txt_value.replace(/(^\s*)|(\s*$)/g, "");//去掉前后空格
    txt_value=txt_value.toLowerCase();//大写变小写
    txt_value=txt_value.ResetBlank();//空格变-
    if(txt_value==""){
        alert("Please enter your keywords!");
        return false;
            }
    //获取地址
    var url="http://www.lldpestretch-film.com/s-"+txt_value+".html";
    window.location.href=url;
    }