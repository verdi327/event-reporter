require './attendee'
require 'csv'

class EventDataParser
  CSV_OPTIONS = {:headers => true, :header_converters => :symbol}

  def self.load(file)
    file = ["event_attendees.csv"] if file == []
    puts "Loading the data from #{file}!"
    load_file = CSV.open(file[0], CSV_OPTIONS)
    attendees = load_file.collect { |line| Attendee.new(line) }
  end

  def self.valid_parameters?(parameters)
    parameters[0] =~ /\.csv$/ || parameters[0].nil?
  end
end


