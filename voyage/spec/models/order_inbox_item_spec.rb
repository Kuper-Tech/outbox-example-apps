# frozen_string_literal: true

describe OrderInboxItem do
  it "creates an inbox item" do
    expect(create(:order_inbox_item)).to be_persisted
  end
end
