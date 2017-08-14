require 'test_helper'

module TextEditor
  class TexteditorControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get texteditor_index_url
      assert_response :success
    end

  end
end
