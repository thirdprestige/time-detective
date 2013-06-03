module ActivityWindow
  def window
    # weird SQL goes here,
    # we'll need to calculate all the activities
    # across ALL the created_ats
    # in the current scope
    where(created_at: created_at.within(4.hours))
    where(worker_id: worker_id)
  end
end