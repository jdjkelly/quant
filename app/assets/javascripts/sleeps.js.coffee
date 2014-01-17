ready = ->
  if $('.sleeps.index #cal-heatmap').length > 0
    cal = new CalHeatMap()
    options =
      start: new Date(2014, 0)
      range: 65
      domain: 'day'
      subDomain: 'hour'
      rowLimit: 24
      cellSize: 10
      domainGutter: 3
      legend: [1, 2]
      legendColors:
        empty: '#dee3e9'
        min: '#dee3e9'
        max: '#4593de'
      legendHorizontalPosition: "right",
      considerMissingDataAsZero: true
      data: "/sleeps.json" + "?#{location.search.substr(1)}"
      # afterLoadData: (data, sleeps=data.sleeps)->
      #   data = {}
      #   sleeps.forEach (sleep) ->
      #     start = Date.parse(sleep.start)
      #     end = Date.parse(sleep.end)

      #     timeStamp = start
      #     while timeStamp < end
      #       data[timeStamp] = 1
      #       timeStamp + 3600000
      #   data

    cal.init options

$(document).ready ready
$(document).on 'page:load', ready
