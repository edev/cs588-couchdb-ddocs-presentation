{
    _id: "_design/loose_change",
    shows: {
        slide: <<~END,
            function (doc, req) {
                var slide = {
                    "title": null,
                    "content": null,
                    "links": null
                };
                title = content = links = null;
                if (doc.title) {
                    slide.title = doc.title;
                }
                if (doc.content) {
                    slide.content = doc.content;
                }
                if (doc.links) {
                    slide.links = doc.links;
                }
                return {
                    "json": slide
                };
            }
        END
        links: <<~END
            function (doc, req) {
                var response = "";
                if (doc.links) {
                    response += '<div id="links">\\n<h2>\\nLinks\\n</h2>\\n<ul>\\n';
                    doc.links.forEach(function(elem) {
                        /* Loop through [title, uri] pairs, generating HTML links. */
                        response += '<li>\\n<a href="' + elem[1] + '">' + elem[0] + '</a>\\n</li>\\n';
                    });
                    response += '</ul>\\n</div>\\n';
                }
                return response;
            }
        END
    },
    lists: {
        nav_menu: <<~END
            function (head, req) {
                start({
                    'headers': { 'Content-Type': 'text/html' }
                });
                send('<nav>\\n<ul>\\n');
                while (row = getRow()) {
                    send('<li>\\n<a href=\"' + row.value[1] + '\">' + row.value[0] + '</a>\\n</li>\\n');
                }
                send('</ul>\\n</nav>\\n');
            }
        END
    },
    views: {
        menu_items: {
            map: <<~END
                function (doc) {
                    if (doc.slide && doc.slide === true) {
                        if (doc.title && doc.order) {
                            emit(doc.order, [doc.title, doc._id])
                        }
                    }
                }
            END
        }
    },
    language: "javascript"
}
