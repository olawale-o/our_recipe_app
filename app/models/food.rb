class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :inventory_foods, dependent: :destroy

  validates :name, :measurement_unit, :price, presence: true
  validates :name, uniqueness: { scope: :user_id, message: 'already taken by you' }
  validates_numericality_of :price, greater_than: 0

  before_validation :trim_whitespace

  def trim_whitespace
    self.name = name.strip if name.present?
    self.measurement_unit = measurement_unit.strip if measurement_unit.present?
  end
end
