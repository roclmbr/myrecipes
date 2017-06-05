class CommentsController < ApplicationController
    
    before_action :require_user
    
   def create
      @recipe = Recipe.find(params[:recipe_id]) 
      @comment = @recipe.comments.build(comment_params)
       @comment.user = current_user
       if @comment.save
           flash[:success]="Comment saved"
           redirect_to recipe_path(@recipe)
       else
           flash[:danger]="Comment failed to save"
           redirect_to :back
       end
   end
    
    private
    
    def comment_params
       params.require(:comment).permit(:description) 
    end
    
end