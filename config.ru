require 'sinatra'

ENV['JAVA_HOME'] = "/usr/lib/jvm/java-1.6.0-openjdk/"

require 'app.rb'

run Sinatra::Application