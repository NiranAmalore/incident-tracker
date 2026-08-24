class IncidentMailer < ApplicationMailer
  def created(incident)
    @incident = incident
    mail(
      to: @incident.user.email_address,
      subject: "Incident reported: #{@incident.title}"
    )
  end

  def status_changed(incident)
    @incident = incident
    mail(
      to: @incident.user.email_address,
      subject: "Incident update: #{@incident.title} is now #{@incident.status.humanize}"
    )
  end
end