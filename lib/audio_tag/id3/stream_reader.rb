module AudioTag
  module ID3
    # Wrapper for native IO stream objects that defines a consistent reading
    # interface.
    #
    # Bang methods indicate that the read operation is not idempotent, as
    # calling them will result in the stream position being advanced. Non-bang
    # methods are idempotent, as they reset the stream position after reading
    # meaning the net effect on the stream position is 0.
    class StreamReader
      attr_reader :stream

      def initialize(stream)
        @stream = stream
      end

      def read!(length)
        stream.read(length) || raise
      end

      def read(length)
        pos = stream.pos

        read!(length)
      ensure
        stream.seek(pos)
      end

      def read_bytes!(length)
        stream.read(length)&.bytes || raise
      end

      def read_bytes(length)
        pos = stream.pos

        read_bytes!(length)
      ensure
        stream.seek(pos)
      end

      def read_byte!
        read_bytes!(1).first || raise
      end

      def read_byte
        read_bytes(1).first || raise
      end

      # Reads the stream up to the specified byte, for example a null
      # delimiter. The given byte is not included in the output, but the stream
      # is advanced to the position after it unless the consume_delimiter flag
      # is false.
      #
      # This is useful for extracting string fragments until a delimiter
      # without including it in the extracted fragment nor the start of the
      # next.
      def read_until!(byte, consume_delimiter: true)
        read_bytes_until!(byte, consume_delimiter:).pack("c*")
      end

      def read_until(byte)
        read_bytes_until(byte).pack("c*")
      end

      # Uses instance method rather than stream.eof? directly as this can be
      # overridden in child classes to prevent read*_until methods extending
      # past the end of a settable limit.
      def read_bytes_until!(byte, consume_delimiter: true)
        [].tap do |bytes|
          until end_of_stream?
            next_byte = stream.getbyte

            if next_byte == byte
              stream.ungetbyte(1) unless consume_delimiter
              break
            end

            bytes << next_byte
          end
        end
      end

      def read_bytes_until(byte)
        pos = stream.pos

        read_bytes_until!(byte)
      ensure
        stream.seek(pos)
      end

      private

      def end_of_stream?
        stream.eof?
      end
    end
  end
end
