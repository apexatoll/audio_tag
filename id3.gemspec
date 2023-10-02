require_relative "lib/id3/version"

Gem::Specification.new do |spec|
  spec.name = "id3"
  spec.version = ID3::VERSION
  spec.authors = ["Chris Welham"]
  spec.email = ["71787007+apexatoll@users.noreply.github.com"]

  spec.summary = "ID3 audio tagging interface implemented in Ruby"
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
end
