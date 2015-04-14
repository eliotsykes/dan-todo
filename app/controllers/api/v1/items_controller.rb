class Api::V1::ItemsController < Api::ApiController
  respond_to :json

  before_action :authenticate

  def create

    @list = List.find(params[:list_id])
    @items = @list.items
    @item = @list.items.build(item_params)
    @item.list = @list

    if @item.save
      render json: @item
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @item = @list.items.find(params[:id])
    respond_with @item.destroy(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name)
  end

end
