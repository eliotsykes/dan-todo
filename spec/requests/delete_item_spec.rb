require 'rails_helper'

describe 'delete list item  api' do
  it 'deletes a list item' do

    user = create(:user)
    api_key = user.api_key
    list1 = create(:list, :title => 'List 1', :user => user)
    item = create(:item, :name => 'Item', :list => list1)

    delete "/api/v1/lists/#{list1.id}/items/#{item.id}.json", nil, "X-Api-Key" => api_key

    expect(response.status).to eq(204)
  end
end
