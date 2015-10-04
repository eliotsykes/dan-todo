class Api::V1::ListsController < Api::ApiController
  respond_to :json

  def index
    render json: current_user.lists
  end

  def show
    render json: current_user.lists.find(params[:id])
  end

  def create
    list = current_user.lists.new(list_params)
    if list.save
      render json: list, status: :created
    else
      render_errors list
    end
  end

  def update
    list = current_user.lists.find(params[:id])
    if list.update(list_params)
      head :no_content
    else
      render_errors list
    end
  end

  def destroy
    respond_with current_user.lists.destroy(params[:id])
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def render_errors(list)
    render json: {errors: list.errors.full_messages}, status: :unprocessable_entity
  end

end
