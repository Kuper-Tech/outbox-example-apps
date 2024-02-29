# frozen_string_literal: true

describe Api::V1::Orders::InboxItemsController do
  let_it_be(:order) { create(:order) }
  let_it_be(:item_1) { create(:order_inbox_item, order: order) }
  let_it_be(:item_2) { create(:order_inbox_item, order: order) }

  let(:data) { response.parsed_body["data"] }

  describe "#index" do
    it "returns order's inbox items" do
      get :index, params: {order_id: order.uuid}

      expect(response).to be_successful
      expect(data.size).to eq 2
      expect(data[0]["id"]).to eq item_2.uuid
      expect(data[1]["id"]).to eq item_1.uuid
    end
  end
end
