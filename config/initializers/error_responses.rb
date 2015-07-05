class UnsupportedMediaType < ActionController::ActionControllerError
end

ActionDispatch::ExceptionWrapper.rescue_responses.merge!(
  'UnsupportedMediaType' => :unsupported_media_type
)
