class Attendee

  attr_accessor :first_name, :last_name, :dirty_zipcode,
                :email_address, :street, :city, :state, :dirty_phone_number

  def initialize(attributes)
    self.first_name          = attributes[:first_name]
    self.last_name           = attributes[:last_name]
    self.dirty_zipcode       = attributes[:zipcode]
    self.email_address       = attributes[:email_address]
    self.street              = attributes[:street]
    self.city                = attributes[:city]
    self.state               = attributes[:state]
    self.dirty_phone_number  = attributes[:homephone]
  end

  def zipcode
    Zipcode.clean(dirty_zipcode)
  end

  def phone_number
    PhoneNumber.new(dirty_phone_number)
  end

  def address
    street
  end

end

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

