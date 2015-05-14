require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'iconv'

require './extensions/str.rb'

before do
  if ENV['RACK_ENV'] == 'production'
    error 426 unless request.secure?
  end
  content_type 'application/json', 'charset' => 'utf-8'
end

not_found do
  content_type 'text/plain'
  '404 - Not Found'
end

error 401 do
  content_type 'text/plain'
  '401 - Unauthorized'
end

error 403 do
  content_type 'text/plain'
  '403 - Forbidden'
end

error 426 do
  content_type 'text/plain'
  '426 - Upgrade Required'
end

get '/' do
  content_type 'text/plain'
  "Welcome to the Tranzport API!"
end

get '/departures' do
  # Convert departure station from UTF-8 to Latin-1
  convDep = Iconv.conv('iso-8859-1', 'utf-8', params['station'])

  # URL-encode the converted departure station
  param = CGI::escape(convDep)

  # Read mobile MVG departure website
  page = Nokogiri::HTML(open("http://www.mvg-live.de/ims/dfiStaticAnzeige.svc?haltestelle=#{param}&ubahn=checked&bus=checked&tram=checked&sbahn=checked"))

  # Create departure array
  resp = []
  page.search('//span').remove
  page.xpath('//tr[starts-with(@class,"row")]').each do |departure|
    line = departure.css('td.lineColumn')[0].text
    destination = departure.css('td.stationColumn')[0].text
    destination = destination.strip_control_characters
    minutes = departure.css('td.inMinColumn')[0].text.to_i
    resp << {:line => "#{line}", :destination => "#{destination}", :minutes => minutes}
  end

  resp.sort! {|a, b|  a[:minutes] <=> b[:minutes]}

  # Return JSON formatted dictionary
  resp.to_json
end
