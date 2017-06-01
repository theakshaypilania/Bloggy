class Post < ApplicationRecord
	has_many :comments, dependent: :destroy
	validates :title, :body, presence: true,
				length: {minimum: 3}
end
