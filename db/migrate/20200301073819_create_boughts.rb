class CreateBoughts < ActiveRecord::Migration[5.1]
  def change
    create_table :boughts do |t|
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :quantity, default: 0

      t.timestamps
    end
    add_index :boughts, [:user_id, :item_id]
  end
end
