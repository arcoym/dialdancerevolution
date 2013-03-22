#!/usr/bin/ruby

require 'rubygems'
require 'ruby-agi'

require 'data_mapper'
require 'dm-mysql-adapter'

DataMapper.setup(:default, {
 :adapter => 'mysql',
 :host => 'localhost',
 :username => 'xxxxxx' ,
 :password => 'xxxxxx',
 :database => 'arc507'})

class Keypress
        include DataMapper::Resource
        property :id, Serial
        property :value, String
        property :created_at, DateTime
        property :keypress, String
        property :happened, Boolean, :default => false        
        
        belongs_to :call
        #If this object is turned into a string, return the keypress value
        def to_s
                value
        end
end

class Call
  include DataMapper::Resource

  property :id, Serial # An auto-increment integer key
#   property :caller_id, String # A varchar type string, for short strings
  property :created_at, DateTime # A DateTime, for any date you might like.
  has n, :keypresses
end

# Finish setup
DataMapper.finalize
DataMapper.auto_upgrade!


agi = AGI.new #new agi object

# start agi scripting
agi.stream_file("vm-extension")

call = Call.create # save phone number if you want it.

while true
	result = agi.wait_for_digit(-1) # wait forever
	
	if result.digit
#		agi.say_number(result.digit)
# 		call.keypresses << Keypress.create(:value => result.digit)
# 		call.save

		Keypress.create(:value => result.digit, :call_id => call.id)
	end
end

