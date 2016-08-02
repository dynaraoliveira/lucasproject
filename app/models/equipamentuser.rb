class Equipamentuser < ApplicationRecord
  belongs_to :equipament
  belongs_to :user
  validates :equipament_id, uniqueness: { scope: :user_id }
end
