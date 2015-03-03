class ItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = current_user.items.build(item_params)
    authorize @item

    if @item.save
      flash[:notice] = "Item was saved."
      redirect_to @item
    else
      flash[:error] = "There was an error saving the item. Please try again."
      render :new
    end
  end

  private

  def item_params
    params.require(:list).permit(:name)
  end

end