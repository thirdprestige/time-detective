class Block < ActiveRecord::Base
  default_scope { order("position asc") }
end
