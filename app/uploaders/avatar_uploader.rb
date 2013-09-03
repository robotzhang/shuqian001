# coding: utf-8
class AvatarUploader < BaseUploader
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

  def extension_white_list
    %w(jpg jpeg png gif)
  end
end