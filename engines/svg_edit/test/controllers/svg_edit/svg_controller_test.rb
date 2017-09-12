require 'test_helper'

module SvgEdit
  class SvgControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get svg_index_url
      assert_response :success
    end

  end
end
