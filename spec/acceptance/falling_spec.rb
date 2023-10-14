# rubocop:disable Layout/TrailingWhitespace

RSpec.describe "Falling" do
  let(:path) { example("falling.mp3") }

  let(:expected_tags) do
    {
      user_frames: [
        { major_brand: "isom" },
        { minor_version: "512" },
        { compatible_brands: "isomiso2mp41" },
        {
          uslt: <<~LYRICS.chomp
            [00:07.60] Don't let yourself be hurt this time
            [00:14.68] Don't let yourself be hurt this time
            [00:40.88] Then I saw your face
            [00:53.85] Then I saw your smile
            [01:08.24] The sky is still blue
            [01:13.79] The clouds come and go
            [01:20.14] Yet something is different
            [01:27.21] Are we falling in love?
            [01:48.09] Don't let yourself be hurt this time
            [02:01.25] Don't let yourself be hurt this time
            [02:14.12] Then your kiss so soft
            [02:27.42] Then your touch so warm
            [02:40.84] The stars still shine bright
            [02:46.98] The mountains still high
            [02:53.24] Yet something is different
            [03:00.78] Are we falling in love?
            [03:20.84] Falling, falling
            [03:27.44] Are we falling in love?
            [03:58.49] Falling, falling
            [03:59.39] Are we falling in love?
            [04:00.25] 
          LYRICS
        } 
      ],
      title: "Falling",
      artist: "Julee Cruise",
      composer: "Angelo Badalamenti, David Lynch",
      album: "Soundtrack From Twin Peaks",
      genre: "",
      track: "11/11",
      part_in_set: "1/1",
      TDRC: "1990-09-11",
      TCOP: "\xE2\x84\x97 1989 Warner Records Inc.".force_encoding(
        Encoding::ASCII_8BIT
      ),
      album_artist: "Twin Peaks",
      encoder: "Lavf60.3.100",
      picture: {
        encoding: :utf_8,
        mime: "image/png",
        type: :other,
        description: ""
      }
    }
  end

  include_examples :parses_tags
end

# rubocop:enable Layout/TrailingWhitespace
