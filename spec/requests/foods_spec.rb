require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  login_user
  describe 'GET /index' do
    before(:each) do
      create(:food, user: @user, name: 'Pizza')
      create(:food, name: 'Rice')
      get foods_path
    end
    it 'should return http status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'should render correct view' do
      assert_template 'foods/index'
    end

    it 'should include foods of all users' do
      expect(response.body).to include('Pizza')
      expect(response.body).to include('Rice')
      expect(response.body).to include('grams')
      expect(response.body).to include('10')
    end
  end
end
