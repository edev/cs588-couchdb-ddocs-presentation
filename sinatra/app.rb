#!/usr/bin/env ruby

DB_HOST = 'couchdb'
DB_PORT = 5984
DB_DBNAME = '/presentation'
PAGES_DIR = './pages'

require 'sinatra'
require 'net/http'
require 'json'

configure do
    set :bind, '0.0.0.0'
end

def create_databases()
    success = true
    begin
        events = "Creating databases....\n"
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
            events += "\t#{db_name}: #{response.code} #{response.msg}\n"
            if response.code.to_i < 200 || response.code.to_i > 299
                success = false
            end
        end
    rescue Exception => e
        events += e.message + '\n'
        success = false
    end
    return success, events
end

def load_slides()
    success = true
    events = "Loading slides....\n"
    begin
        Dir.each_child(PAGES_DIR) do |f|
            events += "\t#{f}: "
            filepath = File.join(PAGES_DIR, f)
            if f.end_with?(".rb") && File.exists?(filepath) && !File.directory?(filepath)
                # Read the file into a Ruby hash (incredibly unsafe, obviously) and convert to JSON
                hash = eval(IO.read(filepath))
                json = JSON.generate(hash)
                
                uri = URI::HTTP.build(
                    host: DB_HOST,
                    port: DB_PORT,
                    path: DB_DBNAME
                )

                # Send the POST request to create the corresponding document
                response = Net::HTTP.post(
                    uri,
                    json,
                    'Content-Type': 'application/json'
                )

                # Record the result.
                events += "#{response.code} #{response.message}\n"
                if response.code.to_i < 200 || response.code.to_i > 299
                    success = false
                end
            end
        end
    rescue Exception => e
        events += e.message + "\n"
        success = false
    end
    return success, events
end

$first_run = true
get '/' do
    if $first_run == true
        $first_run = false

        # Send a temporary redirect to run first-run code, e.g. to create databsaes.
        redirect "/first_run", 307
    end

    # Net::HTTP.get(DB_HOST, '/', DB_PORT)
    "Welcome!"
end

get '/first_run' do
    headers "Content-Type" => "text/plain"
    response = ""
    success = true

    db_success, db_response = create_databases
    success &= db_success
    response += db_response

    slide_success, slide_response = load_slides
    success &= slide_success
    response += slide_response

    if success
        redirect '/', 301
    else
        response
    end
end
