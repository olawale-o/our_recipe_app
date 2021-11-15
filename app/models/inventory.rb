class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods

  validates :name, :description, presence: true
  validates :name, uniqueness: { scope: :user_id }
  
  before_validation :remove_whitespace
  
  def remove_whitespace
    self.name = name.strip unless name.nil?
    self.description = description.strip unless description.nil?
  end
end
  