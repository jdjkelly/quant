ready = ->
  if $('.weights.index').length > 0
    `$(function() {
      $.plot("#weights-chart", [{
        data: window.weights,
        lines: { show: true, lineWidth: 5 }
      },{
        data: window.weights,
        points: { show: true, radius: 4 }
      }], {
        colors: [
          '#3f4f90', '#1B2440'
        ],
        xaxis: {
          mode: "time",
          timeformat: "%b %d"
        },
        grid: {
          show: true,
          color: '#333',
          borderWidth: 0,
          clickable: true,
          hoverable: true,
          autoHighlight: true
        },
        tooltip: true,
        tooltipOpts: {
          content: "%y.1"
        }
      });
    });`

$(document).ready ready
$(document).on 'page:load', ready
