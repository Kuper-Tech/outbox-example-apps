# frozen_string_literal: true

describe InboxImporters::OrderImporter do
  let!(:inbox_item) { create(:order_inbox_item) }
  let(:service) { described_class.new(inbox_item, payload) }
  let(:result) { service.call }
  let(:payload) { inbox_item.payload }

  it "creates an order" do
    expect { result }.to change(Order, :count).by(1)
    expect(result).to be_success
  end

  context "when payload invalid" do
    let!(:inbox_item) { create(:order_inbox_item, :payload_with_empty_name) }

    it "returns failure" do
      expect { result }.not_to change(Order, :count)
      expect(result).to be_failure
    end
  end
end
