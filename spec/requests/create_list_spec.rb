require 'rails_helper'

describe 'create list api' do
  it 'creates a list' do

    user = create(:user)
    api_key = user.api_key

    post "/api/v1/lists", {"list" => {"title" => "List 1"}}, "X-Api-Key" => api_key

    list = List.last

    expect(response).to have_http_status :created
    expect(response.content_type).to eq("application/json")
    expect(json.keys).to eq([:list]), "should have 'list' root node"
    expect(json[:list]).to eq({id: list.id, title: "List 1"})
    expect(list.title).to eq("List 1")
    expect(list.user).to eq(user)
  end

  it 'does not create an invalid list' do
    user = create(:user)

    parameters = {list: {title: ""}}.to_json
    headers = {"X-Api-Key" => user.api_key}.merge(json_request_headers)

    post "/api/v1/lists", parameters, headers

    expect(response).to have_http_status :unprocessable_entity
    expect(response.content_type).to eq("application/json")
    expect(json).to eq errors: ["Title can't be blank"]
    expect(List.count).to eq 0
  end
end
