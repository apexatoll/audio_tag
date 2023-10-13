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
        TXXX: FrameType.new(:user_frames, Frames::UserFrame)
      }.freeze

      def self.find(key)
        FRAME_TYPES[key] || FrameType.new(key)
      end
    end
  end
end
