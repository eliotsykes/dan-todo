class Api::V1::SessionsController < Api::ApiController
  
  skip_before_action :authenticate, only: :create

  def create
    assert_request_content_type Mime::JSON
    
    respond_to do |format|
      format.json do
        user = User.find_by!(email: user_params[:email])
     
        if user && user.valid_password?(user_params[:password])
          render json: { token: user.api_key }, status: :created
        end
      end
    end
  end

  private

  def assert_request_content_type(content_type)
    raise UnsupportedMediaType unless request.content_type == content_type
  end

  def user_params
    @user_params ||= if @user_params.nil?
      user_parameters = params.require(:user)
      user_parameters.require(:email)
      user_parameters.require(:password)
      user_parameters.permit(:email, :password)
    end
  end

end
