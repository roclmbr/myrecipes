require 'test_helper'

class UsersTestTest < ActionDispatch::IntegrationTest
    
   def setup
        @user = User.create!(username: "Dick", email: "dick@steveadamson.com", password: "password",                                      password_confirmation: "password")
        @user2 = User.create!(username: "Bob", email: "bob@steveadamson.com", password: "password",                                        password_confirmation: "password")
    end  
    
  test "index valid" do
    get users_path
    assert_response :success
  end
    
   test "get listing" do
       get users_path
       assert_template 'users/index'
       assert_select "a[href=?]", user_path(@user), text: @user.username.capitalize
       assert_select "a[href=?]", user_path(@user2), text: @user2.username.capitalize
   end
    
   test "should delete user" do
        sign_in_as(@user, "password")
        get users_path
        assert_template 'users/index'
        assert_difference 'User.count', -1 do
          delete user_path(@user)
        end
        assert_redirected_to users_path
        assert_not flash.empty?
    end 
      
end
