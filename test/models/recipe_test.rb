require "test_helper"

class RecipeTest < ActiveSupport::TestCase
   def setup
      @user = User.create!(username: "steve", email: "mail@steveadamson.com")
      @recipe = @user.recipes.build(name: "vegetable", description: "Vegetable recipe") 
   end
    
    test "recipe without user should be invalid" do
       @recipe.user_id = nil
        assert_not @recipe.valid?
    end
    
    test "recipe is valid" do
        assert @recipe.valid?
    end
    
    test "name should be present" do
       @recipe.name = ""
       assert_not @recipe.valid?
    end
    
    test "description present" do
       @recipe.description = ""
       assert_not @recipe.valid?
    end
    
    test "Description length too short" do
       @recipe.description = "a" * 3 
       assert_not @recipe.valid?
    end
    
    test "Description length too long" do
       @recipe.description = "a" * 501
        assert_not @recipe.valid?
    end  
end