<script type="text/javascript" src="simple/js/jquery.min.js"></script>
<script type="text/javascript" src="simple/js/prototype_create.js"></script>
<script type="text/javascript" src="simple/js/jquery.nicescroll.min.js"></script>
<script type="text/javascript" src="simple/js/plugins.js"></script>
<script type="text/javascript">
$(function(){
    $(".Left a.s3").click(function(){
        $(this).toggleClass("cur");
        $(this).next("ul").slideToggle();
    })
    $(".Left a.s11").click(function(){
        $(this).toggleClass("cur");
        $(this).next("ul").slideToggle();
    })
    $(".user-login").hover(function(){
        $(this).children("ul").slideDown("fast");
        $(this).children("i").addClass("cur");
    },function(){
        $(this).children("i").removeClass("cur");
        $(this).children("ul").hide();
    })
})
</script>