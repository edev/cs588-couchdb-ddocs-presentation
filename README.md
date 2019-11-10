# CS588 CouchDB Design Documents Presentation
A container-based presentation that explains CouchDB design documents by using them. 

Created by Dylan Laufenberg for CS 588 - Cloud &amp; Cluster Data Management, Fall 2019, Portland State University.

## Docker Images

The following folders define Docker images:

* couchdb - the CouchDB instance
* firstrun - scripts for loading data into CouchDB
* sinatra - a simple Web app written in Ruby/Sinatra

## Running the project

The following are required to build the containers:

* Docker
* Docker Compose
* Ruby
* Bundler

With these installed, simply type `docker-compose build && docker-compose up -d` to build and launch the container group.

## GitHub Pages

A static HTMl version of the presentation (**not** backed by CouchDB) is available at: [https://edev.github.io/cs588-couchdb-ddocs-presentation](https://edev.github.io/cs588-couchdb-ddocs-presentation)

