module TimeCalc
  class Activity
    attr_reader :start

    def initialize(start_text, project)
      if start_text.size == 4
        today = Time.new
        start_year, start_month, start_day = today.year, today.month, today.day
        start_hour = start_text.slice(0, 2).to_i
        start_min = start_text.slice(2, 2).to_i
        start_sec = 0
        @start = Time.new(start_year, start_month, start_day,
                          start_hour, start_min, start_sec)
      elsif start_text.size == 8
        today = Time.new
        start_year = today.year
        start_month = start_text.slice(0, 2).to_i
        start_day = start_text.slice(2, 2).to_i
        start_hour = start_text.slice(4, 2).to_i
        start_min = start_text.slice(6, 2).to_i
        start_sec = 0
        @start = Time.new(start_year, start_month, start_day,
                          start_hour, start_min, start_sec)
      elsif start_text.size == 12
        start_year = start_text.slice(0, 4).to_i
        start_month = start_text.slice(4, 2).to_i
        start_day = start_text.slice(6, 2).to_i
        start_hour = start_text.slice(8, 2).to_i
        start_min = start_text.slice(10, 2).to_i
        start_sec = 0
        @start = Time.new(start_year, start_month, start_day,
                          start_hour, start_min, start_sec)
      end
    end
  end
end