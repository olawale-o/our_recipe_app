require 'rails_helper'

RSpec.feature 'Recipes Index Page', type: :feature do
  background do
    @user = create(:user)
    sign_in @user
    @recipes = create_list(:recipe, 3, user: @user)
    visit(recipes_path)
  end

  describe 'GET /index' do
    scenario 'I should see Add Recipe button' do
      expect(find_link('Add Recipe').visible?).to be true
    end

    scenario 'I should be redirected to add new recipe page' do
      click_link 'Add Recipe'
      expect(current_path).to eq new_recipe_path
    end

    scenario 'I should see recipes in the body' do
      @recipes.each do |recipe|
        expect(page).to have_content recipe.name.to_s
        expect(page).to have_content recipe.description.to_s
        expect(page).to have_button 'Remove'
      end
    end
  end
end
