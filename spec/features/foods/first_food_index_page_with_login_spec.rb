require 'rails_helper'

RSpec.feature 'Foods Index Page', type: :feature do
  describe 'GET /index' do
    background do
      @user = create(:user)
      sign_in @user
      @other_user_with_foods = create(:with_foods, food_items: 5, name: 'Other')
      @user_with_foods = create_list(:food, 5, user: @user)
      visit(foods_path)
    end
    context 'when user is logged in without foods' do
      scenario 'I should see Add Food button' do
        expect(find_link('Add food').visible?).to be true
      end

      scenario 'I should be redirected to add new food page' do
        click_link 'Add food'
        expect(current_path).to eq new_food_path
      end

      scenario 'I should see foods on the body that current user cannot delete' do
        @other_user_with_foods.foods.each do |food|
          expect(page).to have_content(food.name)
          expect(page).to have_content(food.measurement_unit)
          expect(page).to have_content("$#{food.price.to_i}")
          expect(page).to have_button('Delete', disabled: true)
        end
      end
    end
  end
end
