class Api::V1::UsersController < Api::ApiController

  skip_before_action :authenticate, only: :create

  def create
    # Creating a user triggers Devise to send confirmation email:
    User.create!(registration_params)
    head :no_content
  end

  private

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
