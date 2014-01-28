// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require d3
//= require turbolinks
//= require jquery.turbolinks
//= require chart
//= require cal-heatmap
//= require foundation/foundation
//= require foundation/foundation.abide
//= require foundation/foundation.alert
//= require foundation/foundation.dropdown
//= require foundation/foundation.tab
//= require foundation/foundation.tooltip
//= require foundation/foundation.topbar
//= require angular
//= require angular-resource
//= require mm-foundation-0.0.0.min
//= require quantApp
//= require_tree .

$(document).ready(function() {
  $(document).foundation()
  $.setReadyEvent('page:change')
})
