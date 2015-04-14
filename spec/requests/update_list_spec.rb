require 'rails_helper'

describe 'view lists api' do
  it 'shows all lists' do

    user = create(:user)
    api_key = user.api_key
    list1 = create(:list, :title => 'List 1', :user => user)

    put "/api/v1/lists/#{list1.id}.json", {"list" => {"title" => "New Title"}}, "X-Api-Key" => api_key

    expect(response.status).to eq(204)
    expect(List.last.title).to eq("New Title")
    expect(List.last.user).to eq(user)
  end
end
