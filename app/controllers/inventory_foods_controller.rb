class InventoryFoodsController < ApplicationController
  before_action :current_user_foods, only: %i[new create]

  def new
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.new
  end

  def create
    @inventory_food = InventoryFood.create(inventory_food_params)
    if @inventory_food.save
      flash[:notice] = 'Food added to inventory successfully'
      redirect_to inventory_path(@inventory_food.inventory.id)
    else
      flash[:alert] = 'Food cannnot be added to inventory'
      render :new
    end
  end

  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    @inventory_food.destroy
    redirect_to inventory_path(@inventory_food.inventory.id)
  end

  private

  def current_user_foods
    @foods = current_user.foods.collect { |food| [food.name, food.id] }
  end

  def inventory_food_params
    params.require(:inventory_food).permit(:food_id, :inventory_id, :quantity)
  end
end
