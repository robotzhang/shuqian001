// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $('.avatar').mouseover(function() {
    $(this).find('.edit').show();
  }).mouseout(function() {
    $(this).find('.edit').hide();
  });

  $('.edit form').find("input[type=file]").change(function() {
    $('.edit form').submit();
  });
});
