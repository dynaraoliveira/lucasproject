class Sensor < ApplicationRecord
    belongs_to :equipaments
    
    validates :chave, presence: true
    validates :sensor0, numericality: true
    validates :sensor1, numericality: true
    validates :sensor2, numericality: true
    validates :sensor3, numericality: true
    validates :sensor4, numericality: true
    validates :sensor5, numericality: true
    validates :datainclusao, presence: true
end
