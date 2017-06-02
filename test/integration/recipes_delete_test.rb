require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
    
 def setup
        @user = User.create!(username: "Dick", email: "dick@steveadamson.com", password: "password", password_confirmation: "password", admin: true)
        @recipe = Recipe.create(name: "Vegetables", description: "Great vegetables", user: @user)
 end
   
 test "successful deletion" do
     sign_in_as(@user, "password")
     get recipe_path(@recipe)
     assert_template 'recipes/show'
     assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete recipe"
     assert_difference 'Recipe.count', -1 do
        delete recipe_path(@recipe) 
     end
     assert_redirected_to recipes_path
     assert_not flash.empty?
 end
end
