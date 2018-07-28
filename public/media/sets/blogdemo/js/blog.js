$(document).ready(function(){
    $('#blog_form').submit(function(){return false;});
    $('#blog_form input:submit').click(function(){
        if(global_obj.check_form($('*[notnull]'))){return false;};
        $('#blog_form input:submit').attr('disabled', true);

        $.post('?', $('#blog_form').serializeArray(), function(data){
            if (data.ret!=1){
                $('#blog_form input:submit').attr('disabled', false);
                global_obj.win_alert(data.msg);
            }else{
                global_obj.win_alert(data.msg, function(){
                    window.location=window.location.href;
                });
            }
        }, 'json');
    });
    
    $('.blog_review .icon_1').click(function (){//like
        var self = this;
        var rid = $(this).attr('rid');
        $.post('/', {do_action:'blog.blog_praise', RId:rid, type:1}, function (data){
            if (data.ret==1){//更新记录
                $(self).siblings('.num').html(data.msg);
            }else if (data.ret==0){
                global_obj.win_alert(data.msg);
            }
        }, 'json');
    });
    
    $('.blog_review .icon_2').click(function (){//unlike
        var self = this;
        var rid = $(this).attr('rid');
        $.post('/', {do_action:'blog.blog_praise', RId:rid, type:0}, function (data){
            if (data.ret==1){//更新记录
                $(self).siblings('.num').html(data.msg);
            }else if (data.ret==0){
                global_obj.win_alert(data.msg);
            }
        }, 'json');
    });
    
});