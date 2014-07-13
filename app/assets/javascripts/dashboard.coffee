ready = ->
  if $('.dashboard.index').length > 0
    sort = ->
      $("#main .container-fluid .row").sortable()
      $("#main .container-fluid").sortable()
    sort()

$(document).ready ready
$(document).on 'page:load', ready
