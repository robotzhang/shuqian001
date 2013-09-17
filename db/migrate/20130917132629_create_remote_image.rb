class CreateRemoteImage < ActiveRecord::Migration
  def up
    Link.all.each do |link|
      if link.image? && link.images.blank?
        image = link.images.build
        image.remote_file_url = link.url
        image.user_id = link.user_id
        image.save
      end
    end
  end

  def down
  end
end
