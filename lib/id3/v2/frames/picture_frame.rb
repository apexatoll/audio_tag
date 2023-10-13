module ID3
  module V2
    module Frames
      class PictureFrame < Frame
        ENCODINGS = %i[
          ascii
          utf_16
          utf_16be
          utf_8
        ].freeze

        TYPES = %i[
          other
          thumbnail
          other_thumbnail
          front_cover
          back_cover
          leaflet_page
          media_page
          lead_artist
          artist
          conductor
          band
          composer
          lyricist
          recording_location
          during_recording
          during_performance
          movie_capture
          bright_colored_fish
          illustration
          band_logo
          publisher_logo
        ].freeze

        def data
          { encoding:, mime:, type:, description: }
        end

        private

        attr_reader :mime, :description

        def encoding
          ENCODINGS[@encoding]
        end

        def type
          TYPES[@type]
        end

        def extract!
          @encoding    = read_byte!
          @mime        = read_until!(0x00)
          @type        = read_byte!
          @description = read_until!(0x00)
        end
      end
    end
  end
end
