class Help

  def self.for(parameters)
    attribute = parameters[0..-1].join(" ")
    if Command::ALL_COMMANDS.keys.include?(attribute)
      "#{attribute}: #{Command::ALL_COMMANDS[attribute]}"
    elsif attribute.length == 0
      puts "Available Commands"
      "#{Command::ALL_COMMANDS.keys}"
    end
  end

  def self.valid_parameters?(parameters)
    parameters.empty? || Command.valid?(parameters.join(" "))
  end
end