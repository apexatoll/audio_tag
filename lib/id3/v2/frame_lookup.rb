module ID3
  module V2
    class FrameLookup
      FRAME_TYPES = {
        APIC: [:picture, Frames::PictureFrame],
        TALB: [:album],
        TBPM: [:tempo],
        TCOM: [:composer],
        TCON: [:genre],
        TPE1: [:artist],
        TKEY: [:key],
        TXXX: [:user_frames, Frames::UserFrame],
        TDAT: [:date],
        TDLY: [:playlist_delay],
        TENC: [:encoded_by],
        TEXT: [:text],
        TFLT: [:custom],
        TIME: [:time],
        TIT1: [:content_group_description],
        TIT2: [:title],
        TIT3: [:subtitle_description_refinement],
        TLAN: [:language],
        TLEN: [:length],
        TMED: [:custom],
        TOAL: [:original_album],
        TOFN: [:original_filename],
        TOLY: [:original_writer],
        TOPE: [:original_artist],
        TOWN: [:file_owner],
        TPE2: [:album_artist],
        TPE3: [:conductor],
        TPE4: [:other_artist],
        TPOS: [:part_in_set],
        TPUB: [:label],
        TRCK: [:track],
        TRDA: [:recording_date],
        TRSN: [:radio_station_name],
        TRSO: [:radio_station_owner],
        TSIZ: [:size],
        TSRC: [:isrc],
        TSSE: [:encoder],
        TYER: [:year]
      }.freeze

      DEFAULT_FRAME_CLASS = Frame

      class FrameType
        attr_reader :name, :frame_class

        def initialize(name, frame_class = DEFAULT_FRAME_CLASS)
          @name = name
          @frame_class = frame_class
        end
      end

      def self.find(key)
        attributes = FRAME_TYPES[key] || [key]

        FrameType.new(attributes[0], attributes[1] || DEFAULT_FRAME_CLASS)
      end
    end
  end
end
