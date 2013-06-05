class Time
  # Returns a range +/- distance_as_time
  def within distance_as_time
    other  = dup
    before = other -= distance_as_time
    after  = other += distance_as_time

    (before..after)
  end
end
