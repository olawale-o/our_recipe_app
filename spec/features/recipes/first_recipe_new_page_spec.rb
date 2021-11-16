require 'rails_helper'

RSpec.feature 'Recipes New Page', type: :feature do
  background do
    @user = create(:user)
    sign_in @user
    visit(new_recipe_path)
  end
  describe 'GET /new' do
    scenario 'I should see Add new recipe form' do
      within 'form' do
        fill_in 'recipe[name]', with: 'Recipe recipe'
        fill_in 'recipe[preparation_time]', with: '1.5'
        fill_in 'recipe[cooking_time]', with: '1'
        fill_in 'recipe[description]', with: 'description'
      end
      click_button 'Create recipe'
      expect(current_path).to eq recipes_path
      expect(page.has_content?('Recipe added successfully')).to be_truthy
    end
  end
end
