require 'rails_helper'

RSpec.feature 'Recipes Show Page', type: :feature do
  login_user
  describe 'GET /show' do
    background do
      @recipe = create(:recipe, user: @user)
      @current_user_foods = create_list(:food, 3, user: @user)
      @recipe_foods = @current_user_foods.map do |food|
        create(:recipe_food, recipe: @recipe, food: food)
      end
      visit(recipe_path(@user.recipes.first.id))
    end
    context 'when the user is logged in' do
      scenario 'I should see details of the recipe' do
        expect(page).to have_field('flexSwitchCheckDefault', checked: false, disabled: true)
        expect(page).to have_content(@user.recipes.first.name)
        expect(page).to have_content("Preparation time: #{@user.recipes.first.preparation_time}")
        expect(page).to have_content("Cooking time: #{@user.recipes.first.cooking_time}")
        expect(find_link('Add Ingredient').visible?).to be true
        @recipe_foods.each do |recipe_food|
          expect(page).to have_content(recipe_food.food.name)
          expect(page).to have_content("$#{recipe_food.food.price * recipe_food.quantity}")
          expect(page).to have_content(pluralize(recipe_food.quantity, recipe_food.food.measurement_unit))
        end
        click_link("modify_#{@recipe_foods.first.id}")
        expect(page.current_path).to eq(edit_recipe_food_path(@recipe_foods.first.id))
      end
    end
  end
end
