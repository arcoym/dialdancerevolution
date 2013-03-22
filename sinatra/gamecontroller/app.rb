#!/usr/bin/ruby

require 'rubygems'
require 'sinatra'

require '../../asterisk_agi/gameinit'


get '/' do
  erb :index
end

get '/all' do
	calls = Call.all
	a = []
	calls.each do |call| 
		x = [call.id]
		call.keypresses.each do |kp|
			x << kp.value
		end
		a << x.join(",") 
	end
	a.join ("\n")
end

# get '/allpresses' do
# 	kps = Keypress.all
# 	kp_string = []
# 	kps.each do |kp|
# 		kp_string << kp.value 
# 	end
# 	kp_string.join(",")
# end


get '/unplayedpresses' do
	kps = Keypress.all(:happened => false)
	kp_string = []
	kps.each do |kp|
		kp_string << kp.value 
		kp.update(:happened => true)
	end
	kp_string.join(",")
end


__END__
