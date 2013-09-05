/*
* 简易图片上传 by robot.zhang
* */
(function($) {
  var uploader = {
    html: function(settings) {
      var box = $('<div id="editor_image_uploader" class="box abs padding10 fs12"><button type="button" class="close">&times;</button></div>');
      box.width(settings.width);
      var nav = $(
        '<ul class="nav nav-tabs mb10 clearfix">'+
          '<li class="active"><a href="javascript:void(0);" data-show=".local">本地上传</a></li>'+
          '<li><a href="javascript:void(0);" data-show=".remote">网络图片</a></li>'+
        '</ul>'
      );
      var form = $("<form action='"+settings.action+"' method='post' enctype='multipart/form-data' target='ifr_image'></form>");
      form.append($("<input type='hidden' value='"+$('meta[name=csrf-token]').attr('content')+"' name='authenticity_token'/>"));
      var local = $('<div class="local"><input type="file" name="image_file" /></div>');
      var remote = $('<div class="remote hide"><input type="text" class="mb0" name="remote_image_url" /><input class="btn" type="submit"/> </div>');
      var loading = $('<div class="loading hide">正在上传</div>');
      var iframe = "<iframe style='display: none;' id='ifr_image'></iframe>";

      return box.append(nav).append(form.append(local).append(remote)).append(loading).append(iframe);
    },
    bing_events: function(setting) { // 绑定事件
      // 关闭
      var editor = $("#editor_image_uploader");
      editor.find('.close').click(function(){
        uploader.close();
      });
      // tab 切换
      editor.find('.nav a').click(function(){
        $.each(editor.find('.nav a'), function(){
          $($(this).data('show')).hide();
          editor.find('.nav li').removeClass('active');
        });
        $(this).parents('li').addClass('active');
        $($(this).data('show')).show();
      });
      //
      editor.find('input[type=file]').change(function() {
        $(this).parents('form').submit().hide();
        editor.find('.loading').show();
      });

      // 上传完成的动作
      editor.find('iframe').load(function(){
        var res = $.parseJSON($(this).contents().find("body").text());
        $(setting.success_info_panel).append($("<img src='"+res.url+"'/>"));
        uploader.close();
        if (typeof setting.callback == "function") {
          setting.callback(res);
        }
      });
    },
    close: function() {
      var editor = $("#editor_image_uploader");
      editor.remove();
    }
  };

  $.fn.uploader = function(options) {
    if ($("#editor_image_uploader").length > 0) {
      return false;
    }
    // 定义默认参数
    var settings = jQuery.extend({
      action: "",
      width: 300,
      success_info_panel: "",
      callback: ""
    },options);

    $('body').append(uploader.html(settings));
    var editor = $("#editor_image_uploader");
    // 设置位置
    editor.css({
      top: $(this).offset().top + $(this).height(),
      left: $(this).offset().left - editor.width()
    });
    uploader.bing_events(settings);
    editor.hide().slideDown();
  }
})(jQuery);
