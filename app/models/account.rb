class Account < ActiveRecord::Base
  with_options dependent: :destroy do |p|
    p.has_many :projects
    p.has_many :accountings
  end

  has_many :users, through: :accountings
end
