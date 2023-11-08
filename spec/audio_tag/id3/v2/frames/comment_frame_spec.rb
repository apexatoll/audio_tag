RSpec.describe AudioTag::ID3::V2::Frames::CommentFrame do
  subject(:comment_frame) { described_class.new(stream) }

  let(:stream) { StringIO.new(string) }

  describe "#data" do
    let(:data) { comment_frame.data }

    context "when comment does not have a description" do
      let(:string) do
        "COMM\x00\x00\x00\x25\x00\x00\x03eng\x00Good Looking Records"
      end

      let(:expected_hash) do
        { eng: { _: "Good Looking Records" } }
      end

      it "returns the expected value under the language anon key" do
        expect(data).to eq(expected_hash)
      end
    end

    context "when comment has a description" do
      let(:string) do
        "COMM\x00\x00\x00\x30\x00\x00\x03englabel\x00Good Looking Records"
      end

      let(:expected_hash) do
        { eng: { label: "Good Looking Records" } }
      end

      it "returns the expected value under the language specified key" do
        expect(data).to eq(expected_hash)
      end
    end
  end
end
