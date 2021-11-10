---
---

$ ->
  $(window).bind 'load', ->
    $.webshim.polyfill()


$('#muda-tema').on 'click', ->
  $('body').toggleClass '.tema-claro .tema-escuro'
  $(this).text $('body').is '.tema-escuro' ? 'tema escuro' : 'tema claro'