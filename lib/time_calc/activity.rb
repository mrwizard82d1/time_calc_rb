module TimeCalc
  class Activity
    attr_reader :start
    attr_reader :project

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
      @start = Time.new(match[1] || today.year, match[2] || today.month, match[3] || today.day,
                        match[4], match[5], 0)
      @project = project
    end
  end
end