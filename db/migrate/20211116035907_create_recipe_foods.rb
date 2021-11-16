class CreateRecipeFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity
      t.references :recipe, null: false, foreign_key: true, index: true
      t.references :food, null: false, foreign_key: true, index: true
    end
  end
end