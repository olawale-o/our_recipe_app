require 'rails_helper'

RSpec.feature 'Foods New Page', type: :feature do
  background do
    @user = create(:user)
    sign_in @user
    visit(new_food_path)
  end

  describe 'GET /new' do
    scenario 'I should see Add new food form' do
      within 'form' do
        fill_in 'food[name]', with: 'Pizza'
        fill_in 'food[measurement_unit]', with: 'grams'
        fill_in 'food[price]', with: '10'
      end
      click_button 'Create food'
      expect(current_path).to eq foods_path
      expect(page.has_content?('Food added successfully')).to be_truthy
    end
  end
end
