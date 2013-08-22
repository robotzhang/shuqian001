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
//= require jquery_ujs

$(document).ready(function(){
    $('.alert').find('.close').die('click').live('click', function() {
        $(this).parents('.alert').slideUp();
        return false;
    });

    //
    $('.a_comment').click(function() {
      var panel = $('#' + $(this).data('show'));
      if (panel.find('form').length > 0) {
        panel.slideToggle();
        return false;
      }
    });

  $('.collection .box').mouseover(function() {
    $(this).find('.detail').show();
  }).mouseout(function() {
    $(this).find('.detail').hide();
  });
});
