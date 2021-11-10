---
---

$(window).on 'load', ->
  $.webshim.polyfill()
  
  tema = (Store.get 'tema') or 'claro'
  
  $('#muda-tema').on 'click', ->
    setTema(outroTema tema)


window.Store: (->
  localStorageSupported: localStorage?

  createCookie: (name, value, days) ->
    if days
      date: new Date
      date.setTime(date.getTime() + (days*24*60*60*1000))
      expires: "; expires=" + date.toGMTString()
    else
      expires: ""
    document.cookie: name + "=" + value + expires + "; path=/"

  getCookie: (key) ->
    key: key + "="
    for c in document.cookie.split(';')
      c.substring(1, c.length) while c.charAt(0) is ' '
      return c.substring(key.length, c.length) if c.indexOf(key) == 0
    return null

  if localStorageSupported
    {
      set: (key) -> localStorage[key]: value
      get: (key) -> localStorage[key]
      expire: (key) -> localStorage.removeItem(key)
    }
  else
    {
      set: (key, value) -> createCookie(key, value, 1)
      get: getCookie
      expire: (key) -> createCookie(key, "", -1)
    }
)


outroTema = tema ->
  tema === 'claro' ? 'escuro' : 'claro'

setTema = tema ->
  $('body').addClass "tema-#{tema}"
  $('body').removeClass "tema-#{outroTema tema}"
  $('#muda-tema').text "tema #{tema}"
  Store.set 'tema', tema