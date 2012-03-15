require './command'
require 'csv'

class EventReporterCLI
  EXIT_COMMANDS = ["quit", "q", "e", "exit"]

  def self.prompt_user
    printf "enter command > "
    gets.strip.split
  end

  def self.run
    puts "Welcome to the EventReporter"
    results = []
    @reporter = Command.new

    while results
      results = execute_command(prompt_user)
      puts results if results && results.is_a?(String)
    end

    puts "Goodbye!"
  end

  def self.execute_command(inputs)
    if inputs.any?
      command, parameters = parse_user_inputs(inputs)
      @reporter.execute(command, parameters) unless quitting?(command)
    else
      "No command entered."
    end
  end

   def self.parse_user_inputs(inputs)
    [ inputs.first.downcase, inputs[1..-1] ]
  end

  def self.quitting?(command)
    EXIT_COMMANDS.include?(command)
  end
end

EventReporterCLI.run