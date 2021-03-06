class User < ApplicationRecord
  #attr_accessible :name
  has_many :equipamentusers
  has_many :equipaments, through: :equipamentusers
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :usertype, presence: true, length: { maximum: 1 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 , maximum: 10 }
end
