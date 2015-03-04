class ItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @list = @user.lists.find(params[:list_id])
    @item = @list.items.build(item_params)

    if @item.save
      flash[:notice] = "Item was saved."
    else
      flash[:error] = "There was an error saving the item. Please try again."
    end
    redirect_to user_list_path(@user, @list)
  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

end