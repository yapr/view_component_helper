# frozen_string_literal: true

# Test component that accepts a `title` argument and displays it.
class TitleComponent < ViewComponent::Base
  def initialize(title:)
    super
    @title = title
  end

  def call
    "Title is #{@title}"
  end
end