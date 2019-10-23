$first_run = true
def show_slide(docid)
    if $first_run == true

        # Send a temporary redirect to run first-run code, e.g. to create databsaes.
        redirect "/first_run", 307
    end

    doc = get_doc(docid)
    links = get_links(docid)

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

