require 'sinatra'

ENV['JAVA_HOME'] = "/usr/lib/jvm/java-6-sun"

require 'app.rb'

run Sinatra::Application