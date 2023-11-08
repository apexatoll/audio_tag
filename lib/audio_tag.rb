require "zeitwerk"

module AudioTag
  Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
    loader.inflector.inflect("id3" => "ID3")
  end.setup
end
