class RecipesController < ApplicationController
  def index
    render json: Recipe.all, status: :ok
  end

  def create
    #   with a logged in user and valid data
    #   creates a new recipe in the database (FAILED - 1)
    #   returns the new recipe along with its associated user (FAILED - 2)
    #   returns a 201 (Created) HTTP status code (FAILED - 3)
    recipe = @current_user.recipes.create!(recipe_params)
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
