module ID3
  module V2
    class Tag < StreamSection
      attr_reader :header, :frames

      def initialize(stream)
        @header = TagHeader.new(stream)

        super(stream)
      end

      def self.from_file(path)
        File.open(path) { |file| new(file) }
      end

      private

      def end_of_tag?
        stream.pos >= last_pos || read_byte.zero?
      end

      def size
        header.tag_size
      end

      def extract!
        @frames = [].tap do |frames|
          frames << Frame.new(stream) until end_of_tag?
        end
      end
    end
  end
end
