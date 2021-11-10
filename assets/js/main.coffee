---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  
  tema = getCookie 'tema'
  
  tema = if tema? then tema else 'claro'
  
  $('body').addClass "tema-#{tema}"
  setNomeBotaoPorTema $('#muda-tema')
  
  $('#muda-tema').on 'click', ->
    $('body').toggleClass 'tema-claro tema-escuro'
    setNomeBotaoPorTema $(this)
    setTemaCookie()

setNomeBotaoPorTema = (botao) ->
  $(botao).text = if $('body').is '.tema-claro' then 'Tema Claro' else 'Tema Escuro'

setTemaCookie = ->
  tema = if $('body').is '.tema-claro' then 'claro' else 'escuro'
  createCookie 'tema', tema, null