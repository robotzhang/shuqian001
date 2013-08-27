$(document).ready(function() {
    $('.load-comments').click(function() {
        $('#comments').slideToggle();
        if ($('#comments').find('.comment').length > 0) {
            return false;
        }
    });

  //添加标签
  $('#tags').tagsInput({
    'defaultText': '',
    'width':'100%',
    'height':'40px'
  });
});