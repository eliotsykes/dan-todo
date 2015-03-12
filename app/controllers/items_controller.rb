class ItemsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def create
    @list = List.find(params[:list_id])
    @items = @list.items.order(created_at: :desc)

    @item = @list.items.build(item_params)
    @item.list = @list
    @new_item = Item.new

    if @item.save
      flash[:notice] = "Item was saved."
    else
      flash[:error] = "There was an error saving the item. Please try again."
    end

    respond_with(@item) do |format|
      format.html { redirect_to [@list] }
    end

  end

  def destroy
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:id])

    if @item.destroy
      flash[:notice] = "Item was deleted."
    else
      flash[:error] = "Error deleting item. Please try again."
    end

    respond_with(@item) do |format|
      format.html { redirect_to [@list] }
    end

  end

  private

  def item_params
    params.require(:item).permit(:name)
  end

end