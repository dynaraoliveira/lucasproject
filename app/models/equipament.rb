class Equipament < ApplicationRecord
  #attr_accessible :nome
  has_many :equipamentusers
  has_many :users, through: :equipamentusers
  
  validates :chave, presence: true, uniqueness: { case_sensitive: false }
  validates :nome, presence: true
  validates :cidade, presence: true
  validates :estado, presence: true
  
end
