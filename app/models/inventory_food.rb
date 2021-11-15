class InventoryFood < ApplicationRecord
  belongs_to :inventory
  belongs_to :food

  validates :quantity, presence: true
  validates :food_id, uniqueness: { scope: :inventory_id, message: 'already exists in inventory' }
  
  before_validation :remove_whitespace

  def remove_whitespace
    self.quantity = quantity unless quantity.nil?
  end
end
  