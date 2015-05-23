require 'minitest/autorun'
require 'shoulda'

require 'time_calc/activity'


class ActivityTest < Minitest::Test
  # Test ideas
  # - start 1724
  # - start 0322
  # - start 0004
  # - start 05260655
  # - start 202506220536

context 'full hours and minutes' do
    setup do
      @cut = TimeCalc::Activity.new('1724', nil)
    end
    should 'have the correct start hour' do
      assert_equal(17, @cut.start.hour)
    end
    should 'have correct start minute' do
      assert_equal(24, @cut.start.min)
    end
  end

  context 'zero hour and full minutes' do
    setup do
      @cut = TimeCalc::Activity.new('0322', nil)
    end
    should 'have the correct start hour' do
      assert_equal(3, @cut.start.hour)
    end
    should 'have correct start minute' do
      assert_equal(22, @cut.start.min)
    end
  end

  context 'zero hour and zero minute' do
    setup do
      @cut = TimeCalc::Activity.new('0004', nil)
    end
    should 'have the correct start hour' do
      assert_equal(0, @cut.start.hour)
    end
    should 'have correct start minute' do
      assert_equal(4, @cut.start.min)
    end
  end

  context 'zero month and full day' do
    setup do
      @cut = TimeCalc::Activity.new('05260655', nil)
    end
    should 'have the correct start month' do
      assert_equal(5, @cut.start.month)
    end
    should 'have correct start day' do
      assert_equal(26, @cut.start.day)
    end
    should 'have the correct start hour' do
      assert_equal(6, @cut.start.hour)
    end
    should 'have correct start minute' do
      assert_equal(55, @cut.start.min)
    end
  end

  context 'full year, month, day, hour, minute' do
    setup do
      @cut = TimeCalc::Activity.new('202506220536', nil)
    end

    should 'have correct year' do
      assert_equal(2025, @cut.start.year)
    end
    should 'have correct month' do
      assert_equal(6, @cut.start.month)
    end
    should 'have correct day' do
      assert_equal(22, @cut.start.day)
    end
    should 'have correct hour' do
      assert_equal(5, @cut.start.hour)
    end
    should 'have correct minute' do
      assert_equal(36, @cut.start.min)
    end
  end

  context 'has project' do
    setup do
      @cut = TimeCalc::Activity.new('1702', 'time_sheet')
    end

    should 'have correct project' do
      assert_equal('time_sheet', @cut.project)
    end
  end
end

