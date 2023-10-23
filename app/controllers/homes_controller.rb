class HomesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to scribbles_path
    end
  end

  def home
    render :index
  end
end
