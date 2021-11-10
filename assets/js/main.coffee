---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  
  tema = (Store.get 'tema') or 'claro'
  
  $('body').addClass "tema-#{tema}"
  $('#muda-tema').text "Tema #{tema}"
  
  $('#muda-tema').on 'click', ->
    $('body').toggleClass 'tema-claro tema-escuro'
    if tema == 'claro'
      tema = 'escuro'
    else
      tema = 'claro'
    $(this).text "Tema #{tema}"
    Store.set 'tema', tema