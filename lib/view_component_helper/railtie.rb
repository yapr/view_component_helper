# frozen_string_literal: true

require "rails/railtie"

module ViewComponentHelper
  # Railtie for the ViewComponentHelper module.
  #
  # This Railtie ensures that the components in the Rails application
  # are loaded and available for use during the app's initialization process.
  #
  class Railtie < Rails::Railtie
    config.to_prepare do
      ViewComponentHelper.load_components
    end
  end
end
