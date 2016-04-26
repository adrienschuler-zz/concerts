#!/bin/bash

HOST='localhost:9200'

INDEX='concerts'
TYPE='concert'

curl -s -XDELETE "$HOST/$INDEX"
curl -s -XPUT "$HOST/$INDEX" -d '
{
    "settings": {
        "index": {
            "dynamic": "strict",
            "number_of_shards": 1,
            "number_of_replicas": 0
        },
        "analysis": {
            "filter": {
                "artists_filter": {
                    "type": "pattern_capture",
                    "preserve_original": false,
                    "flags": "CASE_INSENSITIVE",
                    "patterns": [
                        "([a-z \\-]+[ \\+]?)"
                    ]
                },
                "artists_stopwords": {
                    "type": "stop",
                    "stopwords": ["+", "&"]
                }
            },
            "analyzer": {
                "artists_analyzer": {
                    "type": "custom",
                    "tokenizer": "pattern",
                    "filter": [
                        "artists_filter"
                    ]
                }
            }
        }
    },
    "mappings": {
        '"$TYPE"': {
            "properties": {
                "venue": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "artists": {
                    "type": "string",
                    "analyzer": "artists_analyzer"
                },
                "link": {
                    "type": "string"
                },
                "date": {
                    "type": "date",
                    "format": "yyyyMMddHHmm"
                },
                "location": {
                    "type": "geo_point"
                }
            }
        }
    }
}'

INDEX='venues'
TYPE='venue'

curl -s -XDELETE "$HOST/$INDEX"
curl -s -XPUT "$HOST/$INDEX" -d '
{
    "settings": {
        "index": {
            "dynamic": "strict",
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        '"$TYPE"': {
            "properties": {
                "name": {
                    "type": "string"
                },
                "artist": {
                    "type": "string"
                },
                "date": {
                    "type": "date",
                    "format": "strict_date_hour_minute"
                }
            }
        }
    }
}'

INDEX='artists'
TYPE='artist'

curl -s -XDELETE "$HOST/$INDEX"
curl -s -XPUT "$HOST/$INDEX" -d '
{
    "settings": {
        "index": {
            "dynamic": "strict",
            "number_of_shards": 1,
            "number_of_replicas": 0
        }
    },
    "mappings": {
        '"$TYPE"': {
            "properties": {
                "name": {
                    "type": "string"
                }
            }
        }
    }
}'
