class ListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @list = List.find(params[:id])
    authorize @list
  end

  def index
    @lists = current_user.lists
    authorize @lists
  end

  def new
    @list = List.new
    authorize @list
  end

  def edit
    @list = List.find(params[:id])
    authorize @list
  end

  def create
    @list = current_user.lists.build(list_params)
    authorize @list

    if @list.save
      flash[:notice] = "List was saved."
      redirect_to @list
    else
      flash[:error] = "There was an error saving the list. Please try again."
      render :new
    end
  end

  def update
    @list = current_user.lists.find(params[:id])

    if @list.update_attributes(list_params)
      flash[:notice] = "List was updated."
      redirect_to @list
    else
      flash[:error] = "There was an error updating the list. Please try again."
      render :edit
    end
  end

  def destroy
    @list = current_user.lists.find(params[:id])
    title = @list.title

    if @list.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @list
    else
      flash[:error] = "There was an error deleting the list. Please try again."
      render :show
    end
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

end
