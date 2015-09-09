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
end
