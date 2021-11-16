FactoryBot.define do
  sequence(:email) { |n| "email#{n}@test.com" }
  factory :user do
    name { 'name' }
    email
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }

    factory :with_foods do
      transient do
        food_items { 5 }
      end
      after(:build) do |user, evaluator|
        create_list(:food, evaluator.food_items, user: user)
      end
    end

    factory :with_recipes do
      transient do
        recipe_items { 5 }
      end
      after(:build) do |user, evaluator|
        create_list(:recipes, evaluator.recipe_items, user: user)
      end
    end
  end
end
