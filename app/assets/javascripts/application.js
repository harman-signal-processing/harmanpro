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
//= require angular-filter/dist/angular-filter.min
//= require nsPopover
//= require_tree ./app
//= require foundation
//= require tinymce-jquery
//= require jquery.rwdImageMaps.min
//= require consultants
//= require mega_menu
//= require vertical_markets
//= require training_courses
//= require training_calendar
//= require training_maintenance_message
//= require locale
//= require effects
//= require_tree ./cms
//= require tiny
//= require slick.min
//= require REM-unit-polyfill
//= require jquery-sticky/jquery.sticky
//= require jquery.lazyload
//= require chosen-jquery
//= require will_paginate_infinite
//= require admin
// require_tree .

$(function () {

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

  // enable chosen js
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched',
    width: '100%'
  });

  $(document).on('opened.fndtn.reveal', '[data-reveal]', function() {
    $(this).find('[autofocus]').focus();
  });

    $('a.update-and-play-inline-video').click(function(e) {
      var video_url;
      e.preventDefault();
      video_url = "https://www.youtube.com/embed/" + ($(this).data('videoid')) + "?autostart=1&autoplay=1&rel=0";
      return $("#" + ($(this).data('containerid')) + " iframe").attr('src', video_url);
    });

    $('a.start-video').click(function(e) {
      var video_url;
      e.preventDefault();
      if ($(this).data('videoid').startsWith('PL')) {
        video_url = "https://www.youtube.com/embed/videoseries?list=" + ($(this).data('videoid'));
      } else {
        video_url = "https://www.youtube.com/embed/" + ($(this).data('videoid')) + "?autostart=1&autoplay=1&rel=0";
      }
      $('#videoIFrame').attr('data-src', video_url);
      return $('#videoModal').foundation('reveal', 'open');
    });

    $('a.close-video').click(function(e) {
      $('#videoModal').foundation('reveal', 'close');
      return $('#videoIFrame').attr('src', '');
    });

}); // $(function() {

$(document).ready(function (e) {
  $('img[usemap]').rwdImageMaps();
});

$(function() {
  $("img").lazyload({
    threshold: 200,
    effect: "fadeIn"
  });
});

