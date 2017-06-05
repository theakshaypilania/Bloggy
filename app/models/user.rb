class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :posts, dependent: :destroy
has_many :comments, dependent: :destroy

         validates :username, presence: true, length:{minimum:3}, uniqueness: {case_sensitive: false};
 
 
   # Only allow letter, number, underscore and punctuation.
   validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
 
 
     validate :validate_username
       def validate_username
         if User.where(email: username).exists?
           errors.add(:username, :invalid)
         end
       end
end
