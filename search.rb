require './attendee'
require './queue'

class Search
  PARAMS = %w[last_name  first_name  email  zipcode  city  state  address]

  def self.for(parameters, base_data)
    if base_data.nil?
      puts "Sorry, no attendees found"
      []
    else
    "Here's a search for #{parameters.join(" ")}"
    attribute = parameters[0]
    criteria = parameters[1..-1].join(" ").downcase

    matched_results = base_data.select do |attendee|
      attendee.send(attribute).to_s.downcase == criteria
    end

    "The search has successfully found #{matched_results.size} result"
    matched_results
    end
  end

  def self.valid_parameters?(parameters)
    parameters.count > 1 && PARAMS.include?(parameters[0])
  end
end