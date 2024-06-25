class Post < ApplicationRecord
    belongs_to :user
    validates :address, :roommates_needed, :rent, :email, presence: true
end
