require 'time_calc/activity.rb'

def seconds_to_hhmm(duration_sec)
  hours, seconds = duration_sec.to_i.divmod(3600)
  minutes = seconds / 60
  return '%02d%02d' % [hours, minutes]
end

activity_lines = IO.readlines(ARGV[0]).collect { | l | l.strip.split(nil, 2) }
activities = activity_lines.collect { | (project, start_at) | TimeCalc::Activity.new(project, start_at)}
summary = TimeCalc::Activity.summarize(activities)
summary.keys.sort.each { | k | puts "#{k}:\t#{seconds_to_hhmm(summary[k])}"}
