require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }
    it 'name should be present' do
      user.name = nil
      expect(user).to_not be_valid
    end
  end
end
