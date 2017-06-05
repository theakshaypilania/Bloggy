class Post < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title, :body, presence: true,
				length: {minimum: 3}

	def self.search(search=nil)
    	where(["body LIKE ?", "%#{search}%"]) 
    end

end
