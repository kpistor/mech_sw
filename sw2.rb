# required gems
require 'rubygems'
require 'bundler/setup'
require 'mechanize'

# load params file
config_file = './params.rb'
require config_file 

$i = 0

while $i < 13 do

  agent = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'}
  #agent = Mechanize.new 

  prompt = false  #boolean for fail trigger 
  	
  page = agent.get('http://www.southwest.com/flight/retrieveCheckinDoc.html')

  ## FILL IN CHECK-IN FORM ##

  checkin_info = page.form('retrieveItinerary') #declare variable for from

  checkin_info.confirmationNumber = CONFIRMATION_NUMBER
  checkin_info.firstName = FIRST_NAME
  checkin_info.lastName = LAST_NAME

  checkin_page = checkin_info.submit #submit

  error = (checkin_page / 'div#error_wrapper').first

  if checkin_page.uri == URI('http://www.southwest.com/flight/retrieveCheckinDoc.html')
    puts if prompt
    puts "Script could not check in."
    puts error.content
    
    if $i == 12
      $error = error.content
      $status = "Script could not check in - :("
      $i += 2
      puts 'error'

    else 
      $i += 1
      sleep(2)
    end

  elsif checkin_page.uri != URI('http://www.southwest.com/flight/retrieveCheckinDoc.html')
    checkin_form = checkin_page.form_with(:name => 'checkinOptions')
    checkin_form.checkboxes.each { |box|  box.check }
    print_button = checkin_form.buttons.detect { |b|  b.name == 'printDocuments' }
    boarding_page = checkin_form.click_button(print_button)
    $i += 14

    puts if prompt
    puts "Successfully checked in, got"
     
    boarding_passes = boarding_page / 'div.details'
    boarding_passes.each do |pass|
      boarding_name = (pass / 'p.name span').collect { |x|  x.content }.join(' ')
      boarding_info = pass / 'div.boardingPosition img'
      boarding_position = boarding_info.collect { |x| x.attributes['src'].to_s.match(/(\w).gif$/)[1] }.join
      
      $error = 'No errors!'
      $status = 'Script was successful!'
      $bn = boarding_name
      $bp = boarding_position
      $bi = boarding_info

      puts "#{boarding_name} - #{boarding_position}"
      end

  else

    if $i == 12
      $error = error.content
      $status = "Script could not check in - (unknown erorr)"
      $i += 2
      puts 'error'

    else 
      $i += 1
      sleep(2)
    end

  end

end












