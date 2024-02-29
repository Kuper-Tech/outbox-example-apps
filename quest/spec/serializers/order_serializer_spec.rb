# frozen_string_literal: true

describe OrderSerializer do
  let(:serializer) { described_class.new(order) }
  let(:result) { serializer.serializable_hash }
  let(:expected_attribute_names) do
    [
      :name,
      :qty,
      :status,
      :price,
      :description,
      :updated_at,
      :created_at
    ]
  end

  let_it_be(:order) { create(:order) }

  it "serializes required attributes" do
    expect(result[:data][:attributes]).to include(*expected_attribute_names)
  end
end
