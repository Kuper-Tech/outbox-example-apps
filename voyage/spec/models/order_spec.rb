# frozen_string_literal: true

describe Order do
  let(:order) { build(:order) }

  it "creates an order" do
    expect(order.save).to be true
  end
end
