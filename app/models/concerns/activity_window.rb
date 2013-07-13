module ActivityWindow
  def window_for entry
    where(created_at: entry.created_at.within(4.hours)).
    where(worker_id: entry.worker_id)
  end
end
