class Project < ActiveRecord::Base
  # An Activity is an actual piece of work completed by a worker
  # for a specific project.
  #
  # For example, a Heroku release will be one activity record,
  # belonging to a specific project, and a specific worker
  #
  # So would one GitHub commit, or one email sent to a client
  class Activity < ActiveRecord::Base
    include ActivityWindow, Integratable, PendingTimeEntryBuilder, Workable

    belongs_to :project, touch: true
    belongs_to :time_entry

    scope :potentially_unbilled_work, -> {
      where(time_entry_id: nil)
    }

    def overlapping_time_entries
      project.time_entries.
        where(created_at: created_at.within(4.hours)).
        where(worker_id: worker_id)
    end
  end

  # A Project will have many separate IDs through each integration,
  # for example, a Basecamp ID, a Harvest ID, a Heroku app name, etc
  #
  # A project may have multiple identities for the same integration type:
  # several Heroku apps belonging to the Brigham project, or
  # several Dropbox folders
  class Identity < ActiveRecord::Base
    belongs_to :project
  end

  class TimeEntry < ActiveRecord::Base
    include AASM, Workable

    after_create :tie_to_overlapping_time_entries, if: :pending?

    belongs_to :project, touch: true
    has_many :activities

    aasm do
      locked = -> do
        attr_readonly :description, :hours
      end

      state :committed, &locked
      state :confirmed, &locked
      state :ignored
      state :pending, initial: true

      event :confirm do
        transitions to: :confirmed, from: [:ignored, :pending]
      end

      # Once the worker has confirmed the entry,
      # we need to copy it over to the actual time-tracking software.
      # We want to be able to reflect this in the UI,
      # and re-try the commit if the time-tracking software glitches,
      # so this is a separate state/event, here
      event :commit do
        transitions to: :committed, from: :confirmed
      end

      event :ignore do
        # For now, you can't transition from "committed" entries,
        # because we would have to go yank the entrys out of the time-tracking software
        transitions to: :ignored, from: [:confirmed, :pending]
      end
    end

  protected

    def tie_to_overlapping_time_entries
      activities.window.potentially_unbilled_work.update_all project_time_entry_id: id
    end
  end

  belongs_to :account

  with_options dependent: :destroy do |p|
    p.has_many :activities, extend: ActivityWindow
    p.has_many :identities
    p.has_many :time_entries
  end
end
