require 'rails_helper'

describe 'update lists api' do
  it 'updates a list' do
    user = create(:user)
    list1 = create(:list, title: 'List 1', user: user)

    parameters = {list: {title: "New Title"}}.to_json
    headers = {"X-Api-Key" => user.api_key}.merge(json_request_headers)

    put "/api/v1/lists/#{list1.id}", parameters, headers

    list = List.last

    expect(response).to have_http_status :no_content
    expect(list.title).to eq("New Title")
  end

  it 'does not perform an invalid update' do
    user = create(:user)
    list = create(:list, title: 'Groceries', user: user)

    parameters = {list: {title: ""}}.to_json
    headers = {"X-Api-Key" => user.api_key}.merge(json_request_headers)

    put "/api/v1/lists/#{list.id}", parameters, headers

    expect(response).to have_http_status :unprocessable_entity
    expect(response.content_type).to eq("application/json")
    expect(json).to eq errors: ["Title can't be blank"]
    expect(List.last.title).to eq("Groceries")
  end
end
