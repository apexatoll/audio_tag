RSpec.describe AudioTag::ID3::Synchsafe do
  describe ".parse" do
    subject(:integer) { described_class.parse(*bytes) }

    shared_examples :invalid_byte do
      it "raises an invalid bytes error" do
        expect { integer }.to raise_error(
          described_class::InvalidBytesError, "MSB of byte must be 0"
        )
      end
    end

    def self.to_binary(*bytes)
      bytes.map { |byte| byte.to_s(2).rjust(8, "0") }.join(" ")
    end

    context "when one integer byte is passed" do
      let(:bytes) { [byte] }

      shared_examples :returns_same_byte do
        it "does not raise any errors" do
          expect { integer }.not_to raise_error
        end

        it "returns the byte unchanged" do
          expect(integer).to eq(byte)
        end
      end

      context "and integer is less than 128" do
        [0, 1, 2, 4, 8, 16, 32, 64, 127].each do |byte|
          describe to_binary(*byte) do
            let(:byte) { byte }

            include_examples :returns_same_byte
          end
        end
      end

      context "and integer is equal to 128" do
        [128].each do |byte|
          context to_binary(*byte) do
            let(:byte) { byte }

            include_examples :invalid_byte
          end
        end
      end

      context "and integer is greater than 128" do
        [129, 255].each do |byte|
          describe to_binary(*byte) do
            let(:byte) { byte }

            include_examples :invalid_byte
          end
        end
      end
    end

    context "when two integer bytes are passed" do
      let(:bytes) { [byte1, byte2] }

      context "and first integer is 01111111" do
        let(:byte1) { 127 }

        context "and second integer is 01111111" do
          let(:byte2) { 127 }

          it "removes the zeroed MSB from each byte and joins" do
            expect(integer).to eq_binary("00111111 11111111")
          end
        end
      end

      matcher :eq_binary do |binary|
        match do |actual|
          integer = binary.delete(" ").to_i(2)

          expect(actual).to eq(integer)
        end
      end
    end
  end
end
