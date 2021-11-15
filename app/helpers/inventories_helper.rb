module InventoriesHelper
  def can_view_inventory?(inventory)
    return true if current_user.id == inventory.user_id
  end
end
