RSpec.describe "Cosmic Interlude" do
  let(:path) { example("cosmic_interlude.mp3") }

  let(:expected_tags) do
    {
      picture: {
        encoding: :utf_8,
        mime: "image/png",
        type: :front_cover,
        description: ""
      },
      COMM: "eng\x00Good Looking Records",
      album: "Producer 01",
      genre: "Electronic",
      TDRC: "2000",
      title: "Cosmic Interlude",
      artist: "LTJ Bukem",
      part_in_set: "1",
      label: "Good Looking Records",
      track: "1",
      encoder: "Lavf60.3.100",
      user_frames: [
        { releasetype: "album;compilation" },
        { replaygain_track_gain: "-7.60 dB" },
        { label: "Good Looking Records" },
        { replaygain_track_peak: "0.944061" },
        { script: "Latn" },
        { musicbrainz_releasetrackid: "619fd79e-ef7f-33bd-a2e7-b41cefb4e5b0" },
        { replaygain_album_peak: "0.977234" },
        { originalyear: "2000" },
        { musicbrainz_releasegroupid: "6f9a3567-4d62-3514-adfd-46eeaaaba180" },
        { asin: "B000007TUF" },
        { catalognumber: "GLRD001" },
        { ensemble: "LTJ Bukem" },
        { barcode: "0675744650127" },
        { releasecountry: "GB" },
        { replaygain_album_gain: "-6.85 dB" },
        { musicbrainz_trackid: "51b24609-1d60-4c3f-9784-eb0cdadfcc5d" },
        { musicbrainz_albumid: "6f29b8de-e444-40f5-b5ac-fce6e0c64c54" },
        { totaltracks: "9" },
        { musicbrainz_artistid: "28c1b7b7-355a-48b1-b2c4-75b8eb8080ef" },
        { artists: "LTJ Bukem" },
        { media: "CD" },
        { originaldate: "2000" },
        { musicbrainz_albumartistid: "28c1b7b7-355a-48b1-b2c4-75b8eb8080ef" },
        { totaldiscs: "1" },
        { releasestatus: "official" },
        { tracktotal: "9" },
        { disctotal: "1" }
      ]
    }
  end

  include_examples :parses_tags
end
