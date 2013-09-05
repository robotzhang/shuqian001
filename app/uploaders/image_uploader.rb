# coding: utf-8
class ImageUploader < BaseUploader
  #version :thumb  do
  #  process :resize_to_fill => [100, nil]
  #end

  def store_dir
    "uploads/images"
  end

  def filename
    if super.present?
      # current_path 是 Carrierwave 上传过程临时创建的一个文件，有时间标记，所以它将是唯一的
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{Time.now.strftime("%Y%m%d")}/#{@name}.#{file.extension.downcase}"
    end
  end
end