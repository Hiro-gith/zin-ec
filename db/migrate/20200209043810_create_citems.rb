class CreateCitems < ActiveRecord::Migration[5.1]
  def change
    create_table :citems do |t|
      t.integer :quantity,default:0
      t.references :item, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
    add_index :citems, [:item_id, :cart_id], unique: true
  end
end
