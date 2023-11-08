RSpec.describe AudioTag::ID3::V2::TextDecoder do
  shared_context :not_encoded do
    let(:string) { "Hello world" }
  end

  shared_context :unterminated_ascii do
    let(:string) { "\x00Hello world" }
  end

  shared_context :terminated_ascii do
    let(:string) { "\x00Hello world\x00" }
  end

  shared_context :unterminated_utf_16 do
    let(:string) { "\x01Hello world" }
  end

  shared_context :terminated_utf_16 do
    let(:string) { "\x01Hello world\x00\x00" }
  end

  shared_context :unterminated_utf_16be do
    let(:string) { "\x02Hello world" }
  end

  shared_context :terminated_utf_16be do
    let(:string) { "\x02Hello world\x00\x00" }
  end

  shared_context :unterminated_utf_8 do
    let(:string) { "\x03Hello world" }
  end

  shared_context :terminated_utf_8 do
    let(:string) { "\x03Hello world\x00" }
  end

  describe ".encoding" do
    subject(:encoding) { described_class.encoding(string) }

    shared_examples :returns_encoding do |options|
      it "returns the expected encoding" do
        expect(encoding).to eq(options[:as])
      end
    end

    context "when string is not encoded" do
      include_context :not_encoded

      include_examples :returns_encoding, as: nil
    end

    context "when string is unterminated ascii" do
      include_context :unterminated_ascii

      include_examples :returns_encoding, as: :ascii
    end

    context "when string is terminated ascii" do
      include_context :terminated_ascii

      include_examples :returns_encoding, as: :ascii
    end

    context "when string is unterminated UTF-16" do
      include_context :unterminated_utf_16

      include_examples :returns_encoding, as: :utf_16
    end

    context "when string is terminated UTF-16" do
      include_context :terminated_utf_16

      include_examples :returns_encoding, as: :utf_16
    end

    context "when string is unterminated UTF-16BE" do
      include_context :unterminated_utf_16be

      include_examples :returns_encoding, as: :utf_16be
    end

    context "when string is terminated UTF-16BE" do
      include_context :terminated_utf_16be

      include_examples :returns_encoding, as: :utf_16be
    end

    context "when string is unterminated UTF-8" do
      include_context :unterminated_utf_8

      include_examples :returns_encoding, as: :utf_8
    end

    context "when string is terminated UTF-8" do
      include_context :terminated_utf_8

      include_examples :returns_encoding, as: :utf_8
    end
  end

  describe ".decode" do
    subject(:decoded) { described_class.decode(string) }

    shared_examples :returns_decoded_string do
      it "returns the expected decoded string" do
        expect(decoded).to eq("Hello world")
      end
    end

    context "when string is not encoded" do
      include_context :not_encoded

      include_examples :returns_decoded_string
    end

    context "when string is unterminated ascii" do
      include_context :unterminated_ascii

      include_examples :returns_decoded_string
    end

    context "when string is terminated ascii" do
      include_context :terminated_ascii

      include_examples :returns_decoded_string
    end

    context "when string is unterminated UTF-16" do
      include_context :unterminated_utf_16

      include_examples :returns_decoded_string
    end

    context "when string is terminated UTF-16" do
      include_context :terminated_utf_16

      include_examples :returns_decoded_string
    end

    context "when string is unterminated UTF-16BE" do
      include_context :unterminated_utf_16be

      include_examples :returns_decoded_string
    end

    context "when string is terminated UTF-16BE" do
      include_context :terminated_utf_16be

      include_examples :returns_decoded_string
    end

    context "when string is unterminated UTF-8" do
      include_context :unterminated_utf_8

      include_examples :returns_decoded_string
    end

    context "when string is terminated UTF-8" do
      include_context :terminated_utf_8

      include_examples :returns_decoded_string
    end
  end
end
