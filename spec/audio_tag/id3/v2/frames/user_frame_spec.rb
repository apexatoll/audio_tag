RSpec.describe AudioTag::ID3::V2::Frames::UserFrame do
  subject(:user_frame) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) do
    "TXXX\x00\x00\x00\x19\x00\x00\x03ORIGINALDATE\x001990-02-12\x00" \
    "TXXX\x00\x00\x00\x13\x00\x00\x03ORIGINALYEAR\x001990\x00" \
    "TXXX\x00\x00\x00\x13\x00\x00\x03RELEASETYPE\x00Album\x00" \
  end

  describe "#data" do
    subject(:data) { user_frame.data }

    context "when description does not exist in lookup" do
      let(:expected_hash) do
        { originaldate: "1990-02-12" }
      end

      it "returns the expected hash with inferred key" do
        expect(data).to eq(originaldate: "1990-02-12")
      end
    end

    context "when description exists in lookup" do
      before do
        stub_const "#{described_class}::DESCRIPTIONS", descriptions
      end

      let(:descriptions) do
        { ORIGINALDATE: :original_date }
      end

      it "returns the expected hash with interpolated key" do
        expect(data).to eq(original_date: "1990-02-12")
      end
    end
  end
end
