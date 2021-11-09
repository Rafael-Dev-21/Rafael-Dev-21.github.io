---
---

(($) ->
  $ ->
    $(window).bind "load", ->
      $.webshim.polyfill()
) jQuery