{
    _id: "updates",
    slide: true,
    order: 4,
    title: "Update functions",
    content: <<~END,
        <p>
            Update functions let us run server-side logic to update documents in arbitrary ways.
        </p>

        <div class="column">
            <h2>
                Example: Flagging documents
            </h2>

            <p>
                We might want to keep a close eye on certain documents and be alerted of any changes.
            </p>
                
            <p>
                To facilitate this, we can create an update function that flags documents.
            </p>

            <p>
                Once we create the function, we can call it on our design document to flag it:
            </p>

        <pre>
        POST /presentation/_design/loose_change/_update/<span class="highlight-code">watch</span>/<span class="highlight-code">_design/loose_change</span>
        </pre>

            <div class="subcolumn">
                <h3>
                    Update function
                </h3>

        <pre>
            function (doc, req) {
                if (!doc) {
                    return [
                        null,
                        {
                            'code': 400,
                            'json': {
                                'error': 'missed',
                                'reason': 'no doc'
                            }
                        }
                    ]
                }
                <span class="highlight-code">doc.watch = true;</span>
                return [
                    doc, 
                    {
                        'code': 201,
                        'json': {
                            'status': 'Updated'
                        }
                    }
                ]
            }
        </pre>
            </div>

            <div class="subcolumn">
                <h3>
                    Document after update
                </h3>

        <pre>
        {
            "_id": "_design/loose_change",
            "_rev": "2-e2b5...",
            "filters": {
                "watch": "function...",
              ...
            },
            ...
            <span class="highlight-code">"watch": true</span>
        }
        </pre>
            </div>
        </div>
    END
    links: 
    [
        [
            "Design Documents: Update Functions",
            "http://docs.couchdb.org/en/stable/ddocs/ddocs.html#update-functions"
        ],
        [
            "API Reference: Update Functions",
            "http://docs.couchdb.org/en/stable/api/ddoc/render.html#db-design-design-doc-update-update-name-doc-id"
        ]
    ]
}



