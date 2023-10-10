module ID3
  module V2
    class TextDecoder
      ENCODINGS = {
        ascii:    /^\x00(.*?)(\x00)?$/,
        utf_16:   /^\x01(.*?)(\x00\x00)?$/,
        utf_16be: /^\x02(.*?)(\x00\x00)?$/,
        utf_8:    /^\x03(.*?)(\x00)?$/
      }.freeze

      def self.encoding(string)
        case string
        when ENCODINGS[:ascii]    then :ascii
        when ENCODINGS[:utf_16]   then :utf_16
        when ENCODINGS[:utf_16be] then :utf_16be
        when ENCODINGS[:utf_8]    then :utf_8
        end
      end

      def self.decode(string)
        case encoding(string)
        when :ascii    then string.gsub(ENCODINGS[:ascii],    "\\1")
        when :utf_16   then string.gsub(ENCODINGS[:utf_16],   "\\1")
        when :utf_16be then string.gsub(ENCODINGS[:utf_16be], "\\1")
        when :utf_8    then string.gsub(ENCODINGS[:utf_8],    "\\1")
        else string
        end
      end
    end
  end
end
