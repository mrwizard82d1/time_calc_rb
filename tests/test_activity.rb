require 'test/unit'

class Activity
  attr_reader :start
  
  def initialize(start_hour, start_min, project)
    @start = Time.new
  end
end

class TestActivity < Test::Unit::TestCase

  def test_new_start_start_set
    expect_start_hour = 6
    
    cut = Activity.new(expect_start_hour, nil, nil)

    assert_equal(expect_start_hour, cut.start.hour)
  end
  
end
