RSpec.describe ID3::V2::FrameMerger do
  subject(:frame_merger) { described_class.new(frames) }

  let(:frames) do
    frame_hashes.map { |hash| instance_spy(ID3::V2::Frame, to_h: hash) }
  end

  describe "#merge" do
    subject(:merged) { frame_merger.merge }

    context "when there are no duplicate keys" do
      let(:frame_hashes) do
        [{ foo: "foo" }, { bar: "bar" }, { baz: "baz" }]
      end

      it "returns the expected merged hash" do
        expect(merged).to eq(foo: "foo", bar: "bar", baz: "baz")
      end
    end

    context "when there are duplicate keys" do
      context "and values are all strings" do
        let(:frame_hashes) do
          [
            { foo: "foo" },
            { foo: "bar" },
            { baz: "baz" }
          ]
        end

        let(:expected) do
          {
            foo: %w[foo bar],
            baz: "baz"
          }
        end

        it "merges the duplicate values into an array" do
          expect(merged).to eq(expected)
        end
      end

      context "and hash values are all hashes" do
        let(:frame_hashes) do
          [
            { foo: { foo: "foo" } },
            { foo: { bar: "bar" } },
            { baz: { baz: "baz" } }
          ]
        end

        let(:expected) do
          {
            foo: [{ foo: "foo" }, { bar: "bar" }],
            baz: { baz: "baz" }
          }
        end

        it "merges the duplicate hashes into an array" do
          expect(merged).to eq(expected)
        end
      end
    end
  end
end
