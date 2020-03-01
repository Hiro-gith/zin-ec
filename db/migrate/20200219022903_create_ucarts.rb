class CreateUcarts < ActiveRecord::Migration[5.1]
  def change
    create_table :ucarts do |t|
      t.references :user, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
    add_index :ucarts, [:user_id, :cart_id]
  end
end
