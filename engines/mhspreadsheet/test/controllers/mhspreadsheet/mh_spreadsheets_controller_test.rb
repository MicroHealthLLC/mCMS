require 'test_helper'

module Mhspreadsheet
  class MhSpreadsheetsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get mh_spreadsheets_index_url
      assert_response :success
    end

  end
end
