{
    _id: "_design/loose_change",
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
    "language": "javascript"
}
