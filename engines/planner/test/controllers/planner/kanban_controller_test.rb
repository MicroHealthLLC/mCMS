require 'test_helper'

module Planner
  class KanbanControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get kanban_index_url
      assert_response :success
    end

  end
end
