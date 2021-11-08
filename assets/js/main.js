

$(window).onready(function() {
  $(window).bind("load", function() {
    setInterval(function pulselogo() {
      var tl = gsap.timeline();
      
      tl.to("#logo", {
        duration: .4,
        scale: 1.2,
        repeat: 3,
        repeatDelay: .4,
        yoyo: true,
        ease: "power2.inOut"
      });
      
      return tl;
    }, 5000);
    
    var master = gsap.timeline();
    master.add(pulselogo());
  });
});