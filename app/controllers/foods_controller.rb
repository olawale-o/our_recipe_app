class FoodsController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @foods = Food.all.includes(:user)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    current_user.foods << @food
    if @food.save
      flash[:notice] = 'Food added successfully'
      redirect_to foods_path
    else
      flash[:alert] = 'Food not added'
      render :new
    end
  end

  def destroy
    previous_url = request.env['HTTP_REFERER']
    food = Food.find(params[:id])
    if food.destroy
      flash[:notice] = 'Food deleted successfully'
    else
      flash[:alert] = 'Food cannot deleted'
    end
    redirect_to(previous_url)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end