class ItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @list = List.find(params[:list_id])
    @user = current_user
    @item = @list.items.build(item_params)
    @item.list = @list
    @new_item = Item.new


    if @item.save
      flash[:notice] = "Item was saved."
      redirect_to user_list_path(@user, @list)
    else
      flash[:error] = "There was an error saving the item. Please try again."
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

end