# frozen_string_literal: true

# ViewComponentHelper Module
#
# This module provides utility methods to assist with rendering ViewComponents
# within a Rails application. It aims to simplify the process of invoking
# and displaying components based on their file paths and additional arguments.
#
module ViewComponentHelper
  require "active_support/core_ext/string/inflections"

  def render_view_component(path, *args, collection: nil, **kwargs, &block)
    component_klass = path.classify.constantize

    if collection
      render component_klass.with_collection(collection, *args, **kwargs, &block)
    else
      component_instance = component_klass.new(*args, **kwargs)
      component_instance.instance_exec(&block) if block_given?
      render(component_instance)
    end
  end

  alias render_vc render_view_component
  alias vc render_view_component

  def self.load_components(component_loader = -> { Dir[Rails.root.join("app/components/**/*.rb")] })
    component_loader.call.each do |file|
      component_path = file[%r{components/(.*)\.rb$}, 1]
      component_class_name = component_path.camelize
      method_name = component_path.gsub("/", "_")

      define_render_method_for(component_class_name, method_name) if valid_component_class?(component_class_name)
    end
  end

  def self.valid_component_class?(component_class_name)
    Object.const_defined?(component_class_name) && component_class_name.constantize < ViewComponent::Base
  end

  def self.define_render_method_for(component_class_name, method_name)
    define_method(method_name) do |*args, collection: nil, **kwargs, &block|
      component_klass = component_class_name.constantize

      if collection
        render component_klass.with_collection(collection, *args, **kwargs, &block)
      else
        component_instance = component_klass.new(*args, **kwargs, &block)
        render component_instance
      end
    end
  end
end

if defined?(ActiveSupport)
  ActiveSupport.on_load :action_view do
    include ViewComponentHelper
  end
end
