class Api::V1::ListsController < Api::ApiController
  respond_to :json

  def index
    render json: @user.lists
  end

  def new
    @list = List.new
  end

  def create
    @list = @user.lists.new(list_params)
    if @list.save
      render json: @list
    end
  end

  def update
    respond_with current_user.lists.find(params[:id]).update_attributes(list_params)
  end

  def destroy
    respond_with current_user.lists.destroy(params[:id])
  end

  private
  def list_params
    params.require(:list).permit(:title)
  end

end
