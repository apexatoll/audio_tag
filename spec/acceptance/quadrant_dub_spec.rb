RSpec.describe "Quadrant Dub" do
  let(:path) { example("quadrant_dub.mp3") }

  let(:expected_tags) do
    {
      TALB: "BCD",
      TPE2: "Basic Channel",
      TPE1: "Basic Channel",
      TDRC: "1995",
      TCON: "Electronic",
      TIT2: "Quadrant Dub I (Edit)",
      TXXX: "TRACKTOTAL\x0011",
      TRCK: "04",
      TSSE: "Lavf60.3.100",
      APIC: {
        encoding: :utf_8,
        mime: "image/png",
        type: :front_cover,
        description: ""
      }
    }
  end

  include_examples :parses_tags
end