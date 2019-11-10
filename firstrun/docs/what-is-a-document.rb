{
    _id: "what-is-a-document",
    slide: true,
    order: 2,
    title: "What is a document?",
    content: <<~END,
    <p>
        A document is simply a JSON object associated with a key.
    </p>

    <p>
        The key is the official name of the document; it's how we look the document up in the database.
    </p>

    <p>
        This presentation is actually stored in CouchDB, so let's take a look at the document that stores this slide.
    </p>

    <div clss="column">
        <h2>
            Example: this slide
        </h2>

    <pre>
    {
        "_id": "what-is-a-document",                      <span class="comment">(Document key)</span>
        "_rev": "1-bb308e3c3e85bd5a17c97a3bcf8d77f6",     <span class="comment">(Document revision)</span>
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

    </div>
    END
        links:
        [
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


