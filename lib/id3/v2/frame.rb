module ID3
  module V2
    class Frame < StreamSection
      attr_reader :header, :raw_value

      def initialize(stream)
        @header = FrameHeader.new(stream)

        super(stream)
      end

      def key
        header.id
      end

      def to_h
        { key => value }
      end

      alias value raw_value

      private

      def size
        header.frame_size
      end

      def extract!
        @raw_value = read!(size)
      end
    end
  end
end
