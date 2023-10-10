RSpec.describe ID3::V2::FrameHeader do
  subject(:frame_header) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "TALB\x00\x00\x00\x15\x00\x00\x00Dark Side of the Moon\x00" }

  let(:name) { :foobar }

  let(:frame_class) do
    Class.new(ID3::V2::Frame)
  end

  let(:frame_type) do
    ID3::V2::FrameLookup::FrameType.new(name:, frame_class:)
  end

  before do
    allow(ID3::V2::FrameLookup)
      .to receive(:find)
      .with(:TALB)
      .and_return(frame_type)
  end

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

  describe "#key" do
    subject(:key) { frame_header.key }

    it "delegates to the frame type" do
      expect(key).to eq(frame_type.name)
    end
  end

  describe "#frame_class" do
    subject(:frame_class) { frame_header.frame_class }

    it "delegates to the frame type" do
      expect(frame_class).to eq(frame_type.frame_class)
    end
  end
end
