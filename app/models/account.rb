class Account < ActiveRecord::Base
  include Integratable::Association

  integrates :repository, :github
  integrates :server, :heroku
  integrates :time_tracker, :harvest

  with_options dependent: :destroy do |p|
    p.has_many :accountings, extend: Workable::FindByEmail
    p.has_many :integrations
    p.has_many :projects
  end

  has_many :users, through: :accountings
end
