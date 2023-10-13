RSpec.describe "Spring" do
  let(:path) { example("spring.mp3") }

  let(:expected_tags) do
    {
      TXXX: [
        { totaltracks: "13" },
        { totaldiscs: "1" },
        { comment: "Heavenly HVNLP1CD" },
        { replaygain_reference_loudness: "89.0 dB" },
        { replaygain_track_gain: "-4.61 dB" },
        { replaygain_track_peak: "1.00000000" },
        { replaygain_album_gain: "-5.56 dB" },
        { replaygain_album_peak: "1.00000000" }
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
