# frozen_string_literal: true

# This is a test component for the helper provided earlier.
# While the conventional naming for such components would be `xxx_component.rb`,
# naming it as `button.rb` here provides the advantage of having shorter method names.
# For instance, we can use it as <%= button %> in the views.
class Button < ViewComponent::Base
  def call
    "Button"
  end
end