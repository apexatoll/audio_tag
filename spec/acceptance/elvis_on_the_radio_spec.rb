RSpec.describe "Elvis on the Radio" do
  let(:path) { example("elvis_on_the_radio.mp3") }

  let(:expected_tags) do
    {
      TXXX: [
        { musicbrainz_releasegroupid: "A415fc9b-1516-303e-B354-Fc3a5b269f1b" },
        { originaldate: "1990-02-12" },
        { originalyear: "1990" },
        { releasetype: "Album" },
        { musicbrainz_albumid: "953e31cd-Dc03-3a05-A11e-160405c4c78f" },
        { releasestatus: "Official" },
        { label: "Tvt Records" },
        { catalognumber: "Tvt 7155-2" },
        { composersort: "Cauty, Jimmy;Drummond, Bill" },
        { asin: "B000003rfd" },
        { releasecountry: "Us" },
        { script: "Latn" },
        { musicbrainz_albumartistid: "8092b8b7-235e-4844-9f72-95a9d5a73dbf" },
        { albumartistsort: "Klf, The" },
        { barcode: "016581715523" },
        { totaldiscs: "1" },
        { media: "Cd" },
        { totaltracks: "14" },
        { musicbrainz_trackid: "F246f658-49c4-4efe-840e-C624b7850bc9" },
        { musicbrainz_artistid: "8092b8b7-235e-4844-9f72-95a9d5a73dbf" },
        { artistsort: "Klf, The" },
        { artists: "The Klf" },
        { musicbrainz_releasetrackid: "F2b37e32-3d03-3e94-Bdcd-6f7af339b357" },
        { tracktotal: "14" },
        { disctotal: "1" }
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
