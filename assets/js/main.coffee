---
---

$ ->
  $(window).bind 'load', ->
    $.webshim.polyfill()
    
  claro = true
  
  $('#muda-tema').on 'click', ->
    if claro 
      $('body').addClass 'tema-escuro'
      $(this).text 'tema escuro'
      claro = false
    else
      $('body').removeClass 'tema-escuro'
      $(this).text 'tema claro'
      claro = true