require 'test_helper'

module MeasurementsConverter
  class ConverterControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get converter_index_url
      assert_response :success
    end

  end
end
