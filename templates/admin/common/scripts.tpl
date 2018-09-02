    <script src="media/js/jquery-1.10.1.min.js" type="text/javascript"></script>

    <script src="media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

    <script src="media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      

    <script src="media/js/bootstrap.min.js" type="text/javascript"></script>

    <!--[if lt IE 9]>

    <script src="media/js/excanvas.min.js"></script>

    <script src="media/js/respond.min.js"></script>  

    <![endif]-->   

    <script src="media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.blockui.min.js" type="text/javascript"></script>  

    <script src="media/js/jquery.cookie.min.js" type="text/javascript"></script>

    <script src="media/js/jquery.uniform.min.js" type="text/javascript" ></script>

    <script type="text/javascript" src="/media/vue/2.5.17/vue.min.js"></script>

    <script type="text/javascript">
        $('[data-role="btn-delete"]').click(function() {
            var href = $(this).data('href');
            if (!confirm('确认删除吗？'))
                return;

            location.href = href;
        });
    </script>

    <script type="text/javascript">
        $(function() {  
         /* 在textarea处插入文本--Start */  
         (function($) {  
         $.fn.extend({  
           insertAtCaret : function(myValue, t) {  
           var $t = $(this)[0];  
           if (document.selection) { // ie  
            this.focus();  
            var sel = document.selection.createRange();  
            sel.text = myValue;  
            this.focus();  
            sel.moveStart('character', -l);  
            var wee = sel.text.length;  
            if (arguments.length == 2) {  
            var l = $t.value.length;  
            sel.moveEnd("character", wee + t);  
            t <= 0 ? sel.moveStart("character", wee - 2 * t - myValue.length) : sel.moveStart( "character", wee - t - myValue.length);  
            sel.select();  
            }  
           } else if ($t.selectionStart  
            || $t.selectionStart == '0') {  
            var startPos = $t.selectionStart;  
            var endPos = $t.selectionEnd;  
            var scrollTop = $t.scrollTop;  
            $t.value = $t.value.substring(0, startPos)  
             + myValue  
             + $t.value.substring(endPos,$t.value.length);  
            this.focus();  
            $t.selectionStart = startPos + myValue.length;  
            $t.selectionEnd = startPos + myValue.length;  
            $t.scrollTop = scrollTop;  
            if (arguments.length == 2) {  
            $t.setSelectionRange(startPos - t,  
             $t.selectionEnd + t);  
            this.focus();  
            }  
           } else {  
            this.value += myValue;  
            this.focus();  
           }  
           }  
          })  
         })(jQuery);  
         /* 在textarea处插入文本--Ending */  
        });  
    </script>