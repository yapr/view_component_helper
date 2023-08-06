module ViewComponentHelper
  def render_view_component(path, *args, **kwargs, &)
    render component_class_for(path).new(*args, **kwargs, &)
  end

  alias render_vc render_view_component

  private

  def component_class_for(path)
    component_name.classify.constantize
  end
end

ActiveSupport.on_load :action_view do
  include ViewComponentHelper
end