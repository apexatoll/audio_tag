RSpec.configure do |config|
  config.define_derived_metadata(%r{spec/acceptance/}) do |metadata|
    metadata[:acceptance] = true
  end
end

module AcceptanceHelper
  def tags
    AudioTag::ID3::V2::Tag.from_file(path).to_h
  end

  def example(name)
    File.join(File.dirname(File.expand_path(__dir__)), "examples", name)
  end

  def example_name
    RSpec.current_example.metadata[:full_description].strip
  end

  RSpec.shared_examples :parses_tags do
    it "returns the expected tags" do
      expect(tags).to eq(expected_tags)
    end
  end
end
