module ApplicationHelper
  def timestamp_readable(timestamp)
    "#{Date::MONTHNAMES[timestamp.month]} #{timestamp.mday}#{(", " + timestamp.year unless timestamp.year == Date.today.year)}"
  end
  
  def timestamp_readable_with_time(timestamp)
        "#{Date::MONTHNAMES[timestamp.month] + " "+ timestamp.mday unless timestamp.to_date == Date.today }#{(", " + timestamp.year unless timestamp.year == Date.today.year)}, #{timestamp.hour}:#{timestamp.min}"
  end
end
