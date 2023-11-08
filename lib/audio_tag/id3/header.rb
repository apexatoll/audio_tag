module AudioTag
  module ID3
    class Header < StreamSection
      attr_reader :bytes

      def bytes_for(key)
        first = structure.index(key) || raise("invalid key :#{key}")
        last  = structure.rindex(key)

        bytes[first..last] || raise
      end

      private

      UNEXTENDED_SIZE = 10

      def size
        UNEXTENDED_SIZE
      end

      def structure
        raise "structure constant not set" unless structure_defined?

        self.class.const_get(:STRUCTURE)
      end

      def structure_defined?
        self.class.const_defined?(:STRUCTURE)
      end

      def extract!
        @bytes = read_bytes!(size)
      end
    end
  end
end
