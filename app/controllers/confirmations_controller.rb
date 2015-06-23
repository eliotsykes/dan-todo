class ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
    "#{login_path}?notifications=confirmed"
  end
  
end
