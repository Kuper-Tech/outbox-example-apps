# frozen_string_literal: true

describe Api::V1::OrdersController do
  describe "#show" do
    let(:order) { create(:order) }

    it "returns order" do
      expect(get(:show, params: {id: order.uuid})).to be_successful
      expect(response.parsed_body["data"]["id"]).to eq order.uuid
    end
  end

  describe "#create" do
    let(:order_params) { {order: {name: "Foo", qty: "1", price: "4.20", description: "Bar"}} }

    context "when params are valid" do
      it "returns order" do
        expect { post :create, params: order_params }.to change(Order, :count)
        expect(response).to be_successful
      end
    end

    context "when params are invalid" do
      it "returns error" do
        order_params[:order][:name] = nil
        expect { post :create, params: order_params }.not_to change(Order, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
