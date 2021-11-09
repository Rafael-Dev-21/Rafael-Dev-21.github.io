

$(window).onready(function() {
  $(window).bind("load", function() {
    $.webshim.polyfill();
  });
});