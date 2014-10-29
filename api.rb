require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'

require './extensions/str.rb'

before do
    content_type 'application/json'
end

get '/' do
    content_type 'text/plain'
    "Welcome to the Tranzit API!"
end

get '/departures/:stationName' do
    page = Nokogiri::HTML(open("http://www.mvg-live.de/ims/dfiStaticAnzeige.svc?haltestelle=#{params[:stationName]}&ubahn=checked&bus=checked&tram=checked&sbahn=checked"))
    resp = []
    page.search('//span').remove
    page.xpath('//tr[starts-with(@class,"row")]').each do |departure|
        line = departure.css('td.lineColumn')[0].text
        destination = departure.css('td.stationColumn')[0].text
        destination = destination.strip_control_characters
        minutes = departure.css('td.inMinColumn')[0].text
        resp << {:line => "#{line}", :destination => "#{destination}", :minutes => "#{minutes}"}
    end
    resp.to_json
end