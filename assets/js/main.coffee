---
# some metadata
---

(($) ->
  $ ->
    $(window).bind "load", ->
      $.webshim.polyfill()
) jQuery