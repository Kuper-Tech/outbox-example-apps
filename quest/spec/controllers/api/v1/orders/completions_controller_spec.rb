# frozen_string_literal: true

describe Api::V1::Orders::CompletionsController do
  let_it_be(:order, reload: true) { create(:order) }

  describe "#create" do
    context "when success" do
      it "completes the order" do
        post :create, params: {order_id: order.uuid}

        expect(response).to be_successful
        expect(order.reload).to be_completed
      end
    end

    context "when failure" do
      it "doesn't complete the order" do
        order.name = nil
        expect(Order).to receive(:find_by!).and_return(order)

        post :create, params: {order_id: order.uuid}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(order.reload).not_to be_completed
      end
    end
  end

  describe "#invalid_create" do
    context "when success" do
      it "completes the order" do
        post :invalid_create, params: {order_id: order.uuid, invalid_attr: "proto-payload", invalid_value: "bad-value"}

        expect(response).to be_successful
        expect(order.reload).to be_completed
      end
    end
  end
end
