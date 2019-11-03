{
    _id: "views-many-many",
    slide: true,
    order: 9,
    title: "Views: many-to-many relationships",
    content: <<~END,
        <p>
            Views let CouchDB databases do things that conventional wisdom says NoSQL databases can't do.
        </p>

        <div class="column">
            <h2>
                Example: many-to-many relationship
            </h2>

            <p>
                Consider the many-to-many relationship between authors and books.
            </p>

            <p>
                One book may have many authors, and one person may author many books.
            </p>

            <p>
                In order to access an author's book list, we need to store a list of books with each author.
            </p>

            <p>
                And in order to access a book's author list, we need to store a list of authors with each book.
            </p>

            <p>
                Or do we?
            </p>

            <div class="subcolumn">
                <h3>
                    Author documents
                </h3>

        <pre>
        {
            "_id": "pramod-j-sadalage",
            "name": "Pramod J. Sadalage",
            "author": true
        }
        
        {
            "_id": "martin-fowler",
            "name": "Martin Fowler",
            "author": true
        }
        </pre>

            </div>

            <div class="subcolumn">
                <h3>
                    Book documents
                </h3>

        <pre>
        {
            "_id": "0321826620",
            "title": "NoSQL Distilled",
            "book": true,
            "authors": [
                "pramod-j-sadalage",
                "martin-fowler"
            ]
        }

        {
            "_id": "0134757599",
            "title": "Refactoring: Improving...",
            "book": true,
            "authors": [
                "martin-fowler"
            ]
        }
        </pre>
        
            </div>
        </div>

        <div class="column">
        <pre>
        GET /presentation/_design/loose_change/_view/<span class="highlight-code">authors_to_books</span>
        </pre>

            <div class="subcolumn">
                <h2>
                    Map function
                </h2>

        <pre>
        function (doc) {
            if (doc.book && doc.book === true 
                && doc.authors && isArray(doc.authors)) {
                doc.authors.forEach (function (author) {
                    emit (author, doc._id);
                });
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
          "total_rows": 3,
          "offset": 0,
          "rows": [
            {
              "id": "0134757599",
              "key": "martin-fowler",
              "value": "0134757599"
            },
            {
              "id": "0321826620",
              "key": "martin-fowler",
              "value": "0321826620"
            },
            {
              "id": "0321826620",
              "key": "pramod-j-sadalage",
              "value": "0321826620"
            }
          ]
        }
        </pre>
            </div>
        </div>

        <div class="column">
        <pre>
        GET /presentation/_design/loose_change/_view/<span class="highlight-code">authors_to_books?key="martin-fowler"</span>
        </pre>

            <div class="subcolumn">
                <h3>
                    Martin Fowler's books
                </h3>
                
        <pre>
        {
          "total_rows": 3,
          "offset": 0,
          "rows": [
            {
              "id": "0134757599",
              "key": "martin-fowler",
              "value": "0134757599"
            },
            {
              "id": "0321826620",
              "key": "martin-fowler",
              "value": "0321826620"
            }
          ]
        }
        </pre>

            </div>
        </div>
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
