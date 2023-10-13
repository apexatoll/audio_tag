RSpec.describe ID3::V2::FrameLookup do
  let(:lookup) do
    {
      FOO: described_class::FrameType.new(:foo),
      BAR: described_class::FrameType.new(:bar, frame_class)
    }
  end

  let(:frame_class)         { Class.new(ID3::V2::Frame) }
  let(:default_frame_class) { Class.new(ID3::V2::Frame) }

  before do
    stub_const "#{described_class}::DEFAULT_FRAME_CLASS", default_frame_class
    stub_const "#{described_class}::FRAME_TYPES", lookup
  end

  describe ".find" do
    subject(:frame_type) { described_class.find(key) }

    context "when frame type with given key does not exist" do
      let(:key) { :BAZ }

      it "returns a FrameType" do
        expect(frame_type).to be_a(described_class::FrameType)
      end

      it "has the expected attributes" do
        expect(frame_type).to have_attributes(
          name: key,
          frame_class: default_frame_class
        )
      end
    end

    context "when frame type with given key exists" do
      context "and frame type does not set a frame class" do
        let(:key) { :FOO }

        it "returns a FrameType" do
          expect(frame_type).to be_a(described_class::FrameType)
        end

        it "has the expected attributes" do
          expect(frame_type).to have_attributes(
            name: :foo,
            frame_class: default_frame_class
          )
        end
      end

      context "and frame type sets a frame class" do
        let(:key) { :BAR }

        it "returns a FrameType" do
          expect(frame_type).to be_a(described_class::FrameType)
        end

        it "has the expected attributes" do
          expect(frame_type).to have_attributes(
            name: :bar, frame_class:
          )
        end
      end
    end
  end
end
