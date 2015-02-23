require 'rails_helper'


describe ListsController do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    sign_in @user
  end

  describe '#create' do
    it "creates 2 lists for the user" do
      expect( @user.lists.count ).to eq(0)
      @user.lists.create
      expect( @user.lists.count ).to eq(1)
      @user.lists.create
      expect( @user.lists.count ).to eq(2)
    end
  end

  describe '#edit' do
    it "edits the list title" do
      list = @user.lists.create
      list.update_attribute(:title, 'Hi')
      expect( list.title ).to eq('Hi')
    end
  end

  describe '#destroy' do
    it "creates then destroys a new list from the user" do
      list = @user.lists.create
      expect( @user.lists.count ).to eq(1)
      list.destroy      
      expect( @user.lists.count ).to eq(0)
    end
  end

end