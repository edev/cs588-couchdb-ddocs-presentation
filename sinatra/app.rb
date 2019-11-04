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
    show_slide('intro')
end

get '/:docid' do
    show_slide params[:docid]
end

