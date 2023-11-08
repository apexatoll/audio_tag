RSpec.describe AudioTag::ID3::Header do
  subject(:header) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "Lorem ipsum dolor est " }

  let(:size) { 10 }

  before do
    stub_const "#{described_class}::DEFAULT_HEADER_SIZE", size
  end

  describe "#initialize" do
    let(:expected_bytes) { string.bytes.first(size) }

    it "extracts the first size bytes" do
      expect(header.bytes).to eq(expected_bytes)
    end

    it "advances the stream to the end of the section" do
      expect { header }.to change { stream.pos }.by(size)
    end
  end

  describe "#bytes_for" do
    let(:bytes) { header.bytes_for(key) }

    let(:key) { :foo }

    context "when structure constant is not set" do
      it "raises an error" do
        expect { bytes }.to raise_error("structure constant not set")
      end
    end

    context "when structure constant is set" do
      before { stub_const "#{described_class}::STRUCTURE", structure }

      context "and structure does not contain given key" do
        let(:structure) { %i[hello world] }

        it "raises an error" do
          expect { bytes }.to raise_error("invalid key :foo")
        end
      end

      context "and structure contains given key" do
        context "and bytes start at beginning of the stream" do
          let(:structure) do
            %i[foo foo foo bar bar baz baz baz baz]
          end

          it "returns the expected filtered bytes" do
            expect(bytes).to eq("Lor".bytes)
          end
        end

        context "and bytes are in the middle of the stream" do
          let(:structure) do
            %i[bar bar bar foo foo foo baz baz baz]
          end

          it "returns the expected filtered bytes" do
            expect(bytes).to eq("em ".bytes)
          end
        end

        context "and bytes are at the end of the stream" do
          let(:structure) do
            %i[bar bar bar baz baz baz foo foo foo foo]
          end

          it "returns the expected filtered bytes" do
            expect(bytes).to eq("ipsu".bytes)
          end
        end
      end
    end
  end
end
