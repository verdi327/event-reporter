require 'csv'

class Queue
  HEADERS = ["last_name", "first_name", "email_address",
            "zipcode", "city", "state", "street", 'homephone']

  attr_accessor :queue

  def initialize
    self.queue = []
  end

  def call(params)
    "Running 'Queue "  + "#{params[0..1].join(' ').capitalize}'"
    case params[0..1].join(" ")
      when "count" then count(self.queue)
      when "clear" then clear(queue)
      when "print" then print(queue)
      when "print by" then print_by(queue, params[-1])
      when "save to" then save_to(queue, params[-1])
    end
  end

  def count(queue)
    "There are #{queue.size unless queue == ""} attendee records in your Queue."
  end

  def clear(queue)
    if queue.any?
      empty_queue = queue.clear
      "Queue cleared. There are #{empty_queue.size} attendee records left."
    else
      "Queue is already empty"
    end
  end

  def print(queue)
    if queue.any?
      output = queue.map do |attendee|
        [attendee.last_name, attendee.first_name,
        attendee.email_address, attendee.zipcode,
        attendee.city, attendee.state, attendee.address,
        attendee.phone_number].join("\t\t") + "\n"
      end
      puts output.unshift(HEADERS.join("\t\t") + "\n")
      "Here are all the attendee records in your Queue"
    else
      "Nothing to print"
    end
  end

  def print_by(queue, attribute)
    if !queue.any?
      "Nothing in the Queue"
    else
      output = queue.sort_by do |attendee|
        attendee.send(attribute)
      end
      puts "Sorting by #{attribute}"
      print output
      "Here are all the attendee records sorted by #{attribute}"
    end
  end

  def save_to(queue, filename)
    if queue.any?
      CSV.open(filename, "w") do |csv|
        csv << HEADERS
        queue.each do |attendee|
          csv << [attendee.last_name, attendee.first_name,
                  attendee.email_address, attendee.zipcode,
                  attendee.city, attendee.state, attendee.address,
                  attendee.phone_number]
          end
          "The attendee records have been saved to file name '#{filename}'"
        end
    else
      HEADERS.join(", ")
    end
  end

  def self.valid_parameters?(params)
    if !%w(count clear print save).include?(params[0])
      false
    elsif params[0] == "print"
      params.count == 1 || (params[1] == "by" && params.count == 3 )
    elsif params[0] == "save"
      params[1] == "to" && params.count == 3
    else
      true
    end
  end
end

