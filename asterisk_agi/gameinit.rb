require 'rubygems'
require 'data_mapper'
require 'dm-mysql-adapter'

DataMapper.setup(:default, {
 :adapter => 'mysql',
 :host => 'localhost',
 :username => 'xxxxxxx' ,
 :password => 'xxxxxxx',
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