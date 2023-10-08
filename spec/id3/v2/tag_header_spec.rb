RSpec.describe ID3::V2::TagHeader do
  subject(:tag_header) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "ID3\x03\x00\x00\x00\x00\x01z" }

  describe "#initialize" do
    context "when identifier is invalid" do
      let(:string) { "ID4\x03\x00\x00\x00\x00\x01z" }

      it "raises an error" do
        expect { tag_header }.to raise_error("invalid ID3 tag identifier: ID4")
      end
    end

    context "when identifier is valid" do
      it "does not raise any errors" do
        expect { tag_header }.not_to raise_error
      end
    end

    describe "flags validation" do
      let(:string) { "ID3\x03\x00#{flags}\x00\x00\x01z" }

      shared_examples :invalid_flags do
        it "raises an error" do
          expect { tag_header }.to raise_error("invalid flags set")
        end
      end

      shared_examples :valid_flags do
        it "does not raise any errors" do
          expect { tag_header }.not_to raise_error
        end
      end

      context "when 1st bit is set" do
        let(:flags) { "\x01" }

        include_examples :invalid_flags
      end

      context "when 2nd bit is set" do
        let(:flags) { "\x02" }

        include_examples :invalid_flags
      end

      context "when 3rd bit is set" do
        let(:flags) { "\x04" }

        include_examples :invalid_flags
      end

      context "when 4th bit is set" do
        let(:flags) { "\x08" }

        include_examples :invalid_flags
      end

      context "when 5th bit is set" do
        let(:flags) { "\x10" }

        include_examples :valid_flags
      end

      context "when 6th bit is set" do
        let(:flags) { "\x20" }

        include_examples :valid_flags
      end

      context "when 7th bit is set" do
        let(:flags) { "\x40" }

        include_examples :valid_flags
      end

      context "when 8th bit is set" do
        let(:flags) { "\x80" }

        include_examples :invalid_flags
      end
    end
  end
end
