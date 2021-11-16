class GeneralShoppingListsController < ApplicationController
  def index
    @recipe_foods = RecipeFood.joins(:food, :recipe).where(food: { user: current_user }, recipe: { user: current_user })
    @shopping_list = @recipe_foods.group('food.name, price, measurement_unit')
      .select('food.name, SUM(quantity) as quantity, (sum(quantity) * price) as price, measurement_unit')
  end
end
