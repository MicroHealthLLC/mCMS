require 'test_helper'

class TeleconsultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teleconsult = teleconsults(:one)
  end

  test "should get index" do
    get teleconsults_url
    assert_response :success
  end

  test "should get new" do
    get new_teleconsult_url
    assert_response :success
  end

  test "should create teleconsult" do
    assert_difference('Teleconsult.count') do
      post teleconsults_url, params: { teleconsult: { case_id: @teleconsult.case_id, consult_status_id: @teleconsult.consult_status_id, contact_method_id: @teleconsult.contact_method_id, contact_type_id: @teleconsult.contact_type_id, date: @teleconsult.date, note: @teleconsult.note, time: @teleconsult.time, user_id: @teleconsult.user_id } }
    end

    assert_redirected_to teleconsult_url(Teleconsult.last)
  end

  test "should show teleconsult" do
    get teleconsult_url(@teleconsult)
    assert_response :success
  end

  test "should get edit" do
    get edit_teleconsult_url(@teleconsult)
    assert_response :success
  end

  test "should update teleconsult" do
    patch teleconsult_url(@teleconsult), params: { teleconsult: { case_id: @teleconsult.case_id, consult_status_id: @teleconsult.consult_status_id, contact_method_id: @teleconsult.contact_method_id, contact_type_id: @teleconsult.contact_type_id, date: @teleconsult.date, note: @teleconsult.note, time: @teleconsult.time, user_id: @teleconsult.user_id } }
    assert_redirected_to teleconsult_url(@teleconsult)
  end

  test "should destroy teleconsult" do
    assert_difference('Teleconsult.count', -1) do
      delete teleconsult_url(@teleconsult)
    end

    assert_redirected_to teleconsults_url
  end
end
