require 'rails_helper'

describe 'view lists api' do
  it 'shows all lists' do

    user = create(:user)
    api_key = user.api_key
    list1 = create(:list, :title => 'List 1', :user => user)
    list2 = create(:list, :title => 'List 2', :user => user)

    get "/api/v1/lists", {}, "X-Api-Key" => api_key

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:lists].first[:title]).to eq("List 1")
    expect(json[:lists].last[:title]).to eq("List 2")
  end
end