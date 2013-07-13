class Integration < ActiveRecord::Base
  class GitHubIntegration < Integration

  end

  class HarvestIntegration < Integration

  end

  class HerokuIntegration < Integration

  end

  attr_encrypted :secret,
    key: Detective::Application.config.secret_key_base

  belongs_to :account

  has_many :identities,
    as: :integration,
    class_name: 'Project::Identity'

  scope :active, -> {
    includes(:account)
  }

  validates_uniqueness_of :type, scope: :account_id
end
