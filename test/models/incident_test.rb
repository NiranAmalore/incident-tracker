require "test_helper"

class IncidentTest < ActiveSupport::TestCase
  test "a fixture incident is valid" do
    incident = incidents(:open_incident)
    assert incident.valid?
  end

  test "is invalid without a title" do
    incident = incidents(:open_incident)
    incident.title = nil
    assert_not incident.valid?
  end

  test "defaults to open status and low severity" do
    incident = Incident.new(title: "New issue", user: users(:reporter_user))
    assert_equal "open", incident.status
    assert_equal "low", incident.severity
  end

  test "belongs to the correct user" do
    incident = incidents(:open_incident)
    assert_equal users(:reporter_user), incident.user
  end
end