require 'test_helper'

class UsersTestTest < ActionDispatch::IntegrationTest
    
   def setup
        @user = User.create!(username: "mashrur", 
                            email: "mashrur@example.com",
                        password: "password", 
                            password_confirmation: "password")
        @user2 = User.create!(username: "john", 
                                email: "john@example.com",
                        password: "password", 
                                password_confirmation: "password")
        @admin_user = User.create!(username: "Steve", email: "steve@steveadamson.com", password: "password",                                        password_confirmation: "password", admin: true)
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
       assert_select "a[href=?]", user_path(@admin_user), text: @admin_user.username.capitalize
   end
    
   test "should delete user" do
        sign_in_as(@admin_user, "password")
        get users_path
        assert_template 'users/index'
        assert_difference 'User.count', -1 do
          delete user_path(@user2)
        end
        assert_redirected_to users_path
        assert_not flash.empty?
    end 
    
      test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "mashrur3", 
                                  email: "mashrur3@example.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur3", @user.username
    assert_match "mashrur3@example.com", @user.email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@user2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch user_path(@user), params: { user: { username: updated_name, 
                                  email: updated_email } }
    assert_redirected_to users_path
    assert_not flash.empty?
    @user.reload
    assert_match "mashrur", @user.username
    assert_match "mashrur@example.com", @user.email
  end  
      
end
