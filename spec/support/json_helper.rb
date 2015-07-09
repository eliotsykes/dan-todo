module JsonHelper
  def json
    @json ||= JSON.parse(response.body, symbolize_names: true)
  end

  def json_request_headers
    { "Content-Type" => "application/json", "Accept" => "application/json" }
  end
end

RSpec.configure do |config|
  config.include JsonHelper, type: :request
end
