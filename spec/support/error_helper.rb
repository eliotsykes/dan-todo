module ErrorHelper

  # See: https://github.com/rails/rails/pull/11289#issuecomment-118612393
  def without_error_debugging
    env_config = Rails.application.env_config
    original_show_exceptions = env_config["action_dispatch.show_exceptions"]
    original_show_detailed_exceptions = env_config["action_dispatch.show_detailed_exceptions"]
    env_config["action_dispatch.show_exceptions"] = true
    env_config["action_dispatch.show_detailed_exceptions"] = false
    yield
  ensure
    env_config["action_dispatch.show_exceptions"] = original_show_exceptions
    env_config["action_dispatch.show_detailed_exceptions"] = original_show_detailed_exceptions
  end

end

RSpec.configure do |config|
  config.include ErrorHelper, type: :request
end
