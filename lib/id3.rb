require "zeitwerk"

module ID3
  Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
    loader.inflector.inflect("id3" => "ID3")
  end.setup
end
