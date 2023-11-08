RSpec.describe AudioTag::ID3::StreamSection do
  subject(:stream_section) { stream_section_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  let(:string) { "Lorem Ipsum Dolor Est" }

  let(:stream_section_class) do
    Class.new(described_class) do
      include SizeMethod
      include ExtractMethod
    end
  end

  let(:size_method) do
    Module.new { def size = 10 }
  end

  let(:extract_method) do
    Module.new do
      attr_reader :bytes

      def extract! = read_bytes!(size)
    end
  end

  before do
    stub_const "SizeMethod", size_method
    stub_const "ExtractMethod", extract_method
  end

  describe "#initialize" do
    context "when stream section class does not define size method" do
      let(:size_method) { Module.new }

      it "raises an error" do
        expect { stream_section }.to raise_error(
          NotImplementedError, "size is not defined"
        )
      end
    end

    context "when stream section class does not define extract method" do
      let(:extract_method) { Module.new }

      it "raises an error" do
        expect { stream_section }.to raise_error(
          NotImplementedError, "extraction method is not defined"
        )
      end
    end

    context "when extract and size are both defined" do
      context "and extract method does not read entire section" do
        let(:extract_method) do
          Module.new { def extract! = read_byte! }
        end

        it "does not raise any errors" do
          expect { stream_section }.not_to raise_error
        end

        it "advances the stream to the end of the section" do
          expect { stream_section }.to change { stream.pos }.by(10)
        end
      end

      context "and extract method reads entire section" do
        let(:extract_method) do
          Module.new { def extract! = read!(size) }
        end

        it "does not raise any errors" do
          expect { stream_section }.not_to raise_error
        end

        it "advances the stream to the end of the section" do
          expect { stream_section }.to change { stream.pos }.by(10)
        end
      end
    end
  end

  describe "#extract!" do
    context "when extract method uses read*_until method" do
      context "and stream does not contain given byte" do
        let(:extract_method) do
          Module.new do
            attr_reader :value

            def extract!
              @value = read_until!(0x00)
            end
          end
        end

        it "reads the entire section" do
          expect(stream_section.value).to eq(string[0...10])
        end
      end

      context "and stream contains given byte outside section" do
        let(:extract_method) do
          Module.new do
            attr_reader :value

            def extract!
              @value = read_until!("D".ord)
            end
          end
        end

        it "does not read past section boundary" do
          expect(stream_section.value).to eq(string[0...10])
        end
      end

      context "and stream contains given byte inside section" do
        let(:extract_method) do
          Module.new do
            attr_reader :value

            def extract!
              @value = read_until!("m".ord)
            end
          end
        end

        it "reads up until the first occurrence inside the section" do
          expect(stream_section.value).to eq("Lore")
        end
      end
    end
  end
end
