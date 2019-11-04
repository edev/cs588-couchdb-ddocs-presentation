{
    _id: "intro",
    slide: true,
    order: 1,
    title: "Introduction",
    content: <<~END,
        <p>
            <em>Presenter: Dylan Laufenberg, Portland State University, Fall 2019</em>
        </p>

        <p>
            CouchDB at a glance:
        </p>

        <ul>
            <li>Storage model: Document store</li>
            <li>Interaction: HTTP/JSON API</li>
            <li>CAP Theorem: AP</li>
            <li>Consistency: Multi-Version Concurrency Control (MVCC)</li>
            <li>Transactions: Document-level ACID semantics</li>
            <li>Clustering: peer-to-peer</li>
            <li>Key feature: offline use</li>
        </ul>
    END
    links: 
    [
        [
            "CouchDB",
            "http://couchdb.apache.org"
        ],
        [
            "CouchDB documentation",
            "http://docs.couchdb.org/"
        ]
    ]
}

