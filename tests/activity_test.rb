require 'test/unit'

class Activity
  attr_reader :start
  
  def initialize(start_text, project)
    today = Time.new
    start_year, start_month, start_day = today.year, today.month, today.day
    start_hour = start_text.slice(0, 2).to_i
    start_min = start_text.slice(2, 2).to_i
    start_sec = 0
    @start = Time.new(start_year, start_month, start_day,
                      start_hour, start_min, start_sec)
  end
end


class ActivityTest < Test::Unit::TestCase

  # Test ideas
  # - start 1724
  # - start 0322
  # - start 0004
  # - start 0526655
  # - start 202506220536

  def test_new_hhmm_start_hour_set
    cut = Activity.new("1724", nil)

    assert_equal(17, cut.start.hour)
  end

  def test_new_hhmm_start_min_set
    cut = Activity.new("1724", nil)

    assert_equal(24, cut.start.min)
  end

  
  
end
