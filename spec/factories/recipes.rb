FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Recipe #{n}" }
    user
    description { 'A description' }
    cooking_time { 1.5 }
    preparation_time { 1 }
    public { false }

    factory :public_recipe do
      transient do
        reccipe_foods_count { 1 }
      end
      after(:build) do |recipe, evaluator|
        create_list(:recipe_food, evaluator.reccipe_foods_count, recipe: recipe)
      end
    end
  end
end
