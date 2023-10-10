RSpec.describe ID3::StreamReader do
  subject(:stream_reader) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "Lorem ipsum dolor sit amet, consectetur adipiscing elit" }

  shared_context :stream_at do |**options|
    let(:position) { options[:position] }

    before { stream.seek(position) }
  end

  shared_examples :reads_section do |**options|
    it "reads the expected section" do
      expect(subject).to eq(options[:as])
    end

    it "does not advance the stream" do
      expect { subject }.not_to change { stream.pos }
    end
  end

  shared_examples :reads_section_and_advances_stream do |**options|
    it "reads the expected section" do
      expect(subject).to eq(options[:as])
    end

    it "advances the stream to the end of the read section" do
      expect { subject }.to change { stream.pos }.by(options[:as].length)
    end
  end

  describe "#read!" do
    subject(:section) { stream_reader.read!(length) }

    let(:length) { 10 }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      include_examples :reads_section_and_advances_stream, as: "Lorem ipsu"
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      include_examples :reads_section_and_advances_stream, as: "dolor sit "
    end
  end

  describe "#read" do
    subject(:section) { stream_reader.read(length) }

    let(:length) { 10 }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      include_examples :reads_section, as: "Lorem ipsu"
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      include_examples :reads_section, as: "dolor sit "
    end
  end

  describe "#read_bytes!" do
    subject(:bytes) { stream_reader.read_bytes!(length) }

    let(:length) { 10 }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      include_examples :reads_section_and_advances_stream,
                       as: "Lorem ipsu".bytes
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      include_examples :reads_section_and_advances_stream,
                       as: "dolor sit ".bytes
    end
  end

  describe "#read_bytes" do
    subject(:bytes) { stream_reader.read_bytes(length) }

    let(:length) { 10 }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      include_examples :reads_section, as: "Lorem ipsu".bytes
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      include_examples :reads_section, as: "dolor sit ".bytes
    end
  end

  describe "#read_byte!" do
    subject(:byte) { stream_reader.read_byte! }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      it "returns the first byte" do
        expect(byte).to eq("L".ord)
      end

      it "advances the stream" do
        expect { byte }.to change { stream.pos }.by(1)
      end
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      it "returns the first byte" do
        expect(byte).to eq("d".ord)
      end

      it "advances the stream" do
        expect { byte }.to change { stream.pos }.by(1)
      end
    end
  end

  describe "#read_byte" do
    subject(:byte) { stream_reader.read_byte }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      it "returns the first byte" do
        expect(byte).to eq("L".ord)
      end

      it "does not advance the stream" do
        expect { byte }.not_to change { stream.pos }
      end
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      it "returns the first byte" do
        expect(byte).to eq("d".ord)
      end

      it "does not advance the stream" do
        expect { byte }.not_to change { stream.pos }
      end
    end
  end

  describe "#read_until!" do
    subject(:section) { stream_reader.read_until!(byte, consume_delimiter:) }

    let(:consume_delimiter) { true }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns the entire string" do
          expect(section).to eq(string)
        end

        it "advances the stream to the end" do
          expect { section }.to change { stream.eof? }.to(true)
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        let(:expected) { "Lorem" }

        context "and consume_delimiter flag is false" do
          let(:consume_delimiter) { false }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section without given byte" do
            expect { section }.to change { stream.pos }.by(expected.length)
          end
        end

        context "and consume_delimiter flag is true" do
          let(:consume_delimiter) { true }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section plus given byte" do
            expect { section }.to change { stream.pos }.by(expected.length + 1)
          end
        end
      end
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns the rest of the string" do
          expect(section).to eq(string[position...])
        end

        it "advances the stream to the end" do
          expect { section }.to change { stream.eof? }.to(true)
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        let(:expected) { "dolor" }

        context "and consume_delimiter flag is false" do
          let(:consume_delimiter) { false }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section without given byte" do
            expect { section }.to change { stream.pos }.by(expected.length)
          end
        end

        context "and consume_delimiter flag is true" do
          let(:consume_delimiter) { true }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section plus given byte" do
            expect { section }.to change { stream.pos }.by(expected.length + 1)
          end
        end
      end
    end
  end

  describe "#read_until" do
    subject(:section) { stream_reader.read_until(byte) }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns the entire string" do
          expect(section).to eq(string)
        end

        it "does not advance the stream" do
          expect { section }.not_to change { stream.pos }
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        include_examples :reads_section, as: "Lorem"
      end
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns the remaining string" do
          expect(section).to eq(string[position...])
        end

        it "does not advance the stream" do
          expect { section }.not_to change { stream.pos }
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        include_examples :reads_section, as: "dolor"
      end
    end
  end

  describe "#read_bytes_until!" do
    subject(:section) do
      stream_reader.read_bytes_until!(byte, consume_delimiter:)
    end

    let(:consume_delimiter) { true }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns all the bytes" do
          expect(section).to eq(string.bytes)
        end

        it "advances the stream to the end" do
          expect { section }.to change { stream.eof? }.to(true)
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        let(:expected) { "Lorem".bytes }

        context "and consume_delimiter flag is false" do
          let(:consume_delimiter) { false }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section without given byte" do
            expect { section }.to change { stream.pos }.by(expected.length)
          end
        end

        context "and consume_delimiter flag is true" do
          let(:consume_delimiter) { true }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section plus given byte" do
            expect { section }.to change { stream.pos }.by(expected.length + 1)
          end
        end
      end
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns the remaining bytes" do
          expect(section).to eq(string[position...].bytes)
        end

        it "advances the stream to the end" do
          expect { section }.to change { stream.eof? }.to(true)
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        let(:expected) { "dolor".bytes }

        context "and consume_delimiter flag is false" do
          let(:consume_delimiter) { false }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section without given byte" do
            expect { section }.to change { stream.pos }.by(expected.length)
          end
        end

        context "and consume_delimiter flag is true" do
          let(:consume_delimiter) { true }

          it "reads upto the given byte" do
            expect(section).to eq(expected)
          end

          it "advances the stream to end of read section plus given byte" do
            expect { section }.to change { stream.pos }.by(expected.length + 1)
          end
        end
      end
    end
  end

  describe "#read_bytes_until" do
    subject(:section) { stream_reader.read_bytes_until(byte) }

    context "when stream is at beginning" do
      include_context :stream_at, position: 0

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns all the bytes" do
          expect(section).to eq(string.bytes)
        end

        it "does not advance the stream" do
          expect { section }.not_to change { stream.pos }
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        include_examples :reads_section, as: "Lorem".bytes
      end
    end

    context "when stream is not at beginning" do
      include_context :stream_at, position: 12

      context "and string does not contain given byte" do
        let(:byte) { 0x00 }

        it "returns the remaining bytes" do
          expect(section).to eq(string[position...].bytes)
        end

        it "does not advance the stream" do
          expect { section }.not_to change { stream.pos }
        end
      end

      context "and string contains given byte" do
        let(:byte) { " ".ord }

        let(:expected) { "dolor".bytes }

        include_examples :reads_section, as: "dolor".bytes
      end
    end
  end
end
