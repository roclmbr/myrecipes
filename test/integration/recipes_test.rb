require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = User.create!(username: "Dick", email: "dick@steveadamson.com")
        @recipe = Recipe.create(name: "Vegetables", description: "Great vegetables", user: @user)
        @recipe2 = @user.recipes.build(name: "Meat", description: "Great meats")
        @recipe2.save
    end
    
  test "index valid" do
    get recipes_path
    assert_response :success
  end
    
    test "get listing" do
       get recipes_path
        assert_template 'recipes/index'
        assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    end
    
    test "should get show" do
       get recipe_path(@recipe)
        assert_template 'recipes/show'
        assert_match @recipe.name, response.body
        assert_match @recipe.description, response.body
        assert_match @user.username, response.body
    end
end
