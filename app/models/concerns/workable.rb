module Workable
  module FindByEmail
    def id_for_email email
      User.find_or_initialize_by(email: email).tap do |user|
        user.save validate: false

        # Tie the user to this account, if they aren't already
        # Since we don't mark the `accounting` record as confirmed,
        # they won't be able to cause any damage,
        # or log in to this account
        proxy_association.owner.accountings.find_or_create_by(user_id: user.id)
      end.id
    end
  end

  extend ActiveSupport::Concern

  included do
    belongs_to :worker, class_name: 'User'

    validates :worker_id, inclusion: {
      in: ->(record) { record.project.account.user_ids }
    }
  end

  # Note this side-steps our validation that the worker
  # belong to the account, because id_for_email automatically creates
  # an unconfirmed record tying the email/user to the account
  def worker_email_address= email
    self.worker_id = project.account.accountings.id_for_email(email)
  end
end
