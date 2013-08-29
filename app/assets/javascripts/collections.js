$(document).ready(function() {
    $('.load-comments').click(function() {
        $('#comments').slideToggle();
        if ($('#comments').find('.comment').length > 0) {
            return false;
        }
    });

  //添加标签
  if ($('#tags').length > 0) {
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
  }

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

  // 添加分组和添加链接的切换
  $("#create_link_group").click(function() {
    $('#new_link').hide();
    $('#new_link_group').show();
  });

  $("#cancel_create_link_group").click(function() {
    $('#new_link').show();
    $('#new_link_group').hide();
  });
});