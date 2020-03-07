class Citem < ApplicationRecord
  belongs_to :item
  belongs_to :cart
  default_scope -> { order(created_at: :desc) }
end
