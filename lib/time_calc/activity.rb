module TimeCalc
  class Activity
    attr_reader :start

    def initialize(start_text, _project)
      today = Time.new
      time_stamp_pattern = /(\d{4}(?=\d{2}\d{2}\d{2}\d{2}))?(\d{2})?(\d{2})?(\d{2})(\d{2})/
      match = time_stamp_pattern.match(start_text)
      raise ArgumentError, "Invalid starting time format: #{start_text}." unless match.size > 0
      start_year = match[1] || today.year
      start_month = match[2] || today.month
      start_day = match[3] || today.day
      start_hour = match[4]
      start_min = match[5]
      start_sec = 0
      @start = Time.new(start_year, start_month, start_day,
                        start_hour, start_min, start_sec)
    end
  end
end