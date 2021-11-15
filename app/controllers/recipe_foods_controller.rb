class RecipeFoodsController < ApplicationController
  before_action :current_user_foods, only: %i[new create edit]

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
  end

  def create
    @recipe_food = RecipeFood.create(recipe_food_params)
    if @recipe_food.save
      flash[:notice] = 'Recipe added to food successfully'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      flash[:alert] = 'Recipe cannnot be added to food'
      render :new
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      flash[:notice] = 'Recipe quantity updated successfully'
      redirect_to recipe_path(@recipe_food.recipe_id)
    else
      flash[:alert] = 'Recipe quantity cannot be updated'
      render :edit
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.destroy
      flash[:notice] = 'Recipe removed from food successfully'
    else
      flash[:alert] = 'Recipe cannot be removed from food'
    end
    redirect_to recipe_path(@recipe_food.recipe.id)
  end

  private

  def current_user_foods
    @foods = current_user.foods.collect { |food| [food.name, food.id] }
  end
  
  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :recipe_id, :quantity)
  end
end
