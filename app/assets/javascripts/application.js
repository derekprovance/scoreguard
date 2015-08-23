// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

function get_gpa(gpa) {
  if (gpa < 70) {
    $('#gpa_panel').addClass('panel-danger');
  } else if (gpa >= 70 && gpa < 85) {
    $('#gpa_panel').addClass('panel-warning');
  } else if (gpa >= 85) {
    $('#gpa_panel').addClass('panel-success');
  }
}

function generate_select_array(max) {
  var b = {};
  for (var i = 1; i <= max; i++) {
    b[i] = i
  }
  return b;
}
