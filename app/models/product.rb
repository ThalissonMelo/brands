class Product < ApplicationRecord
    belongs_to :brand

    validates :name, uniqueness: true, presence: true, length: { in: 1..80 }
end
