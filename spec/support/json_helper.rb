module JsonHelper
  def json
    @json ||= JsonHelper.parse(response.body)
  end

  def json_request_headers
    { "Content-Type" => "application/json", "Accept" => "application/json" }
  end

  def self.parse(json_string)
    JSON.parse(json_string, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include JsonHelper, type: :request
end
