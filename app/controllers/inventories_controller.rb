class InventoriesController < ApplicationController
  load_and_authorize_resource except: [:show]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @inventories = current_user.inventories.all
  end

  def new
    @inventories = Inventory.new
  end

  def show
    @inventory = Inventory.find(params[:id])
    @inventory_foods = @inventory.inventory_foods
  end

  def create
    @inventory = Inventory.new(inventory_params)
    current_user.inventories << @inventory
    if @inventory.save
      flash[:notice] = 'Inventory added successfully'
      redirect_to inventories_path
    else
      flash[:alert] = 'Inventory cannot be added'
      render :new
    end
  end

  def destroy
    previous_url = request.env['HTTP_REFERER']
    inventory = Inventory.find(params[:id])
    if inventory.destroy
      flash[:notice] = 'Inventory deleted successfully'
    else
      flash[:alert] = 'Inventory cannot deleted'
    end
    redirect_to(previous_url)
  end

    private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
