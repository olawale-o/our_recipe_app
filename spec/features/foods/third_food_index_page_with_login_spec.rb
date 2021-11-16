require 'rails_helper'

RSpec.feature 'Foods Index Page', type: :feature do
  describe 'GET /index' do
    background do
      @user = create(:user)
      sign_in @user
      @other_user_with_food = create(:with_foods, food_items: 1, name: 'Other')
      @food_with_current_user = create(:food, user: @user)
      visit(foods_path)
    end
    context 'when user is logged in without and with foods' do
      scenario 'I should see Add Food button' do
        expect(find_link('Add food').visible?).to be true
      end

      scenario 'I should be redirected to add new food page' do
        click_link 'Add food'
        expect(current_path).to eq new_food_path
      end

      scenario 'I should see foods on the body that current user can and cannot delete' do
        expect(page).to have_content(@other_user_with_food.foods.first.name)
        expect(page).to have_content(@food_with_current_user.name)
        expect(page).to have_content(@food_with_current_user.measurement_unit)
        expect(page).to have_content("$#{@other_user_with_food.foods.first.price.to_i}")
        expect(page).to have_content("$#{@food_with_current_user.price.to_i}")
        expect(page).to have_button('Delete', disabled: true)
        expect(page).to have_button('Delete')
      end
    end
  end
end
