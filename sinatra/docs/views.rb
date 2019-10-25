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
            We can use them as secondary indexes to look up data quickly by different fields.
        </p>

        <p>
            Views are stored as B-trees, so they can act as secondary indexes.
        </p>

        <p>
            They also let us transform our data and still let us access the results in logarithmic time.
        </p>

        <p>
            Map functions in views can call emit(key, value) any number of times for a given document.
        </p>

        <p>
            Map functions are only allowed to address data in the current document they're processing.
        </p>

        <p>
            That lets it track which rows came from each document, so when documents are updated, it can update views incrementally.
        </p>

        <p>
            We'll use a simple view to generate the navigation menu. This view only needs a map function:
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
            "Design Documents TODO",
            "http://docs.couchdb.org/en/stable/ddocs/index.html"
        ],
        [
            "API Reference TODO",
            "http://docs.couchdb.org/en/stable/api/ddoc/common.html"
        ]
    ]
}


