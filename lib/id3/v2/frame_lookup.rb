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

      FRAME_TYPES = {}.freeze

      def self.find(key)
        FRAME_TYPES[key] || default_frame_type(key)
      end

      def self.default_frame_type(key)
        name = key.to_s.downcase.to_sym

        FrameType.new(name)
      end

      private_class_method :default_frame_type
    end
  end
end
