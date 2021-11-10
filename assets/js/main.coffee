---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  
  $('#muda-tema').on 'click', ->
    $('body').toggleClass 'tema-claro tema-escuro'
    if $('body').is 'tema-claro'
      $(this).text = 'Tema Claro'
    else
      $(this).text = 'Tema Escuro'