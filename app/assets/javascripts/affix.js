$(window).scroll(function(){
  // Has the visitor scrolled down past the headmast?
  // If the headmast is 100 pixels tall, and
  // the visitor has scrolled down 115 pixels, then this will return true
  //
  $('#contact').css({
    top: $(window).scrollTop() + 'px'
  });
});
