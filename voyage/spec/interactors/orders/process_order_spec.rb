# frozen_string_literal: true

describe Orders::ProcessOrder do
  let_it_be(:order, reload: true) { create(:order) }

  let(:serivce) { described_class.new(order) }
  let(:result) { serivce.call }

  context "when success" do
    it "sets order as processed" do
      expect { result }.to change { order.reload.status }.from("completed").to("processed")
      expect(result).to be_success
    end
  end

  context "when failure" do
    it "doesn't process the order" do
      order.name = nil
      expect(result).to be_failure
      expect(order.reload).not_to be_processed
    end
  end
end
