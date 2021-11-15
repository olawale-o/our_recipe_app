class CreateInventoryFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_foods do |t|
      t.string :quantity
      t.references :food, null: false, foreign_key: true, index: true
      t.references :inventory, null: false, foreign_key: true, index: true
    end
  end
end
