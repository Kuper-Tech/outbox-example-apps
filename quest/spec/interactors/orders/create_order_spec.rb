# frozen_string_literal: true

describe Orders::CreateOrder do
  let(:serivce) { described_class.new(params: order_params) }
  let(:result) { serivce.call }
  let(:order_params) { {name: "Foo", qty: "1", price: "4.20", description: "Bar"} }

  context "when all params are valid" do
    it "creates order" do
      expect { result }.to change(Order, :count)
      expect(result).to be_success
    end
  end

  context "when params are invalid" do
    it "returns error" do
      order_params[:name] = nil
      expect { result }.not_to change(Order, :count)
      expect(result).to be_failure
    end
  end
end
