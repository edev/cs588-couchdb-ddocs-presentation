{
    _id: "shows",
    slide: true,
    order: 5,
    title: "Show functions",
    content: <<~END,
        <p>
            Show functions process a single document and return a result (e.g. JSON, HTML).
        </p>

        <div class="column">
            <h2>
                Example: slide JSON
            </h2>

            <p>
                As we know, each slide is stored in its own CouchDB document named by its path (e.g. "shows").
            </p>

            <p>
                Some document fields hold content to render, but others are for internal use, like menu order.
            </p>

            <p>
                In a more real-world case, there might also be sensitive fields that need to stay private.
            </p>

            <p>
                So instead of directly querying the document, we ask CouchDB to "show" it:
            </p>

        <pre>
        GET /presentation/_design/loose_change/_show/<span class="highlight-code">slide</span>/<span class="highlight-code">what-is-couchdb</span>
        </pre>

            <div class="subcolumn">
                <h3>
                    Document as stored
                </h3>
        <pre>
        {
            "_id": "what-is-couchdb",
            "_rev": "1-4c2171884a1e05c5846...",
            "slide": true,
            "order": 1,
            "title": "What is CouchDB?",
            "content": "&lt;p&gt;\\n    Next week...",
            "links": [
                [
                    "CouchDB homepage",
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
                        <span class="highlight-code">&lt;%= doc["title"] %&gt;</span>
                    &lt;/h1&gt;
                &lt;% end %&gt;

                &lt;% if doc.has_key? "content" %&gt;
                    <span class="highlight-code">&lt;%= doc["content"] %&gt;</span>
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
            "API Reference: Show Functions",
            "http://docs.couchdb.org/en/stable/api/ddoc/render.html#db-design-design-doc-show-show-name-doc-id"
        ]
    ]
}
