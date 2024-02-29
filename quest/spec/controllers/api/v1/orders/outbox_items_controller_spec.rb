# frozen_string_literal: true

describe Api::V1::Orders::OutboxItemsController do
  let_it_be(:order) { create(:order) }
  let_it_be(:item_1) { create(:order_outbox_item, :with_payload, order: order) }
  let_it_be(:item_2) { create(:order_outbox_item, :with_payload, order: order) }

  describe "#index" do
    let(:data) { response.parsed_body.fetch("data") }

    it "returns order outbox items" do
      get :index, params: {order_id: order.uuid}

      expect(response).to be_successful
      expect(data.size).to eq 2
      expect(data.first.fetch("id")).to eq item_2.uuid
      expect(data.second.fetch("id")).to eq item_1.uuid
    end
  end
end
