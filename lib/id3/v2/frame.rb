module ID3
  module V2
    class Frame < StreamSection
      attr_reader :header, :raw_data

      def initialize(stream, header: FrameHeader.new(stream))
        @header = header

        super(stream)
      end

      def key
        header.id
      end

      def data
        TextDecoder.decode(raw_data)
      end

      def to_h
        { key => data }
      end

      def self.build(stream)
        header = FrameHeader.new(stream)

        header.frame_class.new(stream, header:)
      end

      private

      def size
        header.frame_size
      end

      def extract!
        @raw_data = read!(size)
      end
    end
  end
end
