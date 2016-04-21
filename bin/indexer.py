#!/usr/bin/env python

import fileinput
import hashlib

from elasticsearch import Elasticsearch


es = Elasticsearch()

for doc in fileinput.input():
    doc = doc.strip(' \t\n\r')
    key = hashlib.md5(doc).hexdigest()
    print key, doc
    try:
        response = es.index(index='concerts', doc_type='concert', body=doc, id=key)
        print response
    except Exception as e:
        print e
