class PagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def dashboard
    @images = current_user.images.all
    @image = current_user.images.build
  end
end
