{
    _id: "design_docs",
    slide: true,
    order: 4,
    title: "Design documents",
    content: <<~END,
        <p>
            "Design documents" is a terrible name. They're just containers that hold JavaScript functions.
        </p>

        <p>
            CouchDB supports six types of special functions we can define in our design documents:
        </p>

        <ol>
            <li>Show functions</li>
            <li>Update functions</li>
            <li>Filter functions</li>
            <li>Views</li>
            <li>List functions <span class="comment">(not covered here)</span></li>
            <li>Validate document update functions <span class="comment">(not covered here)</span></li>
        </ol>

        <p>
            We'll cover the first four, since they're the most interesting.
        <p>

        <div class="column">
            <h2>
                Example: the loose_change design document
            </h2>

            <p>
                The CouchDB community is full of couch jokes, so naturally, our design document will be named "loose_change". 
            </p>

            <p>
                The document itself is fairly straightforward.
            </p>
                
            <p>
                At the top level, each key is named after a function type.
            </p>

            <p>
                Nested under each function type is a function name and definition.
            </p>

    <pre>
    {
        "_id": "_design/loose_change",                     <span class="comment">(Document key)</span>
        "_rev": "1-f55cf4410e2a314bc2fcdecb7bde89e3",
        "<span class="highlight-code">filters</span>": {
            "<span class="highlight-code">watch</span>": "function (doc, req) {\\n..."          <span class="comment">(Filter function named "watch")</span>
        },
        "<span class="highlight-code">shows</span>": {
            "<span class="highlight-code">slide</span>": "function (doc, req) {\\n...",         <span class="comment">(Show function named "slide")</span>
            "<span class="highlight-code">links</span>": "function (doc, req) {\\n..."          <span class="comment">(Show function named "links")</span>
        },
        "<span class="highlight-code">updates</span>": {
            "<span class="highlight-code">watch</span>": "function (doc, req) {\\n..."          <span class="comment">(Update function named "watch")</span>
        },
        "<span class="highlight-code">views</span>": {
            "<span class="highlight-code">menu_items</span>": {              <span class="comment">(View named "menu_items")</span>
                "map": "function (doc) {\\n..."
            },
            "<span class="highlight-code">a2b</span>": {                     <span class="comment">(View named "a2b")</span>
                "map": "function (doc) {\\n..."
            },
            "<span class="highlight-code">authors_to_books</span>": {        <span class="comment">(View named "author_to_books")</span>
                "map": "function (doc) {\\n..."
            }
        },
        "language": "javascript"
    } 
    </pre>
        </div>
    END
    links: 
    [
        [
            "Design Documents",
            "http://docs.couchdb.org/en/stable/ddocs/index.html"
        ],
        [
            "API Reference: Design Documents",
            "http://docs.couchdb.org/en/stable/api/ddoc/common.html"
        ]
    ]
}

