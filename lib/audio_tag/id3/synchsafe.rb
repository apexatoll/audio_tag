module AudioTag
  module ID3
    class Synchsafe
      MAX_BYTE = 128

      class InvalidBytesError < StandardError
        def message = "MSB of byte must be 0"
      end

      def self.parse(*bytes)
        raise InvalidBytesError if bytes.any? { |byte| byte >= MAX_BYTE }

        bytes.reverse_each.with_index.map do |byte, index|
          byte << (7 * index)
        end.reduce(:|)
      end
    end
  end
end
