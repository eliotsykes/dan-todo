require 'rails_helper'

describe 'create list item api' do
  it 'creates a list item' do

    user = create(:user)
    api_key = user.api_key
    list1 = create(:list, :title => 'List 1', :user => user)

    post "/api/v1/lists/#{list1.id}/items", {"item" => {"name" => "item 1"}}, "X-Api-Key" => api_key

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:name]).to eq("item 1")
    expect(Item.last.name).to eq("item 1")
  end
end
