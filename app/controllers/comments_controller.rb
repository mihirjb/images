class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
 
  def new
    @image = Image.find(params[:id])
    @comment = @image.comments.new
  end

  def create
    @image = Image.find(params[:comment][:image_id])
    @comment = @image.comments.create(comment_params())
    if @comment.save
      redirect_to :back, :notice => "Congratulations, comment created Successfully."
    else
      redirect_to :back, :notice => "Alas, comment could not be created."
    end
    
  end


 
  
  
    private 
    def comment_params
     params.require(:comment).permit(:commentbody,:user_id)
    end
end
