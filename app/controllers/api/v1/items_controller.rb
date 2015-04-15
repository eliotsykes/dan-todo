class Api::V1::ItemsController < Api::ApiController
  respond_to :json

  def create

    @list = current_user.lists.find(params[:list_id])
    @items = @list.items
    @item = @list.items.build(item_params)
    @item.list = @list

    if @item.save
      render json: @item
    end
  end

  def destroy
    @list = current_user.lists.find(params[:list_id])
    @item = @list.items.find(params[:id])
    respond_with @item.destroy
  end

  private
  def item_params
    params.require(:item).permit(:name)
  end

end
