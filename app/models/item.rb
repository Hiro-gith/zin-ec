class Item < ApplicationRecord
  # userモデルに属する
  belongs_to :user
  # 降順に並べ替える（最新のものを一番上）
  default_scope -> { order(created_at: :desc) }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :category , presence: true
  validates :content, presence: true, length: { maximum: 300 }
  validates :price, presence: true,numericality: {greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
end
