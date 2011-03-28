GDoclet
=======

Simple content management, using Google Docs as the content source. Store your content in a Google Docs document (text file) using Textile. Add a tag to your web site to publish the document as HTML.

Usage
-------
	GDoclet::Content.for(id: "document:12345")

will fetch the published Google document with that resource id and return the content as HTML.

Currently GDoclet only works with Google Docs for Domains, (i.e. Google business accounts).

Google Docs
-----------

GDoclet looks up Google documents by resource id. It will always fetch the 'published' version of a document. This allows you to manage different versions of a document, and decide when you want it to be [published](http://docs.google.com/support/bin/answer.py?hl=en-GB&answer=96346&topic=28194).

Example
---------------

A simple Sinatra extension is included. Let's say your Sinatra application looked like:

	require 'sinatra'
	require 'haml'
	require "sinatra/gdoclet_helper"

	get '/' do
	  haml :index
	end
	
... then your index view could include content from Google Docs like this:

	#about= content id: "document:12345"

A Rails helper could serve a similar purpose.

Configuration
-------------

GDoclet expects two configuration files. These are expected in the 'config' directory, relative to where you start your application:


* gdoclet.yaml

* oauth.yaml

oauth.yaml is where you put your Google credentials. These can optionally be specified as environment variables instead, which is the suggested approach for Heroku deployments.

Caching
-------

Fetching content from Google Docs is expensive and should not usually be done for each web request. GDoclet will cache the HTML it generates, using either a primitive in-memory cache or memcached. Alternatively it can be disabled if caching can be handled by your web application or other mechanism (e.g. cache-control headers). One reason to use GDoclet's caching is that it provides a simple mechanism to flush the cache.

### Flushing the cache

You can manually flush cached content by:

	GDoclet::Cache.flush(token)
	
The token must match the value stored in a Google Docs document. The flush document is identified by the gdoclet.yaml setting `flush_resource_id`. This allows you to provide a semi-protected flush action via a url such as `http://example.com/flush?token=abc123`. This might be useful to force new content to be published for that really important blog post, and you really can't wait for the normal cache invalidation.
	
Note: flushing when using memcached will flush the entire cache, including any other content in use by your memcached instance. 

