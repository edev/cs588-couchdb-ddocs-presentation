{
    _id: "views-many-many",
    slide: true,
    order: 9,
    title: "Views: many-to-many relationships",
    content: <<~END,
        <p>
            Views let CouchDB databases do things that conventional wisdom says NoSQL databases can't do.
        </p>

        <p>
            For instance, consider a many-to-many relationship where we need fast lookups in either direction.
        </p>

        <p>
            Conventional wisdom says we need to store duplicate relationship data and keep it up-to-date manually.
        </p>

        <p>
            Let's see if CouchDB can make things easier for us.
        </p>

        <div class="column">
            <h2>
                Data set: authors &amp; books
            </h2>

            <p>
                Let's use the example of authors and books.
            </p>

            <p>
                An author may write many books, and a book may have many authors.
            </p>

            <p>
                So this is clearly a many-to-many relationship.
            </p>

            <p>
                Some basic author and book documents might look something like this:
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
        }

        {
            "_id": "0134757599",
            "title": "Refactoring: Improving...",
            "book": true,
        }
        </pre>
        
            </div>

            <p>
                How might we represent the relationships between these documents?
            </p>
        </div>

        <div class="column">
            <h2>
                Option A: duplicate relationship data
            </h2>

            <p>
                One approach is to include a list of books with each author and a list of authors with each book.
            </p>

            <div class="subcolumn">
                <h3>
                    Author documents
                </h3>

        <pre>
        {
            "_id": "pramod-j-sadalage",
            "name": "Pramod J. Sadalage",
            "author": true,
        <div class="highlight-code">    "books": [
                {
                    "_id": "0321826620",
                    "title": "NoSQL Distilled",
                    "book": true,
                }
            ]</div>
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
        <div class="highlight-code">    "authors": [
                {
                    "_id": "pramod-j-sadalage",
                    "name": "Pramod J. Sadalage",
                    "author": true
                },
                {
                    "_id": "martin-fowler",
                    "name": "Martin Fowler",
                    "author": true
                }
            ]</div>
        }
        </pre>
        
            </div>

            <p>
                This does give us all the information we need in a single query.
            </p>

            <p>
                If we typically want all of an author's books and all information about every author,<br />
                then this might be the best approach.
            </p>

            <p>
                We do have to be very careful to keep both sets of documents updated &amp; consistent,<br />
                without the benefit of transactions.
            </p>

            <p>
                On the other hand, if we typically want only a small portion of that data, <br />
                then we're stuck reading a lot of extra information.
            </p>

            <p>
                When we update an author or book document, we're writing a lot of extra information, too.
            </p>
        </div>

        <div class="column">
            <h2>
                Option B: make a "junction table" document
            </h2>

            <p>
                What if we make a set of documents that act like rows in a junction table? (Hint: this is a bad idea.)
            </p>

            <div class="subcolumn">
                <h3>
                    "Junction table" documents
                </h3>

        <pre>
        {
            "_id": "b2a/0321826620/pramod-j-sadalage",
            "book": "0321826620",
            "author": "pramod-j-sadalage",
        }

        {
            "_id": "b2a/0321826620/martin-fowler",
            "book": "0321826620",
            "author": "martin-fowler",
        }
        </pre>
            </div>

            <div class="subcolumn">
                <h3>
                    Authors-to-books view
                </h3>

        <pre>
        function (doc) {
            if (doc._id.slice(0, 3) == 'b2a') {
                if (doc.book && doc.author) {
                    emit(doc.author, doc.book);
                }
            }
        }
        </pre>
            </div>

            <p class="clear">
                The way we incorpate book IDs into our junction table document IDs will cause our documents to sort by book ID,<br />
                which lets us look up a book's authors with a range query.
            </p>

            <p>
                In order to look up an author's books quickly, we need our documents to be sorted by author. To solve this problem,<br />
                we can make a map-only view that emits &lt;author, book&gt; pairs.
            </p>

            <p>
                Now we can quickly query in either direction. Unfortunately, each book's authors are sorted alphabetically,<br />
                which will definitely anger a lot of authors.
            </p>

            <p>
                We also lose a lot of the clarity and simplity inherent in NoSQL data stores; we're going against the grain.
            </p>
        </div>

        <div class="column">
            <h2>
                Option C: make a "junction table" view
            </h2>
        </div>



            

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
