RSpec.describe "Fourteen Thirtythree" do
  let(:path) { example("fourteen_thirtythree.mp3") }

  let(:expected_tags) do
    {
      title: "Fourteen Thirtythree",
      artist: "Woob",
      album_artist: "Various Artists",
      album: "em:t 2295",
      track: "4",
      part_in_set: "1",
      date: "1995",
      genre: "Ambient",
      user_frames: [
        { tcmp: "1" },
        { totaltracks: "11" },
        { disctotal: "1" },
        { itunes_cddb_1: "9E0F5D0B+295125+11+150+35301+75901+100896+128" \
                         "446+146864+167721+197721+232433+261455+284528" }
      ],
      encoder: "Lavf60.3.100",
      picture: {
        encoding: :utf_8,
        mime: "image/png",
        type: :front_cover,
        description: ""
      }
    }
  end

  include_examples :parses_tags
end
