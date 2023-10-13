module ID3
  module V2
    class FrameLookup
      class FrameType
        attr_reader :name, :frame_class

        def initialize(name, frame_class = DEFAULT_FRAME_CLASS)
          @name = name
          @frame_class = frame_class
        end
      end

      DEFAULT_FRAME_CLASS = Frame

      FRAME_TYPES = {
        APIC: FrameType.new(:picture, Frames::PictureFrame),
        TALB: FrameType.new(:album),
        TBPM: FrameType.new(:tempo),
        TCOM: FrameType.new(:composer),
        TCON: FrameType.new(:genre),
        TPE1: FrameType.new(:artist),
        TKEY: FrameType.new(:key),
        TXXX: FrameType.new(:user_frames, Frames::UserFrame),
        TDAT: FrameType.new(:date),
        TDLY: FrameType.new(:playlist_delay),
        TENC: FrameType.new(:encoded_by),
        TEXT: FrameType.new(:text),
        TFLT: FrameType.new(:custom),
        TIME: FrameType.new(:time),
        TIT1: FrameType.new(:content_group_description),
        TIT2: FrameType.new(:title),
        TIT3: FrameType.new(:subtitle_description_refinement),
        TLAN: FrameType.new(:language),
        TLEN: FrameType.new(:length),
        TMED: FrameType.new(:custom),
        TOAL: FrameType.new(:original_album),
        TOFN: FrameType.new(:original_filename),
        TOLY: FrameType.new(:original_writer),
        TOPE: FrameType.new(:original_artist),
        TOWN: FrameType.new(:file_owner),
        TPE2: FrameType.new(:album_artist),
        TPE3: FrameType.new(:conductor),
        TPE4: FrameType.new(:other_artist),
        TPOS: FrameType.new(:part_in_set),
        TPUB: FrameType.new(:label),
        TRCK: FrameType.new(:track),
        TRDA: FrameType.new(:recording_date),
        TRSN: FrameType.new(:radio_station_name),
        TRSO: FrameType.new(:radio_station_owner),
        TSIZ: FrameType.new(:size),
        TSRC: FrameType.new(:isrc),
        TSSE: FrameType.new(:encoder),
        TYER: FrameType.new(:year)
      }.freeze

      def self.find(key)
        FRAME_TYPES[key] || FrameType.new(key)
      end
    end
  end
end
