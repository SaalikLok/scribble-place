class ScribblesController < ApplicationController
  before_action :authenticate_user!

  def index
    @scribbles = Scribble.all
  end

  def new
    @scribble = Scribble.new
  end

  def create
    @scribble = Scribble.new(params[:scribble])
    if @scribble.save
      flash[:success] = "Scribble successfully created"
      redirect_to @scribble
    else
      flash[:error] = "Something went wrong"
      render "new"
    end
  end

  def edit
    @scribble = Scribble.find
  end

  def update
    @scribble = Scribble.find(params[:id])
    if @scribble.update_attributes(params[:scribble])
      flash[:success] = "Scribble was successfully updated"
      redirect_to @scribble
    else
      flash[:error] = "Something went wrong"
      render "edit"
    end
  end

  def destroy
    @scribble = Scribble.find(params[:id])
    if @scribble.destroy
      flash[:success] = "Scribble was successfully deleted."
    else
      flash[:error] = "Something went wrong"
    end

    redirect_to scribbles_url
  end
end
