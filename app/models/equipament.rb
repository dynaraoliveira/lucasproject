class Equipament < ApplicationRecord
  
  has_many :equipamentusers
  has_many :users, through: :equipamentusers
  has_many :sensors
  
  validates :chave, presence: true, uniqueness: { case_sensitive: false }
  validates :nome, presence: true
  validates :cidade, presence: true
  validates :estado, presence: true
  
end
