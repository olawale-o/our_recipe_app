require 'rails_helper'

RSpec.feature 'Foods Index Page', type: :feature do
  describe 'GET /index' do
    background do
      @random_user_with_foods = create(:with_foods, food_items: 5, name: 'Random User')
      visit(foods_path)
    end
    context 'when user is not logged in' do
      scenario 'I should not see Add Food button' do
        expect(page).not_to have_selector('#add-food')
      end

      scenario 'I should see foods in the body' do
        @random_user_with_foods.foods.each do |food|
          expect(page).to have_content(food.name)
          expect(page).to have_content(food.measurement_unit)
          expect(page).to have_content("$#{food.price.to_i}")
          expect(page).to have_button('Delete', disabled: true)
        end
      end
    end
  end
end
