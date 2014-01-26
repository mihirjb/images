class ImagesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index,:show]
  impressionist :actions=>[:show]
  
  def index
    @images = Image.all
      if params[:search]
        @images = Image.where("title Like ?", "%#{params[:search]}%") 
     end
  end

  def new
    @image = current_user.images.new
  end

  def create
    @image = current_user.images.create(image_params)
    if @image.save
      redirect_to :root, :notice =>"Image added Successfully."
    else
      redirect_to :root, :notice => "Image could not be added"
    end
  end
  
  def show
    @image = Image.find(params[:id])
    @comment= @image.comments.build
    @comments = Comment.where("image_id = ?", @image.id)
    
  end
  
  
  def edit
     @image = Image.find(params[:id])
   end

   def update
     @image = current_user.images.find(params[:id])
      if @image.update(image_params())
         redirect_to :root, :notice => "Congratulations, image updated Successfully."
       else
         redirect_to :back, :notice => "Alas, image could not be updated."
       end
   end

   def destroy
     @image = current_user.images.find(params[:id]).destroy
   end
  
  
  
   def vote_for_image
       @image = Image.find(params[:id])
       current_user.vote_for(@image)
       respond_to do |format|
         format.js
       end
   end
   def vote_against_image
        @image = Image.find(params[:id])
        current_user.vote_against(@image)
        respond_to do |format|
          format.js
        end
    end
    
    
    def titles
       @images = Image.where("title Like ?", "%#{params[:search]}%") 
       render json: @images.map(&:title)  
     end
  
  private 
   def image_params
    params.require(:image).permit(:title, :description, :picture, :picture_file_name, :picture_content_type, :picture_file_size)
   end
end
