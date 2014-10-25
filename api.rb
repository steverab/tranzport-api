require 'sinatra'

before do
  content_type 'text/plain'
end

get '/' do
  "Welcome to the Tranzit API!"
end
