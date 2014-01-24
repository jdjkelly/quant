quantApp = angular.module('quantApp', ['ngResource'])

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


