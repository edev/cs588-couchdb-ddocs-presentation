require 'json'
require 'net/http'

DB_HOST = 'couchdb'
DB_PORT = 5984
DB_DBNAME = '/presentation'
DOCS_DIR = './docs'
DDOCS_DIR = './ddocs'

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
                    path: DB_DBNAME
                )

                # Send the PUT request to create the corresponding document
                request = Net::HTTP::Post.new(uri)
                request['Content-Type'] = 'application/json'
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

puts "Hello"
loop do
    begin
        STDOUT.puts "Checking if CouchDB is up yet..."
        STDOUT.flush
        Net::HTTP.get(URI::HTTP.build(host: DB_HOST, port: DB_PORT, path: '/'))
        break
    rescue
        sleep(1)
    end
end

STDOUT.puts "CouchDB is up!"
STDOUT.flush
STDOUT.puts create_databases
STDOUT.flush
STDOUT.puts load_docs
STDOUT.flush
STDOUT.puts load_ddocs
STDOUT.flush

