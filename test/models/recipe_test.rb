require "test_helper"

class RecipeTest < ActiveSupport::TestCase
   def setup
      @recipe = Recipe.new(name: "vegetable", description: "Vegetable recipe") 
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