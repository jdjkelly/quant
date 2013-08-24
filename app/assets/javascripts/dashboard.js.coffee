ready = ->
  $('.dashboard.index .chart').each((idx, chart)->
    return unless $(@).data("chart-data")? && $(@).data("chart-type")?

    ctx = chart.getContext("2d")

    switch $(@).data("chart-type")
      when "line" then (=>
        data = {
          labels: ["  ","","","","","","  "],
          datasets: [
            {
              fillColor : "rgba(151,187,205,0)",
              strokeColor : "#4d5360",
              pointColor : "#fff",
              pointStrokeColor : "#4d5360",
              data : $(@).data("chart-data")
            }
          ]
        }

        new Chart(ctx).Line data,
          scaleShowLabels : false,
          scaleShowGridLines : false,
          scaleLineColor : "rgba(0,0,0,0)",
          scaleFontSize : 16,
          scaleFontColor : "#444"
      )()
      when "doughnut" then (=>
        data = $(@).data("chart-data")
        return unless typeof data == "number"

        data = [
          value: 100 - data,
          color: "#D4CCC5"
        ,
          value: data,
          color: "#3498DB"
        ]

        new Chart(ctx).Doughnut data
      )()
  )

$(document).ready(ready)
$(document).on('page:load', ready)
