# 资源合集
class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title # 合集标题
      t.string :description # 补充描述

      t.references :user # 所属用户

      t.timestamps
    end
  end
end
