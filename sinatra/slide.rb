def show_slide(docid)
    doc = get_doc(docid)
    links = get_links(docid)

    navbar = navigation()

    template = ERB.new IO.read('slide.erb')
    template.result(binding)
end

def get_doc(docid)
    uri = URI::HTTP.build(
        host: DB_HOST,
        port: DB_PORT,
        path: '/' + DB_DBNAME + '/_design/loose_change/_show/slide/' + docid
    )
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
        JSON.parse(response.body)
    else
        halt response.code
    end
rescue Exception => e
    e.message
end

def get_links(docid)
    uri = URI::HTTP.build(
        host: DB_HOST,
        port: DB_PORT,
        path: '/' + DB_DBNAME + '/_design/loose_change/_show/links/' + docid
    )
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
        response.body
    else
        "Error retrieving links: " + response.body
    end
rescue Exception => e
    e.message
end

