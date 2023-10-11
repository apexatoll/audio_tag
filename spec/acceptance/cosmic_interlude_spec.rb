RSpec.describe "Cosmic Interlude" do
  let(:path) { example("cosmic_interlude.mp3") }

  let(:expected_tags) do
    {
      APIC: {
        encoding: :utf_8,
        mime: "image/png",
        type: :front_cover,
        description: ""
      },
      COMM: "eng\x00Good Looking Records",
      TALB: "Producer 01",
      TCON: "Electronic",
      TDRC: "2000",
      TIT2: "Cosmic Interlude",
      TPE1: "LTJ Bukem",
      TPOS: "1",
      TPUB: "Good Looking Records",
      TRCK: "1",
      TSSE: "Lavf60.3.100",
      TXXX: [
        "RELEASETYPE\x00album;compilation",
        "REPLAYGAIN_TRACK_GAIN\x00-7.60 dB",
        "LABEL\x00Good Looking Records",
        "REPLAYGAIN_TRACK_PEAK\x000.944061",
        "SCRIPT\x00Latn",
        "MUSICBRAINZ_RELEASETRACKID\x00619fd79e-ef7f-33bd-a2e7-b41cefb4e5b0",
        "REPLAYGAIN_ALBUM_PEAK\x000.977234",
        "ORIGINALYEAR\x002000",
        "MUSICBRAINZ_RELEASEGROUPID\x006f9a3567-4d62-3514-adfd-46eeaaaba180",
        "ASIN\x00B000007TUF",
        "CATALOGNUMBER\x00GLRD001",
        "ENSEMBLE\x00LTJ Bukem",
        "BARCODE\x000675744650127",
        "RELEASECOUNTRY\x00GB",
        "REPLAYGAIN_ALBUM_GAIN\x00-6.85 dB",
        "MUSICBRAINZ_TRACKID\x0051b24609-1d60-4c3f-9784-eb0cdadfcc5d",
        "MUSICBRAINZ_ALBUMID\x006f29b8de-e444-40f5-b5ac-fce6e0c64c54",
        "TOTALTRACKS\x009",
        "MUSICBRAINZ_ARTISTID\x0028c1b7b7-355a-48b1-b2c4-75b8eb8080ef",
        "ARTISTS\x00LTJ Bukem",
        "MEDIA\x00CD",
        "ORIGINALDATE\x002000",
        "MUSICBRAINZ_ALBUMARTISTID\x0028c1b7b7-355a-48b1-b2c4-75b8eb8080ef",
        "TOTALDISCS\x001",
        "RELEASESTATUS\x00official",
        "TRACKTOTAL\x009",
        "DISCTOTAL\x001"
      ]
    }
  end

  include_examples :parses_tags
end
