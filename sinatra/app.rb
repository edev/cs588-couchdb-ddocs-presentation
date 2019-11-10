#!/usr/bin/env ruby

DB_HOST = 'couchdb'
DB_PORT = 5984
DB_DBNAME = '/presentation'
DOCS_DIR = './docs'
DDOCS_DIR = './ddocs'

require 'sinatra'
require 'net/http'
require 'json'
require 'erb'
require_relative 'slide'

configure do
    set :bind, '0.0.0.0'
end

##
# This method requests the nav_menu list of the menu_items view and returns it.
def navigation()
    uri = URI::HTTP.build(
        host: DB_HOST,
        port: DB_PORT,
        path: '/' + DB_DBNAME + '/_design/loose_change/_list/nav_menu/menu_items'
    )
    return Net::HTTP.get(uri)
rescue Exception => e
    return e.message
end

get '/' do
    uri = URI::HTTP.build(
        host: DB_HOST,
        port: DB_PORT,
        path: '/' + DB_DBNAME + '/_design/loose_change/_view/menu_items',
        query: 'limit=1'
    )
    response = Net::HTTP.get_response(uri)
    first_slide = 
        if response.code == "200"
            JSON.parse(response.body)
        else
            "Error retrieving links: " + response.body
        end

    template = ERB.new IO.read('homepage.erb')
    template.result(binding)
end

get '/:docid.html' do
    show_slide params[:docid]
end

