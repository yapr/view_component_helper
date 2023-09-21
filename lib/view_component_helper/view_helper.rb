# frozen_string_literal: true

# ViewComponentHelper Module
#
# This module provides utility methods to assist with rendering ViewComponents
# within a Rails application. It aims to simplify the process of invoking
# and displaying components based on their file paths and additional arguments.
#
module ViewComponentHelper
  def render_view_component(path, *args, **kwargs, &block)
    render path.classify.constantize.new(*args, **kwargs, &block)
  end

  alias render_vc render_view_component
  alias vc render_view_component

  def self.load_components
    Dir[Rails.root.join("app/components/**/*.rb")].sort.each do |file|
      require file

      component_path = file.gsub("#{Rails.root.join("app/components")}/", "").gsub(".rb", "")
      component_class_name = component_path.camelize # don't use classify
      method_name = component_path.gsub("/", "_")

      next unless Object.const_defined?(component_class_name) && component_class_name.constantize < ViewComponent::Base

      define_method(method_name) do |*args, **kwargs, &block|
        render component_class_name.constantize.new(*args, **kwargs, &block)
      end
    end
  end
end

if defined?(ActiveSupport)
  ActiveSupport.on_load :action_view do
    include ViewComponentHelper
  end
end
