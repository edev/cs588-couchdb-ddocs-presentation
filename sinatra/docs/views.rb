{
    _id: "views",
    slide: true,
    title: "Views",
    order: 4,
    content: <<~END,
        <p>
            Views in CouchDB let us transform data with map and reduce functions.
        </p>

        <p>
            Views are stored as B-trees, so we can use them to build secondary indexes on any set of document fields.
        </p>

        <p>
            They also let us transform our data and give us fast access to the results in logarithmic time.
        </p>

        <p>
            A view's map function processes one document at a time. It can call emit(key, value) zero or more times to add rows to the eventual result.
        </p>

        <p>
            A map function is only allowed to address data in the document it's currently processing. This restriction guarantees that each emitted row only depends on the contents of one document. This allows CouchDB to update views incrementally when documents change.
        </p>

        <h2>
            Example: generating a navigation menu
        </h2>

        <p>
            We'll use a simple view to generate the navigation menu. This one only needs a map function:
        </p>

        <pre>
        function (doc) {
            if (doc.slide && doc.slide === true) {
                if (doc.title && doc.order) {
                    emit(doc.order, [doc.title, doc._id])
                }
            }
        }
        </pre>

        <p>
            A good map function will sort related values near each other, since we can then write range queries against the underlying B-tree.
        </p>

        <p>
            To access the view, we send an HTTP request:
        </p>

        <pre>
        GET couchdb/presentation/_design/loose_change/_view/menu_items

        {
          "total_rows": 4,
          "offset": 0,
          "rows": [
            {
              "id": "intro",
              "key": 1,
              "value": [
                "CouchDB",
                "intro"
              ]
            },
            {
              "id": "design_docs",
              "key": 2,
              "value": [
                "Design Documents",
                "design_docs"
              ]
            },
            ...
        }
        </pre>

        <p>
            How does this become the navigation menu?
        </p>

        <p>
            For that, we'll use a list function.
        </p>
    END
    links: 
    [
        [
            "Design Documents: View Functions",
            "http://docs.couchdb.org/en/stable/ddocs/ddocs.html#view-functions"
        ],
        [
            "API Reference",
            "http://docs.couchdb.org/en/stable/api/ddoc/views.html"
        ]
    ]
}


