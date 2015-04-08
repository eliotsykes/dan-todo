class Api::V1::ListsController < Api::ApiController
  respond_to :json
 
  before_action :authenticate

  def index
    render json: @user.lists
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      respond_with @list
    end
  end

  def update 
    respond_with List.find(params[:id]).update_attributes(params[:list])
  end

  def destroy
    respond_with List.destroy(params[:id])
  end

  private
  def list_params
    params.require(:list).permit(:title)
  end

end