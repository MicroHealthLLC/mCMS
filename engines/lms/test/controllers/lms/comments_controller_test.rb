require 'test_helper'

module Lms
  class CommentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get comments_index_url
      assert_response :success
    end

    test "should get new" do
      get comments_new_url
      assert_response :success
    end

  end
end
