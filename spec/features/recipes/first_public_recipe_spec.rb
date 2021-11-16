require 'rails_helper'

RSpec.feature 'Public Recipes Index Page', type: :feature do
  describe 'GET /index' do
    background do
      @user = create(:user)
      @private_recipes = create_list(:recipe, 3, user: @user)
      @other_user = create(:user, name: 'Other User')
      @public1 = create(:public_recipe, user: @user, public: true, name: 'Public one')
      @public2 = create(:public_recipe, user: @other_user, public: true, name: 'Public two')
      visit(public_recipes_path)
    end
    scenario 'I should see public recipes in the body' do
      expect(page).to have_content @public1.name.to_s
      expect(page).to have_content @public2.name.to_s
      expect(page).to have_content "By: #{@public1.user.name}"
      expect(page).to have_content "By: #{@public2.user.name}"
      expect(page).to have_content "Total food items: #{@public1.recipe_foods_count}"
      expect(page).to have_content "Total food items: #{@public2.recipe_foods_count}"
      expect(page).to have_content "Total price: $#{@public1.recipe_foods.includes(:food).sum(:price)}"
      expect(page).to have_content "Total price: $#{@public2.recipe_foods.includes(:food).sum(:price)}"
      @private_recipes.each do |recipe|
        expect(page.has_content?(recipe.name)).to be_falsey
      end
      click_link("recipe#{@public1.id}")
      expect(current_path).to eq recipe_path(@public1.id)
      visit(public_recipes_path)
      click_link("recipe#{@public2.id}")
      expect(current_path).to eq recipe_path(@public2.id)
    end
  end
end
