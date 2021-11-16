require 'rails_helper'

RSpec.feature 'Recipes Show Page', type: :feature do
  login_user
  describe 'GET /show' do
    background do
      @other_user = create(:user, name: 'Other User')
      @other_user_recipe = create(:recipe, user: @other_user, public: true)
      @public_recipe = create(:recipe, public: true, user: @user)
    end
    context 'when the user is logged in' do
      context 'when the current user is viewing random public recipe created by them' do
        scenario 'I should see details the recipe' do
          visit(recipe_path(@public_recipe.id))
          expect(page).to have_content(@public_recipe.name)
          expect(page).to have_content("Preparation time: #{@public_recipe.preparation_time}")
          expect(page).to have_content("Cooking time: #{@public_recipe.cooking_time}")
          expect(page).to have_checked_field('flexSwitchCheckDefault', disabled: true)
          expect(find_link('Add Ingredient').visible?).to be true
        end
      end
      context 'when the current user is viewing random public recipe created by other user' do
        scenario 'I should see details the recipe' do
          visit(recipe_path(@other_user_recipe.id))
          expect(page).to have_content(@other_user_recipe.name)
          expect(page).to have_content("Preparation time: #{@other_user_recipe.preparation_time}")
          expect(page).to have_content("Cooking time: #{@other_user_recipe.cooking_time}")
          expect(page).to have_button('Add Ingredient', disabled: true)
          expect(page).to have_checked_field('flexSwitchCheckDefault', disabled: true)
        end
      end
    end
  end
end
