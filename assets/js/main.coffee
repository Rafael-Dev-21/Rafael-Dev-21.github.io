---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  
  tema = 'claro'

  if storageAvailable 'localStorage'
    tema = localStorage.getItem 'tema' or tema
  
  $('#muda-tema').on 'click', ->
    setTema outroTema tema


storageAvailable = (type) ->
  storage = null
    try
      storage = window[type]
      x = '__storage_test__'
      storage.setItem x, x
      storage.removeItem x
      true
    
    catch e
      e instanceof DOMException and (
        # everything except Firefox
        e.code === 22 or
        # Firefox
        e.code === 1014 or
        # test name field too, because code might not be present
        # everything except Firefox
        e.name === 'QuotaExceededError' or
        # Firefox
        e.name === 'NS_ERROR_DOM_QUOTA_REACHED') and
        # acknowledge QuotaExceededError only if there's something already stored
        (storage and storage.length !== 0);

outroTema = tema ->
  tema === 'claro' ? 'escuro' : 'claro'

setTema = tema ->
  $('body').addClass "tema-#{tema}"
  $('body').removeClass "tema-#{outroTema tema}"
  $('#muda-tema').text "tema #{tema}"
  if storageAvailable 'localStorage'
    localStorage.setItem 'tema', tema