require 'test_helper'

module Mindmap
  class MindmapControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get mindmap_index_url
      assert_response :success
    end

  end
end
