require './event_parser'
require './help'
require './queue'
require './search'

class Command
ALL_COMMANDS = {"load" => "loads a new file",
                    "help" => "shows a list of available commands",
                    "queue" => "a set of data",
                    "queue count" => "total items in the queue",
                    "queue clear" => "empties the queue",
                    "queue print" => "prints to the queue",
                    "queue print by" => "prints the specified attribute",
                    "queue save to" => "exports queue to a CSV",
                    "find" => "load the queue with matching records"}

  attr_accessor :queue, :base_data

  def initialize
    self.queue = Queue.new
  end

  def self.valid?(command)
    ALL_COMMANDS.keys.include?(command)
  end

  def execute(command, parameters)
    if command == "load" && EventDataParser.valid_parameters?(parameters)
      self.base_data = EventDataParser.load(parameters)
      "Loaded #{base_data.count} attendees."
    elsif command == "queue" && Queue.valid_parameters?(parameters)
      queue.call(parameters)
    elsif command == "help" && Help.valid_parameters?(parameters)
      Help.for(parameters)
    elsif command == "find" && Search.valid_parameters?(parameters)
      queue.queue = Search.for(parameters, base_data)
     else
      error_message_for(command)
    end
  end

  def error_message_for(command)
    "Sorry, '#{command}' is not a valid command, maybe pray for it in the next release? Run 'help' for available commands"
  end
end


