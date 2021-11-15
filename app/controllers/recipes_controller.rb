class RecipesController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @recipes = current_user.recipes.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @food_with_recipes = @recipe.recipe_foods.includes(:food)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    current_user.recipes << @recipe
    if @recipe.save
      flash[:notice] = 'Recipe added successfully'
      redirect_to recipes_path
    else
      flash[:alert] = 'Recipe not added'
      render :new
    end
  end

  def destroy
    previous_url = request.env['HTTP_REFERER']
    recipe = Recipe.find(params[:id])
    if recipe.destroy
      flash[:notice] = 'Recipe deleted successfully'
    else
      flash[:alert] = 'Recipe cannot deleted'
    end
    redirect_to(previous_url)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
