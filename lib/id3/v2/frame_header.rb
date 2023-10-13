module ID3
  module V2
    class FrameHeader < Header
      STRUCTURE = %i[
        id id id id
        size size size size
        flags flags
      ].freeze

      def id
        @id ||= bytes_for(:id).pack("c*").to_sym
      end

      def frame_size
        @frame_size ||= Synchsafe.parse(*bytes_for(:size))
      end

      def key
        @key ||= frame_type.name
      end

      def frame_class
        @frame_class ||= frame_type.frame_class
      end

      private

      def frame_type
        @frame_type ||= FrameType.find(id)
      end
    end
  end
end
