RSpec.describe "Spring" do
  let(:path) { example("spring.mp3") }

  let(:expected_tags) do
    {
      user_frames: {
        totaltracks: "13",
        totaldiscs: "1",
        comment: "Heavenly HVNLP1CD",
        replaygain_reference_loudness: "89.0 dB",
        replaygain_track_gain: "-4.61 dB",
        replaygain_track_peak: "1.00000000",
        replaygain_album_gain: "-5.56 dB",
        replaygain_album_peak: "1.00000000"
      },
      album: "Foxbase Alpha",
      album_artist: "Saint Etienne",
      date: "1991",
      genre: "Pop",
      title: "Spring",
      track: "06",
      part_in_set: "1",
      artist: "Saint Etienne",
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
