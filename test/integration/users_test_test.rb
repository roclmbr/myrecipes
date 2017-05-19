require 'test_helper'

class UsersTestTest < ActionDispatch::IntegrationTest
    
   def setup
        @user = User.create!(username: "Dick", email: "dick@steveadamson.com", password: "password",                                      password_confirmation: "password")
        @user2 = User.create(username: "Bob", email: "bob@steveadamson.com", password: "password",                                        password_confirmation: "password")
        @recipe = Recipe.create(name: "Vegetables", description: "Great vegetables", user: @user)
        @recipe2 = @user.recipes.build(name: "Meat", description: "Great meats")
        @recipe2.save
    end  
    
  test "index valid" do
    get users_path
    assert_response :success
  end
    
   test "get listing" do
       get users_path
       assert_template 'users/index'
       assert_match @user.username, response.body
   end
      
end
