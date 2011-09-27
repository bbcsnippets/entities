require 'sinatra'
require 'json'
require 'app/models/extract'

post '/entities' do
  content_type :json
  text    = params[:text]
  extract = Extract.extract(text)
  { :entities => extract }.to_json
end

get '/extract' do
  content_type :json
  extract = Extract.extract(params[:text])
  { :entities => extract }.to_json
end