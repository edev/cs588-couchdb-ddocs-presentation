{
    _id: "design_docs",
    slide: true,
    order: 2,
    title: "Design Documents",
    content: <<~END,
        <p>
            Design documents are special documents that hold JavaScript functions for tasks like building indexes and validating document updates.
        </p>

        <h2>Example</h2>

        <pre>
        {
            _id: "_design/loose_change",
            shows: {
                slide: "function (doc, req) { ... }",
                links: "function (doc, req) { ... }"
            },
            lists: {
                nav_menu: "function (head, req) { ... }"
            },
            views: {
                menu_items: {
                    map: "function (doc) { ... }"
                }
            },
            language: "javascript"
        }
        </pre>

        <p>
            <strong>TODO UPDATE</strong>
        </p>
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

