require 'test/unit'

require 'time_calc/activity'


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
    cut = TimeCalc::Activity.new(@full_hour_full_min, nil)

    assert_equal(17, cut.start.hour)
  end

  def test_new_full_hour_full_min_start_min_set
    cut = TimeCalc::Activity.new(@full_hour_full_min, nil)

    assert_equal(24, cut.start.min)
  end

  def test_new_zero_hour_full_min_start_hour_set
    cut = TimeCalc::Activity.new(@zero_hour_full_min, nil)

    assert_equal(3, cut.start.hour)
  end

  def test_new_zero_hour_zero_min_start_hour_set
    cut = TimeCalc::Activity.new(@zero_hour_zero_min, nil)

    assert_equal(0, cut.start.hour)
  end

  def test_new_zero_hour_zero_min_start_min_set
    cut = TimeCalc::Activity.new(@zero_hour_zero_min, nil)

    assert_equal(4, cut.start.min)
  end

  def test_new_zero_month_full_day_start_month_set
    cut = TimeCalc::Activity.new(@zero_month_full_day, nil)

    assert_equal(5, cut.start.month)
  end

  def test_new_zero_month_full_day_start_day_set
    cut = TimeCalc::Activity.new(@zero_month_full_day, nil)

    assert_equal(26, cut.start.day)
  end
end
