# frozen_string_literal: true

require "rails"
require "view_component"
require "view_component_helper"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    files = Dir[File.join(__dir__, "/sandbox/app/components/**/*.rb")]
    files.each { |file| require file }
  end
end
