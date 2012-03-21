require './queue'

describe Queue do
  describe "#clear" do
    context "when checking the contents of the queue variable" do
      it "empties the queue of all of its elements" do
        queue = Queue.new
        que = queue.queue
        que = %w[dog cat fish]
        queue.clear(que)
        que.should == []
      end
    end
  end
end