<script type="text/javascript" src="/media/sets/brilly/jquery.min.js"></script>
<script type="text/javascript" src="/media/sets/brilly/prototype_create.js"></script>
<script type="text/javascript" src="/media/sets/brilly/plugins.js"></script>

<script type="text/javascript" src="/media/sets/brilly/header.js"></script>
<script type="text/javascript" src="/media/sets/brilly/index.js"></script>

<script type="text/javascript">{literal}
(function(){
  $("#quickSelect").click(function(e){
    $(this).children('dd').show()
  }).click(function(e){
    if(e.target.tagName != 'P') return false;
    var inner = $(e.target).html()
    $("#request_con").val(inner).prev('.msg').hide();
    $(this).children('dd').hide()
    $(this).children('dt').html(inner+'<i class="icon arrow_down2"></i>').addClass('cur')
  }).mouseleave(function(){
    $(this).children('dd').hide()
  })
  $("#request_email,#request_con,#Subject").keyup(function(){
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
      if(s==true){
        $(this).prev('.msg').html(s).show().parent().removeClass('error')
      }
    })
  });
  $('[data-role="inquiry-form"]').on('submit', function(e) {console.log(e);
    for(var i=0; i<rules.length; ++i) {
      var s = rules[i].start();
      if(s!==true){
        $('#' + rules[i].dom).prev('.msg').html(s).show().parent().addClass('error');
        e.preventDefault();
      }
    }
  });
})()
$("#productsSearch").keyup(function(){
  console.log(this.value.length)
  if(this.value.length > 0){
    $(this).next('i').addClass('focus')
    return false;
  }
  $(this).next('i').removeClass('focus')
});
</script>{/literal}