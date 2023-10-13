module ID3
  # Abstract class that models a discrete section of a continuous stream. Child
  # classes must define `#size` and `#extract!` instance methods.

  # The initial stream position is cached at the point of instantiation and is
  # inferred to be the first position of the section. The last point of the
  # section is calculated by adding the section size to this initial position.

  # Because of the assumption that the stream is in the correct position for
  # extraction at the point of instantiation, the class performs extraction
  # automatically at this point, rather than exposing a method to do this
  # on-demand. This is not idempotent, but it ensures that the extract! method
  # is always called exactly once for every object.

  # The overridden extract! method may not need to read all data within the
  # stream section (for example if it contains embedded binary data). Therefore
  # the initializer will also ensure that the stream is advanced to the end of
  # the current section after extraction to prevent serial sections from
  # overlapping.
  class StreamSection < StreamReader
    def initialize(stream)
      super

      @first_pos = stream.pos

      extract! && advance!
    end

    private

    attr_reader :first_pos

    def last_pos
      @last_pos ||= first_pos + size
    end

    def size
      raise NotImplementedError, "size is not defined"
    end

    def extract!
      raise NotImplementedError, "extraction method is not defined"
    end

    def advance!
      stream.seek(last_pos)
    end
  end
end
