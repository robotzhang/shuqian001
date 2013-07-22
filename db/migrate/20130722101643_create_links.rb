# 链接(资源)表
class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title # 链接标题
      t.string :url # 链接地址
      t.string :status # 链接状态（审核通过，待审核）

      t.references :user # 所属用户
      t.references :collection # 所属合集

      t.timestamps
    end
  end
end
