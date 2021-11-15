module RecipesHelper
  def can_add_recipe_to_food?(recipe)
    current_user.id == recipe.user_id
  end
end
