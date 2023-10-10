RSpec.describe ID3::V2::Frames::PictureFrame do
  subject(:picture_frame) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "APIC\x008jr\x00\x00\x03image/png\x00\x03\x00\x89PNG" }

  describe "#value" do
    subject(:value) { picture_frame.value }

    let(:expected_hash) do
      {
        encoding: :utf_8,
        mime: "image/png",
        type: :front_cover,
        description: ""
      }
    end

    it "returns the expected hash" do
      expect(value).to eq(expected_hash)
    end
  end
end
