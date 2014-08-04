require "event_attributes/version"

class EventAttributes
  attr_reader :params
  
  def initialize(params)
    @params = params
    @with_local_time = false
  end
  
  def with_local_time
    @with_local_time = true
    self
  end
  
  def with_local_time?
    @with_local_time
  end
  
  def attributes
    attributes = params.dup
    normalize_date_and_time_for_attribute!(attributes, :start)
    normalize_date_and_time_for_attribute!(attributes, :end)
    attributes
  end
  
  def to_h
    attributes
  end
  
private
  
  def normalize_date_and_time_for_attribute!(attributes, attribute)
    date = parse_date attributes.delete(:"#{attribute}_date")
    time = parse_time attributes.delete(:"#{attribute}_time")
    attributes[:"#{attribute}s_at"] = temp = from_date_and_time(date, time) if date
    attributes
  end
  
  def parse_date(date)
    return date unless date.is_a?(String)
    Date.parse(date)
  rescue ArgumentError
    nil
  end
  
  def parse_time(time)
    return time unless time.is_a?(String)
    Time.parse(time.strip.gsub(/(a|p)$/, '\1m'))
  rescue ArgumentError
    nil
  end
  
  def from_date_and_time(date, time)
    args = [date.year, date.month, date.day]
    args.concat [time.hour, time.min] if time
    return Time.zone.local *args if with_local_time?
    Time.utc *args
  end
  
end
