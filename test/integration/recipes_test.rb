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
        assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit recipe"
       assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete recipe" 
    end
    
    test "create valid recipe" do
        get new_recipe_path
        assert_template 'recipes/new'
        name_of_recipe = "Chicken kiev"
        description_of_recipe = "add chicken, cook for 20 minutes"
        assert_difference 'Recipe.count', 1 do
           post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe}} 
        end
        follow_redirect!
        assert_match name_of_recipe.capitalize, response.body
        assert_match description_of_recipe, response.body
    end
    
    test "Reject invalid recipe" do
         get new_recipe_path
        assert_template 'recipes/new'
        assert_no_difference 'Recipe.count' do
           post recipes_path, params: { recipe: {name: "", description: ""} }
        end
        assert_template 'recipes/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
end
