require 'csv'

class Queue
  HEADERS = ["last_name", "first_name", "email_address", "zipcode", "city", "state", "street", 'homephone']

  attr_accessor :queue

  def initialize
    self.queue = []
  end

  def call(params)
    "Running 'Queue "  + "#{params[0..1].join(' ').capitalize}'"
    case params[0..1].join(" ")
      when "count" then count(queue)
      when "clear" then clear(queue)
      when "print" then print(queue)
      when "print by" then print_by(queue, params[-1])
      when "save to" then save_to(queue, params[-1])
    end
  end

  def count(queue)
    "There are #{queue.size} attendee records in your Queue."
  end

  def clear(queue)
    empty_queue = queue.clear
    "Your Queue is cleared. There are #{empty_queue.size} attendee records left."
  end

  def print(queue)
    output = queue.map do |attendee|
      [attendee.last_name, attendee.first_name, attendee.email_address, attendee.zipcode,
      attendee.city, attendee.state, attendee.address, attendee.phone_number].join("\t\t") + "\n"
    end
    puts output.unshift(HEADERS.join("\t\t") + "\n")
    "Here are all the attendee records in your Queue"
  end

  def print_by(queue, attribute)
    output = queue.sort_by do |attendee|
      attendee.send(attribute)
    end
    puts "Sorting by #{attribute}"
    print output
    "Here are all the attendee records sorted by #{attribute}"
  end

  def save_to(queue, filename)

    CSV.open(filename, "w") do |csv|
      csv << HEADERS
      queue.each do |attendee|
        csv << [attendee.last_name, attendee.first_name, attendee.email_address, attendee.zipcode,
                attendee.city, attendee.state, attendee.address, attendee.phone_number]
      end
    end
    "The attendee records in your Queue have been saved successfully under file name '#{filename}'"
  end

  def self.valid_parameters?(parameters)
    if !%w(count clear print save).include?(parameters[0])
      false
    elsif parameters[0] == "print"
      parameters.count == 1 || (parameters[1] == "by" && parameters.count == 3 )
    elsif parameters[0] == "save"
      parameters[1] == "to" && parameters.count == 3
    else
      true
    end
  end
end

