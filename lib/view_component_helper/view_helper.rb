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
    components_files.each do |file|
      component_path = extract_component_path(file)
      component_class_name = component_path.camelize
      method_name = component_path.gsub("/", "_")

      define_render_method_for(component_class_name, method_name) if valid_component_class?(component_class_name)
    end
  end

  def self.components_files
    Dir[Rails.root.join("app/components/**/*.rb")].sort
  end

  def self.extract_component_path(file)
    file.gsub("#{Rails.root.join("app/components")}/", "").gsub(".rb", "")
  end

  def self.valid_component_class?(component_class_name)
    Object.const_defined?(component_class_name) && component_class_name.constantize < ViewComponent::Base
  end

  def self.define_render_method_for(component_class_name, method_name)
    define_method(method_name) do |*args, **kwargs, &block|
      render component_class_name.constantize.new(*args, **kwargs, &block)
    end
  end
end

if defined?(ActiveSupport)
  ActiveSupport.on_load :action_view do
    include ViewComponentHelper
  end
end
