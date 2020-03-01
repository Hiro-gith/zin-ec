class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :category
      t.text :content
      
      # 実際はpriceの初期値がnil,postsの初期値が0になっている
      t.integer :price , default: 0
      t.integer :score , default: 0
      t.integer :posts , default: 0
      t.integer :sales , default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :items, [:user_id, :created_at]
  end
end
