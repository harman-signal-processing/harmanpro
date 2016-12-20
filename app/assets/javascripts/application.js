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
//= require jquery.rwdImageMaps.min
//= require consultants
//= require mega_menu
//= require vertical_markets
//= require training_courses
//= require locale
//= require effects
//= require_tree ./cms
//= require tiny
//= require slick.min
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
  $('.slick-show').slick({
    autoplay: true,
    autoplaySpeed: 5000,
    arrows: false,
    dots: true
  });
  if ($('#roadblock').length > 0) {
    $('#roadblock').foundation('reveal', 'open');
  }
});
