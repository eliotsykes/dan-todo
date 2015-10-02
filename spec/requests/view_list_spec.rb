require 'rails_helper'

describe 'view list' do

  context 'GET /api/v1/lists/:id' do

    it 'responds with list belonging to user' do
      user = create(:user)
      list = create(:list, title: 'Groceries', user: user)

      parameters = nil
      headers = {"X-Api-Key" => user.api_key}.merge(json_request_headers)
      get "/api/v1/lists/#{list.id}", parameters, headers

      expect(response).to have_http_status :ok
      expect(response.content_type).to eq("application/json")
      expect(json).to eq({ list: { id: list.id, title: list.title } })
    end

    it 'responds with 403 Not Authorized when auth token missing' do
      list = create(:list, title: 'Groceries')

      parameters = nil
      get "/api/v1/lists/#{list.id}", parameters, json_request_headers

      expect(response).to have_http_status :unauthorized
    end

    xit 'responds with 404 Not Found for list belonging to another user' do

    end

    xit 'responds with 404 Not Found for non-existent list' do

    end

  end

end
