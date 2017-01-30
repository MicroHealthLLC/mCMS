require 'test_helper'

class ClientJournalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_journal = client_journals(:one)
  end

  test "should get index" do
    get client_journals_url
    assert_response :success
  end

  test "should get new" do
    get new_client_journal_url
    assert_response :success
  end

  test "should create client_journal" do
    assert_difference('ClientJournal.count') do
      post client_journals_url, params: { client_journal: { date: @client_journal.date, journal_type_id: @client_journal.journal_type_id, note: @client_journal.note, title: @client_journal.title } }
    end

    assert_redirected_to client_journal_url(ClientJournal.last)
  end

  test "should show client_journal" do
    get client_journal_url(@client_journal)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_journal_url(@client_journal)
    assert_response :success
  end

  test "should update client_journal" do
    patch client_journal_url(@client_journal), params: { client_journal: { date: @client_journal.date, journal_type_id: @client_journal.journal_type_id, note: @client_journal.note, title: @client_journal.title } }
    assert_redirected_to client_journal_url(@client_journal)
  end

  test "should destroy client_journal" do
    assert_difference('ClientJournal.count', -1) do
      delete client_journal_url(@client_journal)
    end

    assert_redirected_to client_journals_url
  end
end
