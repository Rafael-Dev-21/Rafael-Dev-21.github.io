---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  $('#muda-tema').on 'click', ->
    $('body').toggleClass 'tema-claro tema-escuro'
    if $('body').is '.tema-escuro'
      $(this).text 'tema escuro'
    else
      $(this).text 'tema claro'