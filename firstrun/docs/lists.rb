{
    _id: "lists",
    slide: true,
    order: 8,
    title: "List functions",
    content: <<~END,
        <p>
            You may recall that show functions process a single document and return a result, typically JSON.
        </p>

        <p>
            List functions process a view and return a result.
        </p>
        
        <div class="column">
            <h2>
                Example: navigation menu
            </h2>

            <p>
                To display the navigation menu, we write a list function that generates HTML from our map-only view.
            </p>

            <p>
                We loop over our view in sort order, outputting a link for each page.
            </p>

        <pre>
        GET presentation/_design/loose_change/_list/<span class="highlight-code">nav_menu</span>/<span class="highlight-code">menu_items</span>
        </pre>

            <div class="subcolumn">
                <h3>
                    List function
                </h3>

        <pre>
        function (head, req) {
            provides('html', function () {
                var body = '&lt;nav&gt;\\n&lt;ul&gt;\\n';
                while (row = getRow()) {
                    body += '&lt;li&gt;\\n&lt;a href=\"'
                         + <span class="highlight-code">row.value[1]</span>
                         + '\"&gt;'
                         + <span class="highlight-code">row.value[0]</span>
                         + '&lt;/a&gt;\\n&lt;/li&gt;\\n';
                }
                body += '&lt;/ul&gt;\\n&lt;/nav&gt;\\n';

                return body
            });
        }
        </pre>

            </div>

            <div class="subcolumn">
                <h3>
                    Resulting HTML
                </h3>

        <pre>
        &lt;nav&gt;
        &lt;ul&gt;
        &lt;li&gt;
        &lt;a href="<span class="highlight-code">intro</span>"&gt;<span class="highlight-code">Introduction</span>&lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
        &lt;a href="<span class="highlight-code">design_docs</span>"&gt;<span class="highlight-code">Design Documents</span>&lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
        &lt;a href="<span class="highlight-code">shows</span>"&gt;<span class="highlight-code">Show functions</span>&lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
        &lt;a href="<span class="highlight-code">updates</span>"&gt;<span class="highlight-code">Update functions</span>&lt;/a&gt;
        &lt;/li&gt;
        ...
        &lt;/ul&gt;
        &lt;/nav&gt;
        </pre>
            </div>
        </div>
    END
    links: 
    [
        [
            "Design Documents: View Functions",
            "http://docs.couchdb.org/en/stable/ddocs/ddocs.html#list-functions"
        ],
        [
            "API Reference: List Functions",
            "http://docs.couchdb.org/en/stable/api/ddoc/render.html#db-design-design-doc-list-list-name-view-name"
        ]
    ]
}

