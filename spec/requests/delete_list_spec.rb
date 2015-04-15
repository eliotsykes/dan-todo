require 'rails_helper'

describe 'delete lists api' do
  it 'deletes a list' do

    user = create(:user)
    api_key = user.api_key
    list1 = create(:list, :title => 'List 1', :user => user)

    delete "/api/v1/lists/#{list1.id}.json", nil, "X-Api-Key" => api_key

    expect(response.status).to eq(204)
  end
end
