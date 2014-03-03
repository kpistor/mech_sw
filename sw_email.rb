	
require 'rubygems'
require 'bundler/setup'
require 'gmail'


## require subscripts##
config_file = './sw2.rb'
require config_file 

## SEND EMAIL of STATUS ## 
Gmail.new('ktpistor', 'tri31.93') do |gmail| #Authenticate into gmail

#send email
gmail.deliver do
  to EMAIL  #pull delivery address from params.rb 
  subject "KP's SW Checkin App" #subject

  #body of the email
  text_part do
  	body  "AUTOMATED MESSAGE:\n\nStatus - #{$status}\nError - #{$error}\nName - #{$bn}\nBoarding Position - #{$bp}" 
  	#body  "AUTOMATED MESSAGE:" 
  end
end
  puts $status
end


