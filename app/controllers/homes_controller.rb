class HomesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to new_scribble_path
    end
  end

  def home
    render :index
  end
end
