{
    _id: "design_docs",
    slide: true,
    title: "Design Documents",
    order: 2,
    content: <<~END,
        <p>
            Design documents are special documents that hold JavaScript functions for tasks like building indexes and validating document updates.
        </p>

        <p>
            For instance:
        </p>

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

        <p>
            This Web app uses all 6 types of functions. Let's see how.
        </p>
    END
    links: 
    [
        [
            "Design Documents",
            "http://docs.couchdb.org/en/stable/ddocs/index.html"
        ],
        [
            "API Reference",
            "http://docs.couchdb.org/en/stable/api/ddoc/common.html"
        ]
    ]
}

