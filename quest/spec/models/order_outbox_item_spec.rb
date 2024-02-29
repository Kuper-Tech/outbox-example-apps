# frozen_string_literal: true

describe OrderOutboxItem do
  it "creates an outbox item" do
    expect(create(:order_outbox_item, :with_payload)).to be_persisted
  end
end
