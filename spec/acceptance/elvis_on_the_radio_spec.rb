RSpec.describe "Elvis on the Radio" do
  let(:path) { example("elvis_on_the_radio.mp3") }

  let(:expected_tags) do
    {
      TXXX: [
        "MUSICBRAINZ_RELEASEGROUPID\x00A415fc9b-1516-303e-B354-Fc3a5b269f1b",
        "ORIGINALDATE\x001990-02-12",
        "ORIGINALYEAR\x001990",
        "RELEASETYPE\x00Album",
        "MUSICBRAINZ_ALBUMID\x00953e31cd-Dc03-3a05-A11e-160405c4c78f",
        "RELEASESTATUS\x00Official",
        "LABEL\x00Tvt Records",
        "CATALOGNUMBER\x00Tvt 7155-2",
        "COMPOSERSORT\x00Cauty, Jimmy;Drummond, Bill",
        "ASIN\x00B000003rfd",
        "RELEASECOUNTRY\x00Us",
        "SCRIPT\x00Latn",
        "MUSICBRAINZ_ALBUMARTISTID\x008092b8b7-235e-4844-9f72-95a9d5a73dbf",
        "ALBUMARTISTSORT\x00Klf, The",
        "BARCODE\x00016581715523",
        "TOTALDISCS\x001",
        "MEDIA\x00Cd",
        "TOTALTRACKS\x0014",
        "MUSICBRAINZ_TRACKID\x00F246f658-49c4-4efe-840e-C624b7850bc9",
        "MUSICBRAINZ_ARTISTID\x008092b8b7-235e-4844-9f72-95a9d5a73dbf",
        "ARTISTSORT\x00Klf, The",
        "ARTISTS\x00The Klf",
        "MUSICBRAINZ_RELEASETRACKID\x00F2b37e32-3d03-3e94-Bdcd-6f7af339b357",
        "TRACKTOTAL\x0014",
        "DISCTOTAL\x001"
      ],
      TPE3: "Graham Lee (Guest Pedal Steel Guitar)",
      TIT2: "Elvis On The Radio, Steel Guitar In My Soul",
      TPE1: "The KLF",
      TALB: "Chill Out",
      TCON: "Ambient",
      TPE2: "The KLF",
      TCOM: "Jimmy Cauty;Bill Drummond",
      TPOS: "1",
      TDRC: "1994",
      TRCK: "7",
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