require './attendee'

describe Zipcode do
  describe ".clean" do
    context "when zipcode is less than 5 digits" do
      %w[0 00 000 0000].each do |input|
        it "adds zeros to the font of input #{input}" do
          Zipcode.clean(input).should == "00000"
        end
      end
    end
  end
end

describe PhoneNumber do
  describe "#initialize" do
    context "when phone number contains non-digits" do
      ["123-456-7890", "123.456.7890", "123 456 7890", "(123) 456 7890"].each do |number|
        it "removes non-digit characters from number #{number}" do
          PhoneNumber.new(number).to_s.should == "1234567890"
        end
      end
    end
  end
end





