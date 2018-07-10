class User < ApplicationRecord
    has_many :brands

    validates :name, presence: true, length: { in: 3..80 }
    validates :email, presence: true, uniqueness: true
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :password, presence: true, length: { in: 6..20 }
end
