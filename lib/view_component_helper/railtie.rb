require 'rails/railtie'

module ViewComponentHelper
  class Railtie < Rails::Railtie
    config.to_prepare do
      ViewComponentHelper.load_components
    end
  end
end