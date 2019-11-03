{
    _id: "filters",
    slide: true,
    order: 5,
    title: "Filter functions",
    content: <<~END,
        <p>
            You may have noticed that setting "watch" to true doesn't actually do much.
        </p>

        <p>
            What we need is a rolling feed of database changes that we can query.
        </p>

        <p>
            Fortunately, CouchDB provides just that:
        </p>

        <div id="column">
            <h3>
                The changes feed
            </h3>

        <pre>
        GET /presentation/_changes

        {
          "results": [
            {
              "seq": "1-g1AA...",
              "id": "updates",
              "changes": [
                {
                  "rev": "1-310f...",
                }
              ]
            },
            ...
            {
              "seq": "8-g1AA...",
              "id": "filters",
              "changes": [
                {
                  "rev": "1-657f...",
                }
              ]
            }
          ],
          "last_seq": "8-g1AA...",
          "pending": 0
        }
        </pre>
        </div>

        <div class="column">
            <h2>
                Example: show only changes to watched documents
            </h2>

            <p>
                CouchDB provides filter functions for use cases just like ours.
            </p>

            <p>
                A filter function checks each document in a changes feed against any logic we provide.
            </p>

            <p>
                When we query a filter, CouchDB only shows us changes for which the filter returns true.
            </p>

            <p>
                A trivial filter function that checks "watch" generates the changes feed we're looking for:
            </p>

        <pre>
        GET  /presentation/_changes<span class="highlight-code">?filter=loose_change/watch</span>
        </pre>
                
            <div class="subcolumn">
                <h3>
                    Filter function
                </h3>

        <pre>
        function (doc, req) {
            if (doc.watch && doc.watch == true) {
                return true
            }
            return false
        }
        </pre>
        
            </div>

            <div class="subcolumn">
                <h3>
                    Filtered changes feed
                </h3>

        <pre>
        {
          "results": [
            {
              "seq": "7-g1AA..."
              "id": "_design/loose_change",
              "changes": [
                {
                  "rev": "2-59fd..."
                }
              ]
            }
          ],
          "last_seq": "8-g1AA..."
          "pending": 0
        }
        </pre>

            </div>


    END
    links: 
    [
        [
            "Design Documents: Update Functions",
            "http://docs.couchdb.org/en/stable/ddocs/ddocs.html#update-functions"
        ],
        [
            "API Reference: Filter Functions",
            "http://docs.couchdb.org/en/stable/api/ddoc/render.html#db-design-design-doc-update-update-name-doc-id"
        ]
    ]
}



