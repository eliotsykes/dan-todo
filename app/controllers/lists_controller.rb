class ListsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lists = current_user.lists
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      flash[:notice] = "List was saved."
      redirect_to [@list]
    else
      flash[:error] = "There was an error saving the list. Please try again."
      render :new
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update_attributes(list_params)
      flash[:notice] = "List was updated."
      redirect_to [@list]
    else
      flash[:error] = "There was an error updating the list. Please try again."
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    title = @list.title

    if @list.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to [@list]
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
