RSpec.describe ID3::V2::FrameHeader do
  subject(:frame_header) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "TALB\x00\x00\x00\x15\x00\x00\x00Dark Side of the Moon\x00" }

  describe "#id" do
    subject(:id) { frame_header.id }

    it "returns the expected value" do
      expect(id).to eq(:TALB)
    end
  end

  describe "#frame_size" do
    subject(:frame_size) { frame_header.frame_size }

    it "returns the expected value" do
      expect(frame_size).to eq("Dark Side of the Moon".bytesize)
    end
  end
end
