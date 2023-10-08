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
    end
  end
end
