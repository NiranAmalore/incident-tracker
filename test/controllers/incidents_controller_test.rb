require "test_helper"

class IncidentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incident = incidents(:open_incident)
  end

  test "reporter cannot access edit page" do
    sign_in_as users(:reporter_user)
    get edit_incident_url(@incident)
    assert_redirected_to incidents_url
    follow_redirect!
    assert_match "Only approvers", response.body
  end

  test "reporter cannot update an incident" do
    sign_in_as users(:reporter_user)
    patch incident_url(@incident), params: { incident: { status: "resolved" } }
    assert_redirected_to incidents_url
    @incident.reload
    assert_not_equal "resolved", @incident.status
  end

  test "approver can access edit page" do
    sign_in_as users(:approver_user)
    get edit_incident_url(@incident)
    assert_response :success
  end

  test "approver can update an incident" do
    sign_in_as users(:approver_user)
    patch incident_url(@incident), params: { incident: { status: "resolved" } }
    assert_redirected_to incident_url(@incident)
    @incident.reload
    assert_equal "resolved", @incident.status
  end

  test "unauthenticated user is redirected to login" do
    get incidents_url
    assert_redirected_to new_session_url
  end
end