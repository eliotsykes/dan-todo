require 'rails_helper'

describe List do
  context "validations" do
    it "requires title" do
      list = List.new(title: "")
      expect(list.valid?).to eq false
      expect(list.errors[:title]).to include "can't be blank"
    end
  end
end
