require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "should get signup path" do
     get signup_path
      assert_response :success
  end
    
    test "reject invalid signup" do
        get signup_path
        assert_no_difference "User.count" do
            post users_path, params: { user: { username: " ", email: " ", password: " ", password_confirmation: " "}}
        end
        assert_template 'users/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
    
    test "accept valid signup" do
        get signup_path
        assert_difference "User.count", 1 do
            post users_path, params: { user: { username: "Steve1", email: "steve1@steve.com", password: "password", password_confirmation: "password"}}
        end
        follow_redirect!
        assert_template 'users/show'
        assert_not flash.empty?
    end
end
