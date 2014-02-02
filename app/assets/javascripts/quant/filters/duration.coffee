angular.module('quant')
  .filter 'duration', ->
    (resource, format)->
      start = new Date(resource.start)
      end = new Date(resource.end)
      duration = (end.getTime() - start.getTime()) / 1000

      switch format
        when 'seconds' then duration
        when 'minutes' then Math.round( (duration / 60) * 10 ) / 10
        when 'hours' then Math.round( (duration / 60 / 60) * 10 ) / 10
        else duration
