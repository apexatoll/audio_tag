module AudioTag
  module ID3
    module V2
      class TagHeader < Header
        STRUCTURE = %i[
          identifier identifier identifier
          version
          revision
          flags
          size size size size
        ].freeze

        IDENTIFIER = "ID3".freeze

        INVALID_FLAG_MASK   = 0x8F
        EXPERIMENTAL_MASK   = 0x10
        EXTENDED_MASK       = 0x20
        UNSYNCHRONISED_MASK = 0x40

        def initialize(stream)
          super

          validate_identifier!
          validate_flags!
        end

        def experimental?
          (flags & EXPERIMENTAL_MASK).positive?
        end

        def extended?
          (flags & EXTENDED_MASK).positive?
        end

        def unsynchronised?
          (flags & UNSYNCHRONISED_MASK).positive?
        end

        def tag_size
          @tag_size ||= Synchsafe.parse(*bytes_for(:size))
        end

        def total_size
          @total_size ||= tag_size + size
        end

        private

        def identifier
          @identifier ||= bytes_for(:identifier).pack("c*")
        end

        def flags
          @flags ||= bytes_for(:flags).first || raise
        end

        def validate_identifier!
          return if identifier == IDENTIFIER

          raise "invalid ID3 tag identifier: #{identifier}"
        end

        def validate_flags!
          return if (flags & INVALID_FLAG_MASK).zero?

          raise "invalid flags set"
        end
      end
    end
  end
end
