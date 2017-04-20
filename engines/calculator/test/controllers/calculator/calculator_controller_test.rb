require 'test_helper'

module Calculator
  class CalculatorControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get calculator_index_url
      assert_response :success
    end

  end
end
