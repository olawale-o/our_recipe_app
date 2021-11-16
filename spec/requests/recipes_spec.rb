require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  login_user
  describe 'GET /index' do
    before(:each) do
      create(:recipe, user: @user, name: 'Recipe 1')
      create(:recipe, name: 'Recipe 2', user: @user)
      get recipes_path
    end

    it 'should return http status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'should render correct view' do
      assert_template 'recipes/index'
    end

    it 'should include ' do
      expect(response.body).to include('Recipe 1')
      expect(response.body).to include('Recipe 2')
      expect(response.body).to include('A description')
    end
  end

  describe 'GET /show' do
    let(:recipe) { create(:recipe, user: @user, name: 'Recipe 1') }
    before(:each) do
      get recipe_path(recipe.id)
    end

    it 'should return http status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'should render correct view' do
      assert_template 'recipes/show'
    end

    it 'should include ' do
      expect(response.body).to include('Recipe 1')
      expect(response.body).to include("Cooking time: #{recipe.cooking_time}")
      expect(response.body).to include("Preparation time: #{recipe.preparation_time}")
    end
  end

  describe 'GET /public_recipes' do
    before(:each) do
      @one = create(:recipe, name: 'Recipe 1', public: true, user: @user)
      @two = create(:recipe, name: 'Recipe 2', public: true, user: @user)
      @three = create(:recipe, name: 'Recipe 3', public: true, user: @user)
      get public_recipes_path
    end

    it 'should return http status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'should render correct view' do
      assert_template 'recipes/public_recipes'
    end

    it 'should include ' do
      expect(response.body).to include(@one.name)
      expect(response.body).to include("By: #{@one.user.name}")
      expect(response.body).to include(@two.name)
      expect(response.body).to include("By: #{@two.user.name}")
    end
  end
end
