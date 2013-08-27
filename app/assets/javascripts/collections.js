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
    'height':'40px',
    "onRemoveTag": function(tag) {
      $.each($('.sys_tags a'), function(){
        if ($(this).text() == tag) {
          $(this).removeClass("selected");
          return false;
        }
      });
    }
  });

  // 选择标签
  $('.sys_tags a').click(function() {
    if ($(this).hasClass("selected")) {
      $(this).removeClass("selected");
      $('#tags').removeTag($(this).text());
    } else {
      $(this).addClass("selected");
      $('#tags').addTag($(this).text());
    }
  });
});