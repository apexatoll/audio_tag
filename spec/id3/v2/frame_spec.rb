RSpec.describe ID3::V2::Frame do
  subject(:frame) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) do
    "TPE1\x00\x00\x00\x12\x00\x00\x00Beaumont Hannant\x00\x00\x00\x00\x00"
  end

  describe "#header" do
    subject(:header) { frame.header }

    before { frame }

    let(:expected_attributes) do
      { id: :TPE1, frame_size: 18 }
    end

    it "returns a frame header" do
      expect(header).to be_an(ID3::V2::FrameHeader)
    end

    it "sets the expected attributes" do
      expect(header).to have_attributes(**expected_attributes)
    end

    it "does not advance the stream" do
      expect { header }.not_to change { stream.pos }
    end
  end

  describe "#key" do
    subject(:key) { frame.key }

    it "returns the expected value" do
      expect(key).to eq(:TPE1)
    end

    it "advances the stream to the end of the frame" do
      expect { key }.to change { stream.pos }.by(28)
    end

    it "only advances the stream once" do
      key
      expect { key }.not_to change { stream.pos }
    end
  end

  describe "#value" do
    subject(:value) { frame.raw_value }

    it "returns the expected value" do
      expect(value).to eq("\x00Beaumont Hannant\x00")
    end

    it "advances the stream to the end of the frame" do
      expect { value }.to change { stream.pos }.by(28)
    end

    it "only advances the stream once" do
      value
      expect { value }.not_to change { stream.pos }
    end
  end

  describe "#to_h" do
    subject(:hash) { frame.to_h }

    it "returns the expected hash" do
      expect(hash).to eq(TPE1: "\x00Beaumont Hannant\x00")
    end
  end
end
