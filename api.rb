require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'iconv'

require './extensions/str.rb'

before do
    content_type 'application/json', 'charset' => 'utf-8'
end

get '/' do
    content_type 'text/plain'
    "Welcome to the Tranzit API!"
end

get '/departures/:stationName' do
    # Convert departure station from UTF-8 to Latin-1
    convDep = Iconv.conv('iso-8859-1', 'utf-8', params[:stationName])
    
    # URL-encode the converted departure station
    param = CGI::escape(convDep)
    
    # Read mobile MVG departure website
    page = Nokogiri::HTML(open("http://www.mvg-live.de/ims/dfiStaticAnzeige.svc?haltestelle=#{param}&ubahn=checked&bus=checked&tram=checked&sbahn=checked"))
    
    # Create departure dictionary
    resp = []
    page.search('//span').remove
    page.xpath('//tr[starts-with(@class,"row")]').each do |departure|
        line = departure.css('td.lineColumn')[0].text
        destination = departure.css('td.stationColumn')[0].text
        destination = destination.strip_control_characters
        minutes = departure.css('td.inMinColumn')[0].text
        resp << {:line => "#{line}", :destination => "#{destination}", :minutes => "#{minutes}"}
    end
    
    # Return JSON formatted dictionary
    resp.to_json
end