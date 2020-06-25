//= require active_admin/base
//= require activeadmin-sortable
//= require tinymce-jquery
//= require jquery.lazyload
//= require tiny

$(function() {
  $("img").lazyload({
    threshold: 200,
    effect: "fadeIn"
  });
});
