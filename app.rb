require 'sinatra'
require 'json'
require 'app/models/extract'

post '/extract' do
  content_type :json
  text    = request.env["rack.input"].read(request.content_length.to_i)
  request.env["rack.input"].close
  text
  # extract = Extract.extract(text)
  #{ :entities => extract }.to_json
end

get '/extract' do
  content_type :json
  extract = Extract.extract(params[:text])
  { :entities => extract }.to_json
end