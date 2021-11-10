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
      set: (key, value) -> localStorage[key]: value
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