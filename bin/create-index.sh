#!/bin/bash

HOST='localhost:9200'

INDEX='events'
TYPE='event'

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
            "tokenizer": {
                "pattern_tokenizer": {
                    "type": "pattern",
                    "preserve_original": false,
                    "flags": "CASE_INSENSITIVE|UNICODE_CASE",
                    "pattern": "[\\+:&]+"
                }
            },
            "analyzer": {
                "artists_analyzer": {
                    "type": "custom",
                    "tokenizer": "pattern_tokenizer",
                    "filter": [
                        "trim"
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
                "event_suggest": {
                    "type": "completion",
                    "analyzer": "simple",
                    "search_analyzer": "simple",
                    "payloads": true
                },
                "artists": {
                    "type": "string",
                    "analyzer": "artists_analyzer"
                },
                "link": {
                    "type": "string"
                },
                "thumbnail": {
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
