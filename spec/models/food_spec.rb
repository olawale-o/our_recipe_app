require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    let(:food) { build(:food) }
    it 'name should be present' do
      food.name = nil
      expect(food).to_not be_valid
    end

    it 'price should be present' do
      food.price = nil
      expect(food).to_not be_valid
    end

    it 'measurement_unit should be present' do
      food.measurement_unit = nil
      expect(food).to_not be_valid
    end
  end
end
