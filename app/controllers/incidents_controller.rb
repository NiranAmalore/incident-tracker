class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  before_action :require_approver!, only: [:edit, :update, :destroy]

  def index
    @incidents = Incident.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = Current.user.incidents.new(create_params)

    if @incident.save
      IncidentMailer.created(@incident).deliver_later
      redirect_to @incident, notice: "Incident was successfully reported."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @incident.update(update_params)
      IncidentMailer.status_changed(@incident).deliver_later if @incident.saved_change_to_status?
      redirect_to @incident, notice: "Incident was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @incident.destroy
    redirect_to incidents_path, notice: "Incident was successfully deleted.", status: :see_other
  end

  private

  def set_incident
    @incident = Incident.find(params[:id])
  end

  def require_approver!
    unless Current.user.approver?
      redirect_to incidents_path, alert: "Only approvers can edit or delete incidents."
    end
  end

  def create_params
    params.require(:incident).permit(:title, :description, :severity)
  end

  def update_params
    params.require(:incident).permit(:title, :description, :severity, :status)
  end
end