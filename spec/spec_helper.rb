require "audio_tag"

def require_suport_files!
  Dir[File.join(__dir__, "support/**/*.rb")].each { |file| require file }
end

RSpec.configure do |config|
  Kernel.srand(config.seed)

  config.order = :random

  config.disable_monkey_patching!

  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }

  config.default_formatter = :doc if config.files_to_run.one?

  require_suport_files!

  config.include AcceptanceHelper, acceptance: true
end
