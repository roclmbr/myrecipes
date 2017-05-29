require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
 def setup
        @user = User.create!(username: "Dick", email: "dick@steveadamson.com", password: "password", password_confirmation: "password")
        @recipe = Recipe.create(name: "Vegetables", description: "Great vegetables", user: @user)
 end
    
    test "reject invalid update" do
        sign_in_as(@user, "password")
        get edit_recipe_path(@recipe)
        assert_template 'recipes/edit'
        patch recipe_path(@recipe), params: { recipe: { name: "", description: "Some description"}}
        assert_template 'recipes/edit'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
    
    test "successful edit" do
        sign_in_as(@user, "password")
        get edit_recipe_path(@recipe)
        assert_template 'recipes/edit'
        updated_name = "upadted recipe name"
        updated_description = "updated description"
        patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description}}
        assert_redirected_to @recipe
        assert_not flash.empty?
        @recipe.reload
        assert_match updated_name, @recipe.name
        assert_match updated_description, @recipe.description
    end
end
    
   