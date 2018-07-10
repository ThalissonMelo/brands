class Brand < ApplicationRecord
    has_many :products

    validates :name, uniqueness: true, presence: true, length: { in: 1..80 }
end
