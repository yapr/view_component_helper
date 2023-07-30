require 'view_component_helper/view_helper'
module ViewComponentHelper
  class Engine < ::Rails::Engine
    isolate_namespace ViewComponentHelper
    initializer 'view_component_helper.action_view_helpers' do
      ActiveSupport.on_load(:action_view) { include ViewComponentHelper::ViewHelper }
    end
  end
end