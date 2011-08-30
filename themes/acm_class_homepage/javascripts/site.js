$j(function(){ 
  $j('.slideshow').cycle({
    fx: 'fade',
    timeout: 7000,
    pager: "#pager"
  });
  $j('a').click(function(){ $j(this).blur(); });

/*  if ($.url.segment(0)) {
    $('.nav li.'+$.url.segment(0)).addClass('active');
  } else {
    $('.nav .home').addClass('active');
  }*/
});
