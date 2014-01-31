angular.module('quant')
  .factory('Sleeps', ['$resource', ($resource)->
    $resource '/sleeps/:id.json'
  ])
