require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
    
    def setup
       @user = User.create!(username: "Bob", email: "bob@steve.com", password: "password", password_confirmation: "password") 
    end
    
  test "Invalid login rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " "}}
      assert_template 'sessions/new'
      assert_not flash.empty?
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", logout_path, count: 0
      get root_path
      assert flash.empty?
  end
    
    test "Valid login accepted" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: @user.email, password: @user.password}}
      assert_redirected_to @user
      follow_redirect!
      assert_template 'users/show'
      assert_not flash.empty?
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(@user)
      assert_select "a[href=?]", edit_user_path(@user) 
    end
end
