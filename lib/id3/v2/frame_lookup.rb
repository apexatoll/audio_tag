module ID3
  module V2
    class FrameLookup
      FRAME_TYPES = {
        APIC: { name: :picture, class: Frames::PictureFrame },
        TALB: { name: :album },
        TBPM: { name: :tempo },
        TCOM: { name: :composer },
        TCON: { name: :genre },
        TPE1: { name: :artist },
        TKEY: { name: :key },
        TXXX: { name: :user_frames, class: Frames::UserFrame },
        TDAT: { name: :date },
        TDLY: { name: :playlist_delay },
        TENC: { name: :encoded_by },
        TEXT: { name: :text },
        TFLT: { name: :custom },
        TIME: { name: :time },
        TIT1: { name: :content_group_description },
        TIT2: { name: :title },
        TIT3: { name: :subtitle_description_refinement },
        TLAN: { name: :language },
        TLEN: { name: :length },
        TMED: { name: :custom },
        TOAL: { name: :original_album },
        TOFN: { name: :original_filename },
        TOLY: { name: :original_writer },
        TOPE: { name: :original_artist },
        TOWN: { name: :file_owner },
        TPE2: { name: :album_artist },
        TPE3: { name: :conductor },
        TPE4: { name: :other_artist },
        TPOS: { name: :part_in_set },
        TPUB: { name: :label },
        TRCK: { name: :track },
        TRDA: { name: :recording_date },
        TRSN: { name: :radio_station_name },
        TRSO: { name: :radio_station_owner },
        TSIZ: { name: :size },
        TSRC: { name: :isrc },
        TSSE: { name: :encoder },
        TYER: { name: :year }
      }.freeze

      DEFAULT_FRAME_CLASS = Frame

      class FrameType
        attr_reader :name, :frame_class

        def initialize(**attributes)
          @name        = attributes[:name]
          @frame_class = attributes[:class] || DEFAULT_FRAME_CLASS
        end
      end

      def self.find(key)
        attributes = FRAME_TYPES[key] || { name: key }

        FrameType.new(**attributes)
      end
    end
  end
end
