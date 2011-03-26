GDoclet
=======

Simple content management, using Google Docs as the content source. Store your content in a Google Docs document (text file) using Textile. Add a tag to your web site to publish the document as HTML.

Usage
-------
	GDoclet::Content.for(id: "document:12345")

will fetch the published Google document with that resource id and return the content as HTML.

Currently only works with Google Docs for Domains, (i.e. Google business accounts).
