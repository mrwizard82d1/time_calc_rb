require 'active_support/time'


module Enumerable
  def drop_last(n = 1)
    self.take(self.size - n)
  end
end


module TimeCalc
  class Activity
    attr_reader :starts_at
    attr_accessor :ends_at
    attr_reader :project

    def self.make_sequence(activities)
      activities.drop_last.zip(activities.drop(1)).map do
        | activity, successor |
        activity.ends_at = successor.starts_at
        activity
      end
    end
    def self.summarize(activities)
      raw_result = Activity.make_sequence(activities).reduce(Hash.new(0)) do
        | summary, activity |
        summary[activity.project] += activity.duration
        summary
      end
      result = raw_result.reduce(Hash.new()) do
        | so_far, (project, duration) |
        reduced_duration = duration
        reduced_duration -= 1.hour while (reduced_duration > 1.hour)
        hours = duration - reduced_duration
        rounded_duration = case
                             when (0.minutes <= reduced_duration && reduced_duration <= 7.minutes + 30.seconds)
                               0.minutes
                             when (7.minutes + 30.seconds < reduced_duration &&
                                 reduced_duration <= 22.minutes + 30.seconds)
                               15.minutes
                             when (22.minutes + 30.seconds < reduced_duration &&
                                   reduced_duration <= 37.minutes + 30.seconds)
                               30.minutes
                             when (37.minutes + 30.seconds < reduced_duration &&
                                   reduced_duration <= 52.minutes + 30.seconds)
                               45.minutes
                             when (52.minutes + 30.seconds < reduced_duration && reduced_duration <= 60.minutes)
                               60.minutes
                           end
        so_far[project] = hours + rounded_duration
        so_far
        end
      return result
    end

    def initialize(start_text, project)
      raise ArgumentError, 'Project required.' unless project
      today = Time.new
      # "Parse" the starting time text using a regular expression:
      # Optional 4 digit year (but only if I have 8 digits afterward)
      # Optional 2 digit month (1 -12 but not checked on input)
      # Optional 2 digit day of month (1-31 but not checked on input)
      # Required 2 digit hour
      # Required 2 digit minute
      # No seconds (not checked)
      time_stamp_pattern = /(\d{4}(?=\d{8}))?(\d{2})?(\d{2})?(\d{2})(\d{2})/
      match = time_stamp_pattern.match(start_text)
      raise ArgumentError, "Invalid starting time format: #{start_text}." unless match.size > 0
      @starts_at = Time.new(match[1] || today.year, match[2] || today.month, match[3] || today.day,
                                   match[4], match[5], 0)
      @ends_at = @starts_at
      @project = project
    end

    def duration()
      return @ends_at - @starts_at
    end

    def to_s()
      "#{self.class.name}(starts_at=#{@starts_at}, ends_at=#{ends_at})"
    end
  end
end
