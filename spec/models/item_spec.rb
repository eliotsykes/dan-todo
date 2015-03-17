require 'rails_helper'

describe Item do

  before do
    @user = create(:user)
    @list = create(:list, user: @user)
  end

  describe 'days_left' do
    it "shows 7 days left on an item after creation" do
      @item = create(:item, list: @list)
      expect(@item.days_left).to eq(7)
    end
  end

end
