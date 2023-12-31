require_relative "lib/audio_tag/version"

Gem::Specification.new do |spec|
  spec.name = "audio_tag"
  spec.version = AudioTag::VERSION
  spec.authors = ["Chris Welham"]
  spec.email = ["71787007+apexatoll@users.noreply.github.com"]

  spec.summary = "Ruby library for reading and writing audio file metadata"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|spec)/|\.(?:git))})
    end
  end

  spec.bindir = "exe"
  spec.executables = []
  spec.require_paths = ["lib"]

  spec.add_dependency "zeitwerk"
end
