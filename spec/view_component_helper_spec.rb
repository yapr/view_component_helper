# frozen_string_literal: true

RSpec.describe ViewComponentHelper, type: :helper do
  it "has a version number" do
    expect(ViewComponentHelper::VERSION).not_to be nil
  end

  let(:dummy_class) do
    Class.new do
      include ViewComponentHelper
      ViewComponentHelper.load_components(-> { Dir[File.join(__dir__, "/sandbox/app/components/**/*.rb")] })
    end
  end

  describe ".load_components" do
    it "defines methods for each component" do
      expect(dummy_class.new).to respond_to(:button)
      expect(dummy_class.new).to respond_to(:user_profile_component)
      expect(dummy_class.new).to respond_to(:dialog_component)
      expect(dummy_class.new).to respond_to(:title_component)
    end
  end
end
