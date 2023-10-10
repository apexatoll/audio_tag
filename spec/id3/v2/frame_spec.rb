RSpec.describe ID3::V2::Frame do
  subject(:frame) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) do
    "TPE1\u0000\u0000\u0000\u0012\u0000\u0000\u0000Beaumont Hannant\u0000" \
    "TYER\u0000\u0000\u0000\u0006\u0000\u0000\u00001993\u0000" \
    "TCON\u0000\u0000\u0000\t\u0000\u0000\u0000Ambient\u0000"
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

  describe ".build" do
    subject(:frame) { described_class.build(stream) }

    let(:year_frame_type) do
      ID3::V2::FrameLookup::FrameType.new(:year)
    end

    let(:genre_frame_type) do
      ID3::V2::FrameLookup::FrameType.new(:genre, genre_class)
    end

    let(:genre_class) { Class.new(described_class) }

    let(:lookup) do
      { TYER: year_frame_type, TCON: genre_frame_type }
    end

    before do
      stub_const "ID3::V2::FrameLookup::FRAME_TYPES", lookup
    end

    context "when frame type is not set in lookup" do
      before { stream.seek(0) }

      it "returns a generic frame" do
        expect(frame).to be_a(described_class)
      end
    end

    context "when frame type is not set in frame type" do
      before { stream.seek(28) }

      it "returns a generic frame" do
        expect(frame).to be_a(described_class)
      end
    end

    context "when frame type is set in frame type" do
      before { stream.seek(44) }

      it "returns an instance of the specified frame" do
        expect(frame).to be_a(genre_class)
      end
    end
  end
end
