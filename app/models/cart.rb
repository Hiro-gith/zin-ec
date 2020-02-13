class Cart < ApplicationRecord
   has_many :citems
   belongs_to :user
end
