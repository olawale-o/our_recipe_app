FactoryBot.define do
  sequence(:name) { |n| "Food #{n}" }
  factory :food do
    user
    name
    measurement_unit { 'grams' }
    price { 10 }
  end
end
