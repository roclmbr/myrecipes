require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
 def setup
        @user = User.create!(username: "Dick", email: "dick@steveadamson.com", password: "password", password_confirmation: "password")
        @recipe = Recipe.create(name: "Vegetables", description: "Great vegetables", user: @user)
 end

    test "reject invalid edit" do
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), params: { user: { username: " ", email: "dick@steveadamson.com" }}
        assert_template 'users/edit'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
    
    test "accept valid signup" do
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), params: { user: { username: "Dick1", email: "dick@steveadamson.com" }}
        assert_redirected_to @user
        assert_not flash.empty?
        @user.reload
        assert_match "Dick1", @user.username 
        assert_match "dick@steveadamson.com", @user.email
    end
end
