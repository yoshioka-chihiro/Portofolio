class Condition < ApplicationRecord
  belongs_to :end_user
  has_many :healths, dependent: :destroy
  has_many :meals, through: :healths
  enum gender: { stone: 0, hard: 1, banana: 2, soft: 3, water: 4 }
  enum gender: { sad: 0, nomal: 1, happy: 2 }
end