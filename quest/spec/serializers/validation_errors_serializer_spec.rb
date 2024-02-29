# frozen_string_literal: true

describe ValidationErrorsSerializer do
  let(:serializer) { described_class.new(errors, is_collection: false) }
  let(:errors) { object.errors }
  let(:result) { serializer.serializable_hash }

  describe "#full_messages" do
    let(:object) { build(:order, name: nil, qty: nil) }

    it "renders" do
      expect(object).not_to be_valid
      expect(result[:data][:attributes][:full_messages])
        .to include("Name can't be blank", "Qty can't be blank")
    end
  end

  describe "#details" do
    let(:object) { build(:order, name: nil, qty: nil) }

    it "renders" do
      expect(object).not_to be_valid
      expect(result[:data][:attributes][:details])
        .to eq(name: [{error: :blank}], qty: [{error: :blank}])
    end
  end
end
