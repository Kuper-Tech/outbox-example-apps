# frozen_string_literal: true

describe Orders::InvalidCompleteOrder do
  let_it_be(:order, reload: true) { create(:order) }

  let(:serivce) { described_class.new(order, **params) }
  let(:result) { serivce.call }
  let(:outbox_item) { order.outbox_items.last }
  let(:params) { {} }

  context "when success" do
    it "completes the order" do
      expect { result }.to change { order.reload.status }.from("pending").to("completed")
      expect(result).to be_success
      expect(outbox_item.options[:key]).to eq order.uuid
      expect(outbox_item.options[:headers]["Idempotency-Key"]).to be_present
    end
  end

  context "when failure" do
    it "doesn't complete the order" do
      order.name = nil
      expect(result).to be_failure
      expect(order.reload).not_to be_completed
    end
  end

  context "when pass a custom payload" do
    let(:params) { {payload: "custom-payload"} }

    it "stores custom payload to db" do
      expect { result }.to change { order.reload.status }.from("pending").to("completed")
      expect(result).to be_success
      expect(outbox_item.payload).to eq "custom-payload"
    end
  end

  context "when pass an empty_message_key" do
    let(:params) { {empty_message_key: true} }

    it "doesn't store message key to options" do
      expect { result }.to change { order.reload.status }.from("pending").to("completed")
      expect(result).to be_success
      expect(outbox_item.options.key?(:key)).to be false
    end
  end

  context "when pass an empty_idempotency_key" do
    let(:params) { {empty_idempotency_key: true} }

    it "doesn't store idempotency key to headers" do
      expect { result }.to change { order.reload.status }.from("pending").to("completed")
      expect(result).to be_success
      expect(outbox_item.options[:headers]["Idempotency-Key"]).to be_empty
    end
  end
end
