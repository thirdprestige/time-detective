module Workable
  extend ActiveSupport::Concern

  included do
    belongs_to :worker, class_name: 'User'

    validates :worker_id, inclusion: {
      in: ->(record) { record.project.account.user_ids }
    }
  end
end
