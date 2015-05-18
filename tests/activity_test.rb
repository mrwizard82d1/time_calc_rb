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
  # - start 05260655
  # - start 202506220536

  def setup
    @zero_month_full_day = '05260655'
    @full_hour_full_min = '1724'
    @zero_hour_full_min = '0322'
    @zero_hour_zero_min = '0004'
  end


  def test_new_full_hour_full_min_start_hour_set
    cut = Activity.new(@full_hour_full_min, nil)

    assert_equal(17, cut.start.hour)
  end

  def test_new_full_hour_full_min_start_min_set
    cut = Activity.new(@full_hour_full_min, nil)

    assert_equal(24, cut.start.min)
  end

  def test_new_zero_hour_full_min_start_hour_set
    cut = Activity.new(@zero_hour_full_min, nil)

    assert_equal(3, cut.start.hour)
  end

  def test_new_zero_hour_zero_min_start_hour_set
    cut = Activity.new(@zero_hour_zero_min, nil)

    assert_equal(0, cut.start.hour)
  end

  def test_new_zero_hour_zero_min_start_min_set
    cut = Activity.new(@zero_hour_zero_min, nil)

    assert_equal(4, cut.start.min)
  end

end
