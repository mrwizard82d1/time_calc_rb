require 'active_support/time'
require 'minitest/autorun'
require 'shoulda'

require 'time_calc/activity'


class ActivityTests < Minitest::Test
  # Test ideas
  # - start 1724
  # - start 0322
  # - start 0004
  # - start 05260655
  # - start 202506220536

  context 'full hours and minutes' do
    setup do
      @cut = TimeCalc::Activity.new('1724', "don't care")
    end
    should 'have the correct start hour' do
      assert_equal(17, @cut.starts_at.hour)
    end
    should 'have correct start minute' do
      assert_equal(24, @cut.starts_at.min)
    end
  end

  context 'zero hour and full minutes' do
    setup do
      @cut = TimeCalc::Activity.new('0322', "don't care")
    end
    should 'have the correct start hour' do
      assert_equal(3, @cut.starts_at.hour)
    end
    should 'have correct start minute' do
      assert_equal(22, @cut.starts_at.min)
    end
  end

  context 'zero hour and zero minute' do
    setup do
      @cut = TimeCalc::Activity.new('0004', "don't care")
    end
    should 'have the correct start hour' do
      assert_equal(0, @cut.starts_at.hour)
    end
    should 'have correct start minute' do
      assert_equal(4, @cut.starts_at.min)
    end
  end

  context 'zero month and full day' do
    setup do
      @cut = TimeCalc::Activity.new('05260655', "don't care")
    end
    should 'have the correct start month' do
      assert_equal(5, @cut.starts_at.month)
    end
    should 'have correct start day' do
      assert_equal(26, @cut.starts_at.day)
    end
    should 'have the correct start hour' do
      assert_equal(6, @cut.starts_at.hour)
    end
    should 'have correct start minute' do
      assert_equal(55, @cut.starts_at.min)
    end
  end

  context 'full year, month, day, hour, minute' do
    setup do
      @cut = TimeCalc::Activity.new('202506220536', "don't care")
    end

    should 'have correct year' do
      assert_equal(2025, @cut.starts_at.year)
    end
    should 'have correct month' do
      assert_equal(6, @cut.starts_at.month)
    end
    should 'have correct day' do
      assert_equal(22, @cut.starts_at.day)
    end
    should 'have correct hour' do
      assert_equal(5, @cut.starts_at.hour)
    end
    should 'have correct minute' do
      assert_equal(36, @cut.starts_at.min)
    end
  end

  context 'duration is end - start' do
    setup do
      @cut = TimeCalc::Activity.new('1220', "don't care")
    end
    should 'have correct duration' do
      @cut.ends_at += 29.minutes # relies on active_support/time
      assert_equal(29.minutes, @cut.duration)
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

  context 'has no project' do
    should 'throw argument error' do
      assert_raises(ArgumentError) { TimeCalc::Activity.new('2131', nil) }
    end
  end

  context 'exactly two activities exact 15.minute multiples' do
    setup do
      @two_activities_one_project = [TimeCalc::Activity.new('1332', "don't care"),
                                     TimeCalc::Activity.new('1347', "don't care")]
    end
    context 'sequence from two activities' do
      setup do
        @sequence = TimeCalc::Activity.make_sequence(@two_activities_one_project)
      end
      should 'end of first in sequence is start of second' do
        assert_equal(@sequence[0].ends_at, @two_activities_one_project[1].starts_at)
      end
      should 'have correct duration' do
        assert_equal(15.minutes, @sequence[0].duration)
      end
    end
    context 'two activities two projects exactly 15.minute multiples' do
      should 'have correct summary' do
        two_activities_two_projects = [TimeCalc::Activity.new('1335', 'publicus'),
                                       TimeCalc::Activity.new('1420', 'praedium'),
                                       TimeCalc::Activity.new('1435', "don't care")]
        assert_equal({'praedium' => 0.25.hours, 'publicus' => 0.75.hours},
                     TimeCalc::Activity.summarize(two_activities_two_projects))
      end
    end
    should 'have correct summary' do
      assert_equal({"don't care" => 0.25.hours},
                   TimeCalc::Activity.summarize(@two_activities_one_project))
    end
  end

  context 'three activities one project exactly 15.minute multiples' do
    setup do
      @two_activities_one_project = [TimeCalc::Activity.new('1332', 'depraedo'),
                     TimeCalc::Activity.new('1347', 'depraedo'),
                     TimeCalc::Activity.new('1402', 'depraedo')]
    end

    should 'have correct summary' do
      assert_equal({'depraedo' => 0.50.hours},
                   TimeCalc::Activity.summarize(@two_activities_one_project))
    end
  end

  context 'many projects not 15.minute multiples' do
    setup do
      @project = 'scindo'
      @dont_care = 'non_curare'
    end
    should 'correctly round 1.hour 7.minutes down to 1.hour' do
      projects = [TimeCalc::Activity.new('1245', @project), TimeCalc::Activity.new('1352', @dont_care)]
      assert_equal(1.hour, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 7.minutes down to 0.minutes' do
      projects = [TimeCalc::Activity.new('1343', @project), TimeCalc::Activity.new('1350', @dont_care)]
      assert_equal(0.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 8.minutes up to 15.minutes' do
      projects = [TimeCalc::Activity.new('1348', @project), TimeCalc::Activity.new('1356', @dont_care)]
      assert_equal(15.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 22.minutes down to 15.minutes' do
      projects = [TimeCalc::Activity.new('1343', @project), TimeCalc::Activity.new('1405', @dont_care)]
      assert_equal(15.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 23.minutes up to 30.minutes' do
      projects = [TimeCalc::Activity.new('1348', @project), TimeCalc::Activity.new('1411', @dont_care)]
      assert_equal(30.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 37.minutes down to 30.minutes' do
      projects = [TimeCalc::Activity.new('1343', @project), TimeCalc::Activity.new('1420', @dont_care)]
      assert_equal(30.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 38.minutes up to 45.minutes' do
      projects = [TimeCalc::Activity.new('1348', @project), TimeCalc::Activity.new('1426', @dont_care)]
      assert_equal(45.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 52.minutes down to 45.minutes' do
      projects = [TimeCalc::Activity.new('1343', @project), TimeCalc::Activity.new('1435', @dont_care)]
      assert_equal(45.minutes, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 53.minutes up to 1.hour' do
      projects = [TimeCalc::Activity.new('1348', @project), TimeCalc::Activity.new('1441', @dont_care)]
      assert_equal(1.hour, TimeCalc::Activity.summarize(projects)[@project])
    end
    should 'correctly round 1.hour to 1.hour' do
      projects = [TimeCalc::Activity.new('1503', @project), TimeCalc::Activity.new('1603', @dont_care)]
      assert_equal(1.hour, TimeCalc::Activity.summarize(projects)[@project])
    end
  end
end

