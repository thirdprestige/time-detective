module PendingTimeEntryBuilder
  extend ActiveSupport::Concern

  included do
    delegate :description, :estimated_hours,
      to: :
  end

  def build_pending_time_entry *args
    build_time_entry do |time_entry|
      time_entry.description = build_description_across_activities_in_window
      time_entry.hours       = estimated_hours_across_activities_in_window
    end
  end

  def build_description_across_activities_in_window
    'Hello, world'
  end

  def estimated_hours_across_activies_in_window
    project.activities.potentially_unbilled_work.
      where('id NOT IN (?)', self.id).
      where(created_at: created_at.within(4.hours))
      where(worker_id: worker_id).sum(&:estimated_hours)
  end
end
