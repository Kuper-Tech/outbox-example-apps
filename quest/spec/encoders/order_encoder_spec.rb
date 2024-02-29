# frozen_string_literal: true

describe OrderEncoder do
  let_it_be(:order) { create(:order, price: 4.2) }
  let(:encoder) { described_class.new(order) }
  let(:result) { encoder.encode }
  let(:encoded_data) { Protobuf::OrderData::Order.decode(result) }

  it "encodes to valid payload" do
    expect(encoded_data).to have_attributes(
      id: order.uuid,
      name: order.name,
      qty: order.qty,
      status: order.status.upcase.to_sym,
      description: order.description
    )

    expect(encoded_data.updated_at.seconds).to eq order.updated_at.to_i
    expect(encoded_data.created_at.seconds).to eq order.created_at.to_i
    expect(encoded_data.price).to have_attributes(
      currency_code: "RUB",
      units: 4,
      nanos: 20
    )
  end
end
