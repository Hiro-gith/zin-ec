class AddSpointToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :spoint, :integer,default: 0
  end
end
