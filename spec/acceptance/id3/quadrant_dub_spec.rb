RSpec.describe "Quadrant Dub" do
  let(:path) { example("quadrant_dub.mp3") }

  let(:expected_tags) do
    {
      album: "BCD",
      album_artist: "Basic Channel",
      artist: "Basic Channel",
      date: "1995",
      genre: "Electronic",
      title: "Quadrant Dub I (Edit)",
      user_frames: { tracktotal: "11" },
      track: "04",
      encoder: "Lavf60.3.100",
      picture: {
        encoding: :utf_8,
        mime: "image/png",
        type: :front_cover,
        description: ""
      }
    }
  end

  include_examples :parses_id3_tags
end
