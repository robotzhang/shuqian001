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

  //
  $("div[id^=link_item] .link").mouseover(function() {
    $(this).find('.actions').show();
  }).mouseout(function() {
    $(this).find('.actions').hide();
  });

  // 分组action的显示控制
  $('.link_group h2').live({
    "mouseover": function() {
      var actions = $(this).find(".actions");
      actions.css({left: $(this).offset().left, top: $(this).offset().top + $(this).height()});
      actions.show();
    },
    "mouseout": function() {
      $(this).find(".actions").hide();
    }
  });
});