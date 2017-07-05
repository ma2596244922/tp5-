/*搜索选择框*/
$("#searchTab")
.mouseenter(function(){
  $(this).find('dd').show()
})
.mouseleave(function(){
  $(this).find('dd').hide()
})
.find('p').click(function(){
  $("#searchTab").find('dd').hide()
  $("#searchTab").find('dt').html($(this).html()+'<i class="icon arrow_down"></i>')
  
}).end()
//.find('dt').width($("#searchTab").find('dt').width()).end()
/*搜索框*/
$("#search").keyup(function(){
  if(this.value.length > 0){
  $("#search_msg").hide()
  $("#search_btn").removeClass('search_icon').addClass('search_icon_focus')
  }else{
  $("#search_msg").show()
  $("#search_btn").removeClass('search_icon_focus').addClass('search_icon')
  }
});
