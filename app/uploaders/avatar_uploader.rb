# coding: utf-8
class AvatarUploader < BaseUploader
  # resize_to_fill 会等比例缩小后截断到48*48
  # resize_to_fit 也是等比例缩小，但是可能高度or宽度发生了变化
  version :normal do
    process :resize_to_fill => [48, 48]
  end

  version :small do
    process :resize_to_fill => [16, 16]
  end

  version :middle do
    process :resize_to_fill => [25, 25]
  end

  version :large do
    process :resize_to_fill => [64, 64]
  end

  version :big do
    process :resize_to_fill => [200, 200]
  end

  def default_url
    "/assets/avatar/" + [version_name, "default.jpg"].compact.join('_')
  end

  def store_dir
    "uploads/avatar/#{model.id}"
  end

  def filename
    if super.present?
      "#{Time.now.to_i}.#{file.extension.downcase}"
    end
  end
end