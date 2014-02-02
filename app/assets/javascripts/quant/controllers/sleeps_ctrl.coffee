angular.module('quant')
  .controller 'SleepsCtrl', ['$scope', '$filter', 'Sleeps', ($scope, $filter, Sleeps)->
    $scope.sleeps = Sleeps.query()

    $scope.$watch 'sleeps.length', (length)->
      $scope.averageDuration = 0
      $scope.sleeps.forEach (sleep)->
        $scope.averageDuration += $filter('duration')(sleep, 'hours')
      $scope.averageDuration = Math.round(($scope.averageDuration / length) * 10) / 10

      $scope.lengths = $scope.sleeps.map (s)-> $filter('duration')(s, 'hours')

    $scope.$watch 'lengths', (lengths)->

      data = lengths

      width = window.innerWidth
      height = 500

      y = d3.scale.linear()
        .range([height, 0])

      unless document.querySelectorAll('.chart').length > 0
        d3.select("#main").append("svg").attr("class", "chart")

      chart = d3.select(".chart")
        .attr("width", width)
        .attr("height", height)

      y.domain([0, d3.max(data, (d)-> d)])

      barWidth = width / data.length

      bar = chart.selectAll("g")
        .data(data)
      .enter().append("g")
        .attr("transform", (d,i) -> "translate(" + i * barWidth + ",0)")

      bar.append("rect")
        .attr("y", (d) -> y(d))
        .attr("width", barWidth - 1)
        .attr("height", 0)
        .transition().delay((d,i) -> i * 50).ease("linearOut")
        .duration(250).attr("height", (d)-> height - y(d))

      bar.append("text")
        .attr("x", barWidth / 2)
        .attr("y", (d)-> y(d) + 3)
        .attr("dy", "1.5em")
        .text((d)-> "#{d} h")

]
