RSpec.describe ID3::V2::Tag do
  subject(:tag) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) do
    "ID3\x04\x00\x00\x00\x00\x00W" \
    "TALB\x00\x00\x00\v\x00\x00\x03Some Album" \
    "TIT2\x00\x00\x00\v\x00\x00\x03Some Track" \
    "TPE1\x00\x00\x00\f\x00\x00\x03Some Artist" \
    "TDRL\x00\x00\x00\x05\x00\x00\x001996" \
    "\x00\x00\x00\x00\x00\x00\x00\x00"
  end

  before do
    stub_const "ID3::V2::FrameType::LOOKUP", {}
  end

  describe "#header" do
    subject(:header) { tag.header }

    let(:expected_attributes) do
      {
        tag_size: 87,
        unsynchronised?: false,
        extended?: false,
        experimental?: false
      }
    end

    before { tag }

    it "returns a tag header" do
      expect(header).to be_an(ID3::V2::TagHeader)
    end

    it "sets the expected attributes" do
      expect(header).to have_attributes(**expected_attributes)
    end

    it "does not advance the stream further" do
      expect { header }.not_to change { stream.pos }.from(97)
    end
  end

  describe "#frames" do
    subject(:frames) { tag.frames }

    before { tag }

    it "returns an array of frames" do
      expect(frames).to all be_an(ID3::V2::Frame)
    end

    it "contains the expected number of frames" do
      expect(frames.count).to eq(4)
    end

    it "does not advance the stream further" do
      expect { frames }.not_to change { stream.pos }.from(97)
    end

    describe "first frame" do
      subject(:frame) { frames[0] }

      it "has the expected attributes" do
        expect(frame.to_h).to eq(TALB: "Some Album")
      end
    end

    describe "second frame" do
      subject(:frame) { frames[1] }

      it "has the expected attributes" do
        expect(frame.to_h).to eq(TIT2: "Some Track")
      end
    end

    describe "third frame" do
      subject(:frame) { frames[2] }

      it "has the expected attributes" do
        expect(frame.to_h).to eq(TPE1: "Some Artist")
      end
    end

    describe "fourth frame" do
      subject(:frame) { frames[3] }

      it "has the expected attributes" do
        expect(frame.to_h).to eq(TDRL: "1996")
      end
    end
  end

  describe "#to_h" do
    subject(:hash) { tag.to_h }

    before do
      allow(ID3::V2::FrameMerger).to receive(:new).and_return(frame_merger)
    end

    let(:frame_merger) { instance_spy(ID3::V2::FrameMerger, merge: merged) }

    let(:merged) { { foo: "foo", bar: "bar" } }

    it "instantiates a frame merger" do
      hash
      expect(ID3::V2::FrameMerger).to have_received(:new).with(tag.frames)
    end

    it "merges the frames" do
      hash
      expect(frame_merger).to have_received(:merge)
    end

    it "returns the merged frames" do
      expect(hash).to eq(merged)
    end
  end
end
