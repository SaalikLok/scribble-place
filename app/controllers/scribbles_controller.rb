class ScribblesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @scribbles = pagy_countless(current_user.scribbles.order(updated_at: :desc), items: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @scribble = Scribble.new
  end

  def create
    @scribble = Scribble.new(scribble_params)
    @scribble.user = current_user

    if @scribble.save
      respond_to do |format|
        format.html { redirect_to scribbles_path, notice: "Scribble created!" }
        format.turbo_stream
      end
    else
      flash[:alert] = "Something went wrong"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @scribble = Scribble.find(params[:id])
  end

  def update
    @scribble = Scribble.find(params[:id])
    @scribble.user = current_user
    if @scribble.update_attributes(params[:scribble])
      flash[:notice] = "Scribble was successfully updated"
      redirect_to scribbles_path
    else
      flash[:alert] = "Something went wrong"
      render "edit"
    end
  end

  def destroy
    @scribble = Scribble.find(params[:id])
    @scribble.user = current_user

    if @scribble.destroy
      flash[:notice] = "Scribble was successfully deleted."
    else
      flash[:alert] = "Something went wrong"
    end

    redirect_to scribbles_path
  end

  private

  def scribble_params
    params.require(:scribble).permit(:content)
  end
end
