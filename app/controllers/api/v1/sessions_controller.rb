class Api::V1::SessionsController < Api::ApiController
  
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_by_email(user_params[:email])
 
    if user && user.valid_password?(user_params[:password])
      render json: { token: user.api_key }, status: :created
    else
      raise "Unexpected condition in api sessions controller"
    end
    
  end

  private

  def user_params
    @user_params ||= if @user_params.nil?
      user_parameters = params.require(:user)
      user_parameters.require(:email)
      user_parameters.require(:password)
      user_parameters.permit(:email, :password)
    end
  end

end
