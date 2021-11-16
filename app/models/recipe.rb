class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  validates :name, :preparation_time, :cooking_time, :description, presence: true
  validates :name, uniqueness: { message: 'already created by you', scope: :user_id }
  validates_numericality_of :preparation_time, :cooking_time, greater_than: 0

  before_validation :remove_whitespace

  def remove_whitespace
    self.name = name.strip unless name.nil?
    self.description = description.strip unless description.nil?
  end
end
