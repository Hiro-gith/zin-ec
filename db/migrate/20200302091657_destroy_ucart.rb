class DestroyUcart < ActiveRecord::Migration[5.1]
  def change
    drop_table :ucarts
  end
end
