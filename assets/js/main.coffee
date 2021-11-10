---
---

$ ->
  $(window).bind 'load', ->
    $.webshim.polyfill()
  
  $('#muda-tema').on 'click', ->
    if $(this).hasClass 'tema-escuro'
      $('body').removeClass 'tema-escuro'
      $(this).text 'tema escuro'
    else
      $('body').addClass 'tema-escuro'
      $(this).text 'tema claro'