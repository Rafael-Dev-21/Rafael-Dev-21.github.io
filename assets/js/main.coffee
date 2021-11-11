---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  
  tema = getCookie 'tema'
  
  tema = if tema? then tema else 'claro'
  
  if tema == 'escuro'
    $('body').addClass "tema-escuro"
  setNomeBotaoPorTema $('#muda-tema')
  
  $('#muda-tema').on 'click', ->
    $('body').toggleClass 'tema-escuro'
    setNomeBotaoPorTema $(this)
    setTemaCookie()

setNomeBotaoPorTema = (botao) ->
  $(botao).text if $('body').is '.tema-escuro' then 'Tema Claro' else 'Tema Escuro'

setTemaCookie = ->
  tema = if $('body').is '.tema-claro' then 'claro' else 'escuro'
  createCookie 'tema', tema, null