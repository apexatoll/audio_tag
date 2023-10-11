RSpec.describe "Basic Dialog" do
  let(:path) { example("basic_dialog.mp3") }

  let(:expected_tags) do
    {
      TALB: "Basic Data Manipulation (Tastes and Textures, Vol. 2)",
      TPE1: "Beaumont Hannant",
      TXXX: [
        "COMMENT\x00Track 1",
        "TRACKTOTAL\x009"
      ],
      TYER: "1993",
      TCON: "Ambient",
      TIT2: "Basic Dialog",
      TRCK: "1",
      TSSE: "Lavf60.3.100"
    }
  end

  include_examples :parses_tags
end
