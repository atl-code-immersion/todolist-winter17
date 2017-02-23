class Task < ApplicationRecord

	# after_validation :datified_dl

	def datified_dl
    # In order to convert a String into a Time (or DateTime) datatype,
    # we need to move things around to reflect the structure of
    # the Time datatype.

    # First, we'll get the date in order.
    # In our String, it looks like: 07/28/2016
    # We need: 2016-07-28, so let's move things around, and replace slashes with hyphens:
    datetime_deadline = "#{self.deadline[6..9]}-#{self.deadline[0..4].gsub('/','-')}"

    # Next up is the time
    # In our String, we have something like:
    # 7:49 AM or 5:30 PM or 12:22 AM
    # but we need: 
    # 07:49:00 or 18:30:00 or 00:22:00
    # So this is gonna be tricky...

    # Here's our different situations:

    if self.deadline.length == 19 # Is hour double-digit?
      
      if ( self.deadline.include?("AM") && self.deadline[11..12] != 12 ) || ( self.deadline.include?("PM") && self.deadline[11..12] == "12" )
        # if it's between 10am and 11:59am
        # or if it's in the noon hour
        datetime_deadline += " #{self.deadline[11..12]}:#{self.deadline[13..15]}:00"
      elsif self.deadline.include?("AM") && self.deadline[11..12] == 12
        datetime_deadline += " 00:#{self.deadline[13..15]}:00"
      else
        # if it's between 10pm and 11:59pm
        datetime_deadline += " #{self.deadline[11..12].to_i + 12}:#{self.deadline[13..15]}:00"
      end

    else # Is hour single-digit? 
      
      if self.deadline.include?("PM")
      # if it's in the PM, we need to add 12
        datetime_deadline += " #{self.deadline[11].to_i + 12}:#{self.deadline[12..14]}:00"
      else
      # if it's in the AM, we need to place a 0 in front of the hour
        datetime_deadline += " 0#{self.deadline[11]}:#{self.deadline[12..14]}:00"
      end

    end

    # We finally got our String looking like Time! Huzzah!
    # Now we can convert:
    x = Time.parse(datetime_deadline)
    return x
  end
end
