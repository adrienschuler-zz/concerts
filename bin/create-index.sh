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
