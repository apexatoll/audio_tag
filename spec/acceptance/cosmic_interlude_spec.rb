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
      # This mp3 file does not have \x00 delimiters at the end of the user
      # frames. Therefore the read_until!(0x00) call is extending past the end
      # of the current frame and into the next frame header's ID. This would be
      # fixed by ensuring that read*_until methods do not extend past the end
      # of a section.
      TXXX: [
        { releasetype: "album;compilationTXXX" },
        { replaygain_track_gain: "-7.60 dBTXXX" },
        { label: "Good Looking RecordsTXXX" },
        { replaygain_track_peak: "0.944061TXXX" },
        { script: "LatnTXXX" },
        { musicbrainz_releasetrackid:
          "619fd79e-ef7f-33bd-a2e7-b41cefb4e5b0TXXX" },
        { replaygain_album_peak: "0.977234TXXX" },
        { originalyear: "2000TXXX" },
        { musicbrainz_releasegroupid:
          "6f9a3567-4d62-3514-adfd-46eeaaaba180TXXX" },
        { asin: "B000007TUFTXXX" },
        { catalognumber: "GLRD001TXXX" },
        { ensemble: "LTJ BukemTXXX" },
        { barcode: "0675744650127TXXX" },
        { releasecountry: "GBTXXX" },
        { replaygain_album_gain: "-6.85 dBTXXX" },
        { musicbrainz_trackid: "51b24609-1d60-4c3f-9784-eb0cdadfcc5dTXXX" },
        { musicbrainz_albumid: "6f29b8de-e444-40f5-b5ac-fce6e0c64c54TXXX" },
        { totaltracks: "9TXXX" },
        { musicbrainz_artistid: "28c1b7b7-355a-48b1-b2c4-75b8eb8080efTXXX" },
        { artists: "LTJ BukemTXXX" },
        { media: "CDTXXX" },
        { originaldate: "2000TXXX" },
        { musicbrainz_albumartistid:
          "28c1b7b7-355a-48b1-b2c4-75b8eb8080efTXXX" },
        { totaldiscs: "1TXXX" },
        { releasestatus: "officialTXXX" },
        { tracktotal: "9TXXX" },
        { disctotal: "1" }
      ]
    }
  end

  include_examples :parses_tags
end
