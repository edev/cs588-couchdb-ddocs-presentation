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
require 'redcarpet'

configure do
    set :bind, '0.0.0.0'
end

##
# Attempts an operation, safely catching any exceptions.
#
# Expects a block that returns [success, log]. Said block should use the << operator to append to the log and return
# success=true or success=false depending on the outcome of the operation. Any exceptions will automatically return
# success=false.
def try_operation(&block)
    log = ""
    begin
        yield(log)
    rescue Exception => e
        log << e.message + '\n'
        success = false
        return success, log
    end
end

def create_databases()
    try_operation do |log|
        success = true
        log << "Creating databases\n"
        dbs_to_create = [
            "_users",
            "_replicator",
            "_global_changes",
            "presentation"
        ]
        dbs_to_create.each do |db_name|
            uri = URI::HTTP.build(
                host: DB_HOST,
                port: DB_PORT,
                path: '/' + db_name
            )
            request = Net::HTTP::Put.new(uri)
            response = Net::HTTP.start(uri.hostname, uri.port, {}) do |http|
                http.request(request)
            end
            log << "\t#{db_name}: #{response.code} #{response.msg}\n"
            if response.code.to_i < 200 || response.code.to_i > 299
                success = false
            end
        end
        return success, log
    end
end

##
# Parses each Ruby file in dir to JSON and PUTs it to the database.
def put_docs(dir)
    try_operation do |log|
        success = true
        log << "Loading documents in #{dir}\n"
        Dir.each_child(dir) do |f|
            log << "\t#{f}: "
            filepath = File.join(dir, f)
            if f.end_with?(".rb") && File.exists?(filepath) && !File.directory?(filepath)
                # Read the file into a Ruby hash (incredibly unsafe, obviously) and convert to JSON
                hash = eval(IO.read(filepath))
                json = JSON.generate(hash)
                
                uri = URI::HTTP.build(
                    host: DB_HOST,
                    port: DB_PORT,
                    path: DB_DBNAME + '/' + hash[:_id]
                )

                # Send the PUT request to create the corresponding document
                request = Net::HTTP::Put.new(uri)
                response = Net::HTTP.start(uri.hostname, uri.port, {}) do |http|
                    http.request(request, json)
                end

                # Record the result.
                log << "#{response.code} #{response.message}\n"
                if response.code.to_i < 200 || response.code.to_i > 299
                    success = false
                end
            end
        end
        return success, log
    end
end

def load_docs()
    put_docs(DOCS_DIR)
end

def load_ddocs()
    put_docs(DDOCS_DIR)
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

    [
        :create_databases,
        :load_docs,
        :load_ddocs
    ].each do |meth|
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

$first_run = true
def show_slide(docid)
    if $first_run == true

        # Send a temporary redirect to run first-run code, e.g. to create databsaes.
        redirect "/first_run", 307
    end

    doc = get_doc(docid)

    navbar = navigation()


    markdown_renderer = Redcarpet::Render::HTML.new(render_options = {})
    markdown = Redcarpet::Markdown.new(markdown_renderer, extensions = {})

    template = ERB.new IO.read('slide.erb')
    template.result(binding)
end

def get_doc(docid)
    uri = URI::HTTP.build(
        host: DB_HOST,
        port: DB_PORT,
        path: '/' + DB_DBNAME + '/' + docid
    )
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
        return JSON.parse(response.body)
    else
        halt response.code
    end
rescue Exception => e
    return e.message
end
