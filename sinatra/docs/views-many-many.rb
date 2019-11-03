{
    _id: "views-many-many",
    slide: true,
    order: 9,
    title: "Views: many-to-many relationships",
    content: <<~END,
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
