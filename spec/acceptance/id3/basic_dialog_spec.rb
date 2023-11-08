RSpec.describe "Basic Dialog" do
  let(:path) { example("basic_dialog.mp3") }

  let(:expected_tags) do
    {
      album: "Basic Data Manipulation (Tastes and Textures, Vol. 2)",
      artist: "Beaumont Hannant",
      user_frames: {
        comment: "Track 1",
        tracktotal: "9"
      },
      year: "1993",
      genre: "Ambient",
      title: "Basic Dialog",
      track: "1",
      encoder: "Lavf60.3.100"
    }
  end

  include_examples :parses_id3_tags
end
