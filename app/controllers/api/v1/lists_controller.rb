class Api::V1::ListsController < Api::ApiController
  respond_to :json
 
  before_action :authenticate

  def index
    # @lists = @user.lists
    # respond_with @lists
    render json: @user.lists
  end

end