class FavoritesController < ApplicationController
  
  def decide
    @instance = current_user.favorites.find_by_image_id(params[:image_id])
    if @instance  
      @instance.destroy
    else
    current_user.favorites.create(:image_id => params[:image_id])
      render :layout => false
  end
end
  
   
   def show 
     @fav = Favorite.find(params[:id])
   end
   
   def destroy
   end
   
   private
    def fav_params
      params.require(:image_id).permit(:image_id)
     end   
    
end
