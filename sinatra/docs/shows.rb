{
    _id: "shows",
    slide: true,
    title: "Show functions",
    order: 4,
    content: <<~END,
        Process a single document and return a result (e.g. HTML, JSON).

        2 examples:

        1. Get slide (JSON)
        2. Show links (HTML)

        <div class="column">
            <h2>
                CouchDB
            </h2>
            <pre>
        function (doc, req) {
            var slide = {
                "uri": null,
                "title": null,
                "content": null,
                "links": null
            };
            uri = title = content = links = null;
            if (doc._id) {
                slide.uri = doc._id;
            }
            if (doc.title) {
                slide.title = doc.title;
            }
            if (doc.content) {
                slide.content = doc.content;
            }
            if (doc.links) {
                slide.links = doc.links;
            }
            return {
                "json": slide
            };
        }
            </pre>
        </div>

        <div class="column">
            <h2>
                Web app
            </h2>
            <pre>
        &lt;article&gt;
            &lt;% if doc.respond_to? :to_str %&gt;
                &lt;h1&gt;
                    Error
                &lt;/h1&gt;
                &lt;p&gt;
                    &lt;%= doc %&gt;
                &lt;/p&gt;
            &lt;% else %&gt;
                &lt;% if doc.has_key? "title" %&gt;
                    &lt;h1&gt;
                        &lt;%= doc["title"] %&gt;
                    &lt;/h1&gt;
                &lt;% end %&gt;

                &lt;% if doc.has_key? "content" %&gt;
                    &lt;%= markdown.render(doc["content"]) %&gt;
                &lt;% end %&gt;

                &lt;%= links %&gt;
            &lt;% end %&gt;
        &lt;/article&gt;
            </pre>
        </div>
    END
    links: 
    [
        [
            "Design Documents: Show Functions",
            "http://docs.couchdb.org/en/stable/ddocs/ddocs.html#show-functions"
        ],
        [
            "API Reference",
            "http://docs.couchdb.org/en/stable/api/ddoc/render.html#db-design-design-doc-show-show-name-doc-id"
        ]
    ]
}
