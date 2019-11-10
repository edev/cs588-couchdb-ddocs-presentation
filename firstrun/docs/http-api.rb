{
    _id: "http-api",
    slide: true,
    order: 3,
    title: "HTTP API",
    content: <<~END,
    <p>
        We interact with CouchDB through HTTP requests. 
    </p>

    <p>
        For instance, to retrieve our "what-is-a-document" slide from the "presentation" database:
    </p>

    <pre>
    GET /presentation/what-is-a-document
    </pre>

    <p>
        We get back the document we saw in the previous slide:
    </p>

    <pre>
    {
        "_id": "what-is-a-document",                      <span class="comment">(Document key)</span>
        "_rev": "1-da2bf1224f45b1d4560dd8e062f936c8",     <span class="comment">(Document revision)</span>
        "slide": true,                                    <span class="comment">(Flags document as a slide)</span>
        "order": 2,                                       <span class="comment">(Order in the menu)</span>
        "title": "What is a document?",                   <span class="comment">(Title of slide)</span>
        "content": "&lt;p&gt;\\\\n    A document is simply...",   <span class="comment">(Body content)</span>
        "links":
        [
            [
                "CouchDB",
                "http://couchdb.apache.org"               <span class="comment">(Link to reference material)</span>
            ],
            [
                "CouchDB documentation",
                "http://docs.couchdb.org/"                <span class="comment">(Link to reference material)</span>

            ]
        ]
    }
    </pre>

    We can easily send GET requests through the browser, so let's try it.

    END
}

