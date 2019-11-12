{
    _id: "views-map-only",
    slide: true,
    order: 8,
    title: "Views: map-only",
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

        <div class="column">
            <h2>
                Example: a simple map-only view
            </h2>

            <p>
                Let's start with a simple example that uses a map function but doesn't need a reduce function.
            </p>

            <p>
                As we have seen, this slide deck is stored in a CouchDB database, and each slide has a menu order property.
            </p>

            <p>
                The navigation menu on the left is actually generated using a simple, map-only view.
            </p>

            <p>
                When a map function emits a key-value pair, the view's B-tree stores it sorted by key.
            </p>

            <p>
                So if we use menu order as the key, the resulting view is automatically sorted in menu order:
            </p>

        <pre>
        GET presentation/_design/loose_change/_view/<span class="highlight-code">menu_items</span>
        </pre>
            
            <div class="subcolumn">
                <h3>
                    Map function
                </h3>

        <pre>
        function (doc) {
            if (doc.slide && doc.slide === true) {
                if (doc.title && doc.order) {
                    <span class="highlight-code">emit(doc.order, [doc.title, doc._id]);</span>
                }
            }
        }
        </pre>

            </div>

            <div class="subcolumn">
                <h3>
                    Resulting view
                </h3>

        <pre>
        {
            "total_rows": 10,
            "offset": 0,
            "rows": [
                {
                    "id": "what-is-couchdb",
                    "key": 1,
                    "value": [
                        "What is CouchDB?",
                        "what-is-couchdb"
                    ]
                },
                {
                    "id": "what-is-a-document",
                    "key": 2,
                    "value": [
                        "What is a document?",
                        "what-is-a-document"
                    ]
                },
                {
                    "id": "http-api",
                    "key": 3,
                    "value": [
                        "HTTP API",
                        "http-api"
                    ]
                },
                ...
            ]
        }
        </pre>

            </div>
        </div>

        <div class="column">
            <h3>
                Map function details
            </h3>
            
            <p>
                A view's map function processes one document at a time.
            </p>
            
            <p>
                It can call emit(key, value) zero or more times to add rows to the eventual result.
            </p>

            <p>
                A map function is only allowed to address data in the document it's currently processing.
            </p>
            
            <p>
                This restriction guarantees that each emitted row only depends on the contents of one document.
            </p>
            
            <p>
                This allows CouchDB to update views incrementally when documents change.
            </p>
        </div>

        <!--
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
        GET /presentation/_design/loose_change/_view/menu_items

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
        -->
    END
    links: 
    [
        [
            "Design Documents: View Functions",
            "http://docs.couchdb.org/en/stable/ddocs/ddocs.html#view-functions"
        ],
        [
            "API Reference: Views",
            "http://docs.couchdb.org/en/stable/api/ddoc/views.html"
        ]
    ]
}

# Basic structure of the presentation:
# 
#     Introduction
#     
#     Design docs
# 
#     Show functions
# 
#     Update functions
# 
#     Filter functions
# 
#     Validate update functions
# 
#     Views: map-only
# 
#     Lists
# 
#     Views: many-to-many (still no reduce)
#     
#         Author documents:
#             
#             {
#                 "_id": "hemingway",
#                 "name": Ernest Hemingway"
#             }
# 
#         Book documents:
# 
#             {
#                 "_id": "war-and-peace",
#                 "title": "War and Peace",
#                 "authors": [
#                     "hemingway",
#                     "shakespeare"
#                 ]
#             }
# 
#         View to look up books by author:
# 
#             books: emit (book author id, book id)
# 
#         View to look up authors by book:
# 
#             books: emit (book id, author id)
# 
#     Views: group level
# 
#         Donations:
# 
#             {
#                 (auto-generated ID),
#                 "donor": "asdf",
#                 "amount": 452.30,
#                 "date": [2019, 10, 31, 23, 45, 18]
#             }
# 
#         View to sort donations by date:
# 
#             emit(doc.date, doc.amount)
#             
#             reduce: _sum
# 
#         Get sum of donations overall: GET view.
#         Get sum of donations for date range: range query.
#         Get sum of donations for day: range query.
#         Get sum of donations for month: range query.
#         Get sum of donations for every month: group_level=2
# 
