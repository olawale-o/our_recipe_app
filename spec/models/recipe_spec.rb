require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    let(:recipe) { build(:recipe) }
    it 'name should be present' do
      recipe.name = nil
      expect(recipe).to_not be_valid
    end

    it 'preparation_time should be present' do
      recipe.preparation_time = nil
      expect(recipe).to_not be_valid
    end

    it 'cooking_time should be present' do
      recipe.cooking_time = nil
      expect(recipe).to_not be_valid
    end

    it 'description should be present' do
      recipe.description = nil
      expect(recipe).to_not be_valid
    end
  end
end
