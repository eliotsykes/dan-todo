require 'rails_helper'

describe ListsController do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    sign_in @user
  end

  describe '#create' do
    it "creates a list and checks it's title" do
      post :create, list: { title: 'test'}
      list = List.last
      expect(List.count).to eq(1)
      expect(list.title).to eq('test')
    end

    it "attempts to create a list with no user" do
      sign_out @user
      post :create, list: { title: 'test' }
      expect(List.count).to eq(0)
    end
  end

  describe '#update' do
    it "updates the list title" do
      list = create(:list, user: @user)
      put :update, id: list.id, list: { title: 'I\'ve been updated' }
      list.reload
      expect(response).to redirect_to(lists_path)
      expect(list.title).to eq('I\'ve been updated')
    end

    it "fails to update a list with no user" do
      sign_out @user
      list = create(:list, user: @user, title: "Original Title")

      put :update, id: list.id, list: { title: 'I\'ve been updated' }

      expect(list.reload.title).to eq("Original Title")
    end

    it "prevents an attacker from updating another user's list" do
      attacker = @user
      victim = create(:user)
      list = create(:list, user: victim, title: "Title")
      expect do
        put :update, id: list.id, list: { title: 'I\'ve been updated' }
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(list.reload.title).to eq("Title")
    end
  end

  describe '#destroy' do
    it "creates then destroys a new list" do
      list = create(:list, user: @user)
      expect( List.count ).to eq(1)
      delete :destroy, id: list.id
      expect( List.count ).to eq(0)
    end

    it "attempts to create then destroy a list without a user" do
      list = create(:list)
      sign_out @user
      expect( List.count ).to eq(1)
      delete :destroy, id: list.id
      expect( List.count ).to eq(1)
    end

    it "prevents an attacker from deleting another user's list" do
      attacker = @user
      victim = create(:user)
      list = create(:list, user: victim)
      expect do
        delete :destroy, id: list.id
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(List.exists?(list.id)).to eq(true)
    end
  end

end
