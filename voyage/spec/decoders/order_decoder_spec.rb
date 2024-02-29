# frozen_string_literal: true

describe OrderDecoder do
  let(:decoder) { described_class.new(payload) }
  let(:payload) { build(:order_inbox_item).payload }

  it "decodes a message" do
    expect(decoder.decode.keys)
      .to include(:id, :name, :qty, :description, :status, :price, :updated_at, :created_at)
  end
end
