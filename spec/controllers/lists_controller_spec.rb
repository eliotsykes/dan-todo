require 'rails_helper'


describe ListsController do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    sign_in @user
  end

  describe '#create' do
    it "creates 2 lists" do
      post :create, list: { title: 'test', user: @user }
      @list = List.last
      expect(List.count).to eq(1)
      expect(@list.title).to eq('test')
      expect(response).to redirect_to(list_path(@list.id))
    end
  end

  describe '#update' do
    it "updates the list title" do
      @list = create(:list)
      put :update, id: @list.id, list: { title: 'I\'ve been updated' }
      @list.reload
      expect(response).to redirect_to(list_path(@list.id))
      expect(@list.title).to eq('I\'ve been updated')
    end
  end

  describe '#destroy' do
    it "creates then destroys a new list" do
      @list = create(:list)
      expect( List.count ).to eq(1)
      delete :destroy, id: @list.id
      expect( List.count ).to eq(0)
    end
  end

end
