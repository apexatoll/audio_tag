module AudioTag
  module ID3
    module V2
      module Frames
        class CommentFrame < Frame
          def data
            { language => { description => text } }
          end

          private

          attr_reader :encoding, :text

          def description
            @description.empty? ? :_ : @description.to_sym
          end

          def language
            @language.to_sym
          end

          def extract!
            @encoding    = read_byte!
            @language    = read!(3)
            @description = read_until!(0x00)
            @text        = read_until!(0x00)
          end
        end
      end
    end
  end
end
