task :run do
    sh 'sudo docker-compose down -v'
    sh 'sudo docker-compose build'
    sh 'sudo docker-compose up -d'
end

task :build_sinatra do
    sh 'sudo docker-compose up -d --build sinatra'
end

task :build_docs do
    sh 'curl -X DELETE http://localhost:5984/_users'
    sh 'curl -X DELETE http://localhost:5984/_replicator'
    sh 'curl -X DELETE http://localhost:5984/_global_changes'
    sh 'curl -X DELETE http://localhost:5984/presentation'
    sh 'sudo docker-compose up -d --build firstrun'
end

task :stop do
    sh 'sudo docker-compose down -v'
end
