---
---

$(window).on 'load', ->
  $.webshim.polyfill()

window.toggleTheme = ->
  if $('body').hasClass 'tema-claro'
    $('body')
      .removeClass 'tema-claro'
      .addClass 'tema-escuro'
    $(this).text 'tema escuro'
  else
    $('body')
      .removeClass 'tema-escuro'
      .addClass 'tema-claro'
    $(this).text 'tema claro'