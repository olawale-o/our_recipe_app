class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true, index: true
    end
  end
end
