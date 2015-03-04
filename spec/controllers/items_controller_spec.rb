require 'rails_helper'


describe ItemsController do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    sign_in @user
    @list = @user.lists.build(title: 'List')
    @list.save!
  end

  describe '#create' do
    it "adds an item" do
      @item = @list.items.build(name: 'Item')
      expect(@item.list.title).to eq('List')    
    end

    it "attempts to create a list with no user" do
      sign_out @user
      @item = @list.items.build(name: 'Item')
      expect(Item.count).to eq(0)
    end
  end

end
