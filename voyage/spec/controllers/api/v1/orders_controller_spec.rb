# frozen_string_literal: true

describe Api::V1::OrdersController do
  let_it_be(:order_1) { create(:order) }
  let_it_be(:order_2) { create(:order) }
  let_it_be(:order_3) { create(:order) }
  let(:data) { response.parsed_body["data"] }

  describe "#index" do
    it "returns orders" do
      expect(get(:index)).to be_successful
      expect(data.size).to eq 2
      expect(data[0]["id"]).to eq order_3.uuid
      expect(data[1]["id"]).to eq order_2.uuid
    end

    it "paginates orders" do
      expect(get(:index, params: {page: 2})).to be_successful
      expect(data.size).to eq 1
      expect(data[0]["id"]).to eq order_1.uuid
    end
  end

  describe "#show" do
    it "returns order" do
      expect(get(:show, params: {id: order_1.uuid})).to be_successful
      expect(data["id"]).to eq order_1.uuid
    end
  end
end
