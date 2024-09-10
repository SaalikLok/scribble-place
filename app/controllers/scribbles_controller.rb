require 'csv'

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

  def export_data
    @scribbles = current_user.scribbles.order(created_at: :desc)

    respond_to do |format|
      format.csv { send_data generate_csv(@scribbles), filename: "scribbles-#{Date.today}.csv" }
    end
  end

  private

  def generate_csv(scribbles)
    CSV.generate(headers: true) do |csv|
      csv << ["Created At", "Content"]

      scribbles.each do |scribble|
        csv << [scribble.created_at, scribble.content]
      end
    end
  end

  def scribble_params
    params.require(:scribble).permit(:content)
  end
end
