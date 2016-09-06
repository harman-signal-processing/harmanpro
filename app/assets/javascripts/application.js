// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require angular-resource
//= require angular-awesome-slider/dist/angular-awesome-slider.min
//= require nsPopover
//= require_tree ./app
//= require foundation
//= require tinymce-jquery
//= require consultants
//= require mega_menu
//= require vertical_markets
//= require locale
//= require_tree ./cms
//= require tiny
// require_tree .

$(function(){
  $(document).foundation({
    "magellan-expedition": {
      fixed_top: 100,
      destination_threshold: 85,
    },
    equalizer: {
      equalize_on_stack: true
    }
  });
  if ($('#roadblock').length > 0) {
    $('#roadblock').foundation('reveal', 'open');
  }
});
