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

