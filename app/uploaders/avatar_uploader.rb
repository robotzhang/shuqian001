# coding: utf-8
class AvatarUploader < BaseUploader
  version :normal do
    process :resize_to_fill => [48, 48]
  end

  version :small do
    process :resize_to_fill => [16, 16]
  end

  version :large do
    process :resize_to_fill => [64, 64]
  end

  version :big do
    process :resize_to_fill => [200, 200]
  end

  def store_dir
    "uploads/avatar"
  end

  def filename
    if super.present?
      "#{model.id}.#{file.extension.downcase}"
    end
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end