module ID3
  module V2
    class FrameMerger
      attr_reader :frames

      def initialize(frames)
        @frames = frames
      end

      def merge
        pairs.each_with_object({}) do |(key, value), hash|
          case hash[key]
          when Hash, String then hash[key] = [hash[key], value]
          when Array        then hash[key] << value
          else hash[key] = value
          end
        end
      end

      private

      def pairs
        frames.map(&:to_h).flat_map(&:to_a)
      end
    end
  end
end
