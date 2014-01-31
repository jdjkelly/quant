angular.module('quant')
  .controller 'SleepsCtrl', ['$scope', 'Sleeps', ($scope, Sleeps)->
    $scope.sleeps = Sleeps.query()

    $scope.$watch 'sleeps.length', (length)->
      $scope.averageDuration = length
]
