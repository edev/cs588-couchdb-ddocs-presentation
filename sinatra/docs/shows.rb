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
                Example 1: slide JSON
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
            GET http://couchdb:5984/presentation/_design/loose_change/_show/slide/intro
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
        </div>

        <div class="column">
            <p>
                The Web app receives exactly the information it needs, formatted ideally for display.
            </p>
            <div class="subcolumn">
                <h3>
                    CouchDB's reply to Web app
                </h3>
                <pre>
        {
            "uri": "intro",
            "title": "Introduction",
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
        };
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

        <div class="column" style="clear:both">
            <h2>
                Example 2: show "Links" (as HTML)
            </h2>
            <p>
                Using a template library is almost always a good idea, but CouchDB <em>does</em> support HTML<br />
                output through Show functions as well. Here's an example that's clearly a bad idea:
            </p>
            <pre>
        function (doc, req) {
            var response = "";
            if (doc.links) {
                response += '&lt;div id="links"&gt;\\n&lt;h2&gt;\\nLinks\\n&lt;/h2&gt;\\n&lt;ul&gt;\\n';
                doc.links.forEach(function(elem) {
                    /* Loop through [title, uri] pairs, generating HTML links. */
                    response += '&lt;li&gt;\\n&lt;a href="' + elem[1] + '"&gt;' + elem[0] + '&lt;/a&gt;\\n&lt;/li&gt;\\n';
                });
                response += '&lt;/ul&gt;\\n&lt;/div&gt;\\n';
            }
            return response;
        }
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