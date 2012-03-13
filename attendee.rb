require 'ostruct'

class Zipcode
  def self.clean(dirty_zipcode)
    dirty_zipcode.to_s.rjust(5, '0')
  end
end

class PhoneNumber
INVALID_NUMBER = "0000000000"

  def initialize(phone_number)
    @phone_number = phone_number.delete("(.)' '-")
    if @phone_number.size == 10
      @phone_number
    elsif @phone_number.size == 11
      if @phone_number.start_with? ("1")
        @phone_number = @phone_number[1..-1]
      else
        @phone_number = INVALID_NUMBER
      end
    else
      @phone_number = INVALID_NUMBER
    end
  end

  def to_s
    @phone_number
  end
end

class Attendee < OpenStruct

  def initialize(attributes)
    # Clean the attributes data?
    super
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def zipcode
    Zipcode.clean(super)
  end

  def phone_number
    PhoneNumber.new(homephone)
  end

end

