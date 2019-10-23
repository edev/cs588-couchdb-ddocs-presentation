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
require_relative 'firstrun'
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

get '/first_run' do
    headers "Content-Type" => "text/plain"
    response = ""
    success = true

    FIRST_RUN_TASKS.each do |meth|
        succ, resp = send(meth)
        success &= succ
        response << resp
    end

    if success
        $first_run = false
        redirect '/', 301
    else
        response
    end
end

get '/' do
    show_slide('intro') # TODO Change to redirect to last-viewed page
end

get '/:docid' do
    show_slide params[:docid]
end

