class ImagesController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index,:show]
  impressionist :actions=>[:show]
  
  def index
    @images = Image.all
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
  
  
  
  private 
   def image_params
    params.require(:image).permit(:title, :description, :picture, :picture_file_name, :picture_content_type, :picture_file_size)
   end
end
