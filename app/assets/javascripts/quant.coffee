quant = angular.module('quant', ['ngResource', 'mm.foundation', 'd3'])

$(document).on('ready page:load', ->
  angular.bootstrap($('body'), ['quant'])
)
