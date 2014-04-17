ready = ->
  if $('.weights.index').length > 0
    `$(function() {

      $.plot("#weights-chart", [{
        data: window.interpolatedWeights,
        points: { show: true }
      }, {
        data: window.weights,
        points: { show: true }
      }], {
        colors: [
          '#DDD', '#1B2440'
        ],
        xaxis: {
          mode: "time",
          timeformat: "%b %d"
        },
        grid: {
          show: true  ,
          color: 'transparent',
          borderWidth: 0,
          clickable: true,
          hoverable: true,
          autoHighlight: true
        }
      });
    });`

$(document).ready ready
$(document).on 'page:load', ready
