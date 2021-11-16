require 'rails_helper'

RSpec.feature 'Recipes New Page', type: :feature do
  background do
    @user = create(:user)
    sign_in @user
    @unique_recipe = create(:recipe, user: @user)
    visit(new_recipe_path)
  end
  describe 'GET /new' do
    scenario 'when recipe name does exist' do
      within 'form' do
        fill_in 'recipe[name]', with: @unique_recipe.name
        fill_in 'recipe[preparation_time]', with: @unique_recipe.preparation_time
        fill_in 'recipe[cooking_time]', with: @unique_recipe.cooking_time
        fill_in 'recipe[description]', with: @unique_recipe.description
      end
      click_button 'Create recipe'
      expect(current_path).to eq recipes_path
      expect(page.has_content?('Recipe not added')).to be_truthy
      expect(page.has_content?('Name already created by you')).to be_truthy
    end
  end
end
