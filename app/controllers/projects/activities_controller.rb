module Projects
  class ActivitiesController < ApplicationController
    load_and_authorize_resource :account
    load_and_authorize_resource :project,
      class_name: 'Project::Activity',
      through: :account

    respond_to :html, :json

    def create
      project.activities.create!(activity_params)
    end

  protected

    def activity_params
      params[:activity].require(:external_identifier, :worker_email_address).permit(:created_at)
    end
  end
end
