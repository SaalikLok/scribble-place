class ScribblesController < ApplicationController
  before_action :authenticate_user!

  def index
    @scribbles = current_user.scribbles.order(created_at: :desc)
  end

  def new
    @scribble = Scribble.new
  end

  def create
    @scribble = Scribble.new(scribble_params)
    @scribble.user = current_user

    if @scribble.save
      redirect_to scribbles_path
    else
      flash[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @scribble = Scribble.find(params[:id])

    unless current_user == @scribble.user
      redirect_to scribbles_path, alert: "You are not authorized to edit this scribble."
    end
  end

  def update
    @scribble = Scribble.find(params[:id])
    @scribble.user = current_user
    @scribble.content = scribble_params[:content]
    if @scribble.save
      redirect_to scribbles_path
      flash[:notice] = "✏️ Your Scribble was updated."
    else
      flash[:alert] = "Something went wrong"
      render "edit"
    end
  end

  def destroy
    @scribble = Scribble.find(params[:id])

    if @scribble.user == current_user
      if @scribble.destroy
        flash[:notice] = "🗑️ Your Scribble was deleted."
      else
        flash[:alert] = "Something went wrong"
      end
    end

    redirect_to scribbles_path
  end

  private

  def scribble_params
    params.require(:scribble).permit(:content)
  end
end
