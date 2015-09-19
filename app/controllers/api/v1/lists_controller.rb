class Api::V1::ListsController < Api::ApiController
  respond_to :json

  def index
    render json: current_user.lists
  end

  def create
    list = current_user.lists.new(list_params)
    if list.save
      render json: list, status: :created
    else
      render json: {errors: list.errors.full_messages}, status: :unprocessable_entity
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
