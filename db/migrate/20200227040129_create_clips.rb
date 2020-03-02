class CreateClips < ActiveRecord::Migration[5.1]
  def change
    create_table :clips do |t|
      t.references :item, foreign_key: true, null:false
      t.references :user, foreign_key: true, null:false

      t.timestamps
    end
    add_index :clips, [:item_id, :user_id], unique: true
  end
end
