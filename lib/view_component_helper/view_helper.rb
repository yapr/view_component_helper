#
#
#
module ViewComponentHelper
  def render_view_component(path, *args, **kwargs, &block)
    render path.classify.constantize.new(*args, **kwargs, &block)
  end

  alias render_vc render_view_component
  alias vc render_view_component

  def self.load_components
    Dir[Rails.root.join('app/components/**/*.rb')].each do |file|
      require file

      component_path = file.gsub("#{Rails.root.join('app/components')}/", '').gsub('.rb', '')
      component_class_name = component_path.camelize # don't use classify
      method_name = component_path.gsub('/', '_')

      p "create #{method_name}-----------------------------------------"

      next unless Object.const_defined?(component_class_name) && component_class_name.constantize < ViewComponent::Base

      define_method(method_name) do |*args, **kwargs, &block|
        render component_class_name.constantize.new(*args, **kwargs, &block)
      end
    end
  end
end

ActiveSupport.on_load :action_view do
  include ViewComponentHelper
end if defined?(ActiveSupport)