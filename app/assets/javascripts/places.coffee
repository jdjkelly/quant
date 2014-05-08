ready = ->
  if $('.places.index').length > 0
    unless window.Map?
      window.Map = L.map('map')

      L.Icon.Default.imagePath = 'assets/vendor/leaflet'

      L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
          maxZoom: 18
      }).addTo(window.Map)

      L.heatLayer(window.Places, {radius: 50}).addTo(window.Map);

      window.Map.setView(window.Places[0], 15)

$(document).ready ready
$(document).on 'page:load', ready
