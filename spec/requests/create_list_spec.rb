require 'rails_helper'

describe 'create list api' do
  it 'creates a list' do

    user = create(:user)
    api_key = user.api_key

    post "/api/v1/lists", {"list" => {"title" => "List 1"}}, "X-Api-Key" => api_key

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    json = JSON.parse(response.body, symbolize_names: true)
    expect(List.last.title).to eq("List 1")
    expect(List.last.user).to eq(user)
  end
end
