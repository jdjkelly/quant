ready = ->
  if $('.meals.index').length > 0
    $ ->
      $.plot "#meals-chart", [{
        data: window.mealCalories,
        bars: { show: true }
      }],
        colors: [
          '#1B2440'
        ],
        xaxis:
          mode: "time"
          timeformat: "%b %d"
        grid:
          show: true
          color: '#333'
          borderWidth: 0
          clickable: true
          hoverable: true
          autoHighlight: true

$(document).ready ready
$(document).on 'page:load', ready
