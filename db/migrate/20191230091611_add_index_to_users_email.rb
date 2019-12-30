class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # usersテーブルのemailカラムにインデックスを追加. データベースで一意性を持つようにする
    add_index :users, :email, unique: true
  end
end
