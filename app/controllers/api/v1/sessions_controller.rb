class Api::V1::SessionsController < Api::ApiController
  
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_by_email(user_params[:email])
 
    if user && user.valid_password?(user_params[:password])
      render json: { token: user.api_key }, status: :created
    else
      head :no_content
    end
    
  end

  private

  def user_params
    user_params = params.require(:user)
    user_params.require(:email)
    user_params.require(:password)
    user_params.permit(:email, :password)
    # @user_params ||= params.require(:user).permit(:email, :password)
  end

end
