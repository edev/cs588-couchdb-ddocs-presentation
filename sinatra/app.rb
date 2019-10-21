#!/usr/bin/env ruby

require 'sinatra'
require 'net/http'

configure do
    set :bind, '0.0.0.0'
end

get '/' do
    Net::HTTP.get('couchdb', '/', 5984)
end
