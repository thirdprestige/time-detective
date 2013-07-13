module Projects
  class TimeEntriesController < ApplicationController
    load_and_authorize_resource :project
    load_and_authorize_resource :time_entry,
      class_name: 'Project::TimeEntry',
      through: :project

    def confirm
      @time_entry.confirm!
    end

    def destroy
      @time_entry.ignore!
    end
  end
end
