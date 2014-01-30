quantApp = angular.module('quantApp', ['ngResource', 'mm.foundation'])
  .filter 'duration', ->
    (resource, format)->
      start = new Date(resource.start)
      end = new Date(resource.end)
      duration = (end.getTime() - start.getTime()) / 1000

      debugger

      switch format
        when 'seconds' then duration
        when 'minutes' then Math.round( (duration / 60) * 10 ) / 10
        when 'hours' then Math.round( (duration / 60 / 60) * 10 ) / 10
        else duration

quantApp.factory('Sleeps', ['$resource', ($resource)->
  $resource '/sleeps/:id.json'
])

angular.module('quantApp')
  .controller 'SleepsCtrl', ['$scope', 'Sleeps', ($scope, Sleeps)->
    $scope.sleeps = Sleeps.query()
]

$(document).on('ready page:load', ->
  angular.bootstrap($('.sleeps.index'), ['quantApp'])
)


