//= require jquery.uploader.js

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
  $("div[id^=link_item] .link").live({
    "mouseover": function() {
      $(this).find('.actions').show();
    },
    "mouseout": function() {
      $(this).find('.actions').hide();
    }
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

  //
  $('.add-link-to-group').live({
    "click": function() {
      var group_id = $(this).data('group');
      $('select[name="link[link_group_id]"]').val(group_id);
      $('#new_link').find('[name="link[url]"]').focus();
      //$("html,body").animate({scrollTop: $("#"+$(this).attr("href")).offset().top}, 1000);
      //return false;
    }
  });

  // 添加图片
  function add_image_success(res) { // 添加图片成功的回调函数
    var ids = $('.link_images').find('input[name=image_ids]');
    ids.val(ids.val() + "," + res.id);
    var textarea = $('#new_link').find('textarea');
    $('.link_images').css({
      top: textarea.offset().top + textarea.height() + 25,
      left: textarea.offset().left + textarea.width() - $('.link_images').width() + 10
    });
  }
  $('.add-image').click(function(){
    $(this).uploader({
      action: $(this).data('action'),
      success_info_panel: ".link_images",
      callback: add_image_success
    });
  });
});