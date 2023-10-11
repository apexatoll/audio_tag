RSpec.describe "Spring" do
  let(:path) { example("spring.mp3") }

  let(:expected_tags) do
    {
      TXXX: [
        "TOTALTRACKS\x0013",
        "totaldiscs\x001",
        "comment\x00Heavenly HVNLP1CD",
        "REPLAYGAIN_REFERENCE_LOUDNESS\x0089.0 dB",
        "REPLAYGAIN_TRACK_GAIN\x00-4.61 dB",
        "REPLAYGAIN_TRACK_PEAK\x001.00000000",
        "REPLAYGAIN_ALBUM_GAIN\x00-5.56 dB",
        "REPLAYGAIN_ALBUM_PEAK\x001.00000000"
      ],
      TALB: "Foxbase Alpha",
      TPE2: "Saint Etienne",
      TDRC: "1991",
      TCON: "Pop",
      TIT2: "Spring",
      TRCK: "06",
      TPOS: "1",
      TPE1: "Saint Etienne",
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
