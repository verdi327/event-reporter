require './command'
describe Command do
  describe "#initialize" do
    it "sets the queue to an instance of the class Queue" do
      command = Command.new
      command.queue.class.should == Queue
    end
  end

  describe ".valid" do
    context "when comparing a command to a nonexistent key in the ALL_COMMANDS hash" do
      it "returns an error message" do
        Command.valid?("test").should raise_error
      end
    end
  end

    context "when comparing a command that matches a key inside the ALL_COMMANDS hash" do
      ["load", "queue", "help", "queue  count", "queue clear", "queue print", "queue print by", "queue save to", "find"].each do |key|
        it "returns the key: #{key}'s value" do
          Command.valid?(key) == Command::ALL_COMMANDS[key]
      end
    end
  end
end


