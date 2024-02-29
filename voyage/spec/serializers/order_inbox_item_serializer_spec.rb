# frozen_string_literal: true

describe OrderInboxItemSerializer do
  let_it_be(:inbox_item) { create(:order_inbox_item) }

  let(:order) { outbox_item.order }
  let(:serializer) { described_class.new(inbox_item) }
  let(:result) { serializer.serializable_hash }
  let(:expected_attribute_names) do
    [
      :event_key,
      :bucket,
      :status,
      :options,
      :errors_count,
      :error_log,
      :payload,
      :processed_at,
      :created_at,
      :updated_at
    ]
  end

  it "serializes required attributes" do
    expect(result[:data][:attributes]).to include(*expected_attribute_names)
    expect(result[:data][:attributes][:payload]).to include(:id, :name, :qty, :price, :description)
  end
end
