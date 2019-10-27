{
    _id: "shows",
    slide: true,
    title: "Show functions",
    order: 3,
    content: <<~END,
        <p>
            Show functions process a single document and return a result (e.g. JSON, HTML).
        </p>

        <div class="column">
            <h2>
                Example: slide JSON
            </h2>

            <p>
                Each slide is stored in its own CouchDB document named by its path (e.g. "shows").
            </p>

            <p>
                Some of document fields hold content to render, but others are for internal use, like menu order.
            </p>

            <p>
                In a more real-world case, there might be sensitive fields that need to stay private.
            </p>

            <p>
                So instead of directly querying the document, we ask CouchDB to "show" it:
            </p>

        <pre>
        GET /presentation/_design/loose_change/_show/slide/intro
        </pre>

            <div class="subcolumn">
                <h3>
                    Document as stored
                </h3>
        <pre>
        {
            "_id": "intro",
            "_rev": "1-2a9ef6e68db72f37a...",
            "slide": true,
            "title": "Introduction",
            "order": 1,
            "content": "&lt;p&gt;CouchDB in 60...",
            "links": [
                [
                    "CouchDB",
                    "http://couchdb.apache.org"
                ],
                [
                    "CouchDB documentation",
                    "http://docs.couchdb.org/"
                ]
            ]
        }
        </pre>
            </div>

            <div class="subcolumn">
                <h3>
                    CouchDB Show function
                </h3>
        <pre>
        function (doc, req) {
            var slide = {
                "title": null,
                "content": null,
                "links": null
            };
            title = content = links = null;
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
        </div>

        <div class="column">
            <p>
                The Web app receives only the information it needs.
            </p>
            <div class="subcolumn">
                <h3>
                    CouchDB's reply to Web app
                </h3>
        <pre>
        {
          "title": "Introduction",
          "content": "&lt;p&gt;&lt;em&gt;Presenter...",
          "links": [
            [
              "CouchDB",
              "http://couchdb.apache.org"
            ],
            [
              "CouchDB documentation",
              "http://docs.couchdb.org/"
            ]
          ]
        }
        </pre>
            </div>

            <div class="subcolumn">
                <h3>
                    Web app template
                </h3>
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
                    &lt;%= doc["content"] %&gt;
                &lt;% end %&gt;

                &lt;%= links %&gt;
            &lt;% end %&gt;
        &lt;/article&gt;
        </pre>
            </div>
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
