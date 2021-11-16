FactoryBot.define do
  factory :recipe_food do
    food
    recipe
    quantity { 23 }
  end
end
