class Api::ApiController < ActionController::Base

  before_action :authenticate

  private

  def current_user
    @user
  end

  def authenticate
    api_key = request.headers['X-Api-Key']
    @user = User.find_by(api_key: api_key) if api_key

    unless @user
      head status: :unauthorized
      return false
    end
  end
end
