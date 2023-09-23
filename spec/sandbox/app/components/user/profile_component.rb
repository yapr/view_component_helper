# frozen_string_literal: true

# This is a test component for the helper provided earlier.
# user profile component
class User::ProfileComponent < ViewComponent::Base

  def initialize(name:, age:, gender:))
    super
    @name = name
    @age  = age
    @gender = gender
  end

  def call
    "user profile #{}"
  end
end