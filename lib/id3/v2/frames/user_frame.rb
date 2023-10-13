module ID3
  module V2
    module Frames
      class UserFrame < Frame
        DESCRIPTIONS = {}.freeze

        def data
          { description => value }
        end

        private

        attr_reader :encoding, :value

        def description
          DESCRIPTIONS[@description.to_sym] || @description.downcase.to_sym
        end

        def extract!
          @encoding    = read_byte!
          @description = read_until!(0x00)
          @value       = read_until!(0x00)
        end
      end
    end
  end
end
