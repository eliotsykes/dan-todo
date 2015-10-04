require 'rails_helper'

describe ListSerializer do

  it "should serialize id and title under root list node" do
    list = create(:list, title: "Groceries")

    serialized = ListSerializer.new(list).to_json
    deserialized = JsonHelper.parse(serialized)

    expect(deserialized.keys).to eq([:list]), "Expected one root node"
    expect(deserialized[:list]).to eq({id: list.id, title: "Groceries"})
  end

end
