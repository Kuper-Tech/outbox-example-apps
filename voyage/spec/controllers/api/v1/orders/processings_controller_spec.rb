# frozen_string_literal: true

describe Api::V1::Orders::ProcessingsController do
  let_it_be(:order, reload: true) { create(:order) }

  describe "#create" do
    context "when success" do
      it "sets order as processed" do
        post :create, params: {order_id: order.uuid}

        expect(response).to be_successful
        expect(order.reload).to be_processed
      end
    end

    context "when failure" do
      it "doesn't process the order" do
        order.name = nil
        expect(Order).to receive(:find_by!).and_return(order)

        post :create, params: {order_id: order.uuid}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(order.reload).not_to be_processed
      end
    end
  end
end
