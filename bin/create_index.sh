#!/bin/bash

HOST='http://localhost:9200'

INDEX='concerts'
TYPE='concert'

curl -XDELETE "$HOST/$INDEX"
curl -XPUT "$HOST/$INDEX" -d '
index:
    dynamic: strict
    number_of_shards: 1
    number_of_replicas: 0
properties:
    venue:
        type: string
    artist:
        type: string
    date:
        type: date
        format: strict_date_hour_minute
'


INDEX='artists'
TYPE='artist'

curl -XDELETE "$HOST/$INDEX"
curl -XPUT "$HOST/$INDEX" -d '
index:
    dynamic: strict
    number_of_shards: 1
    number_of_replicas: 0
properties:
    artist:
        type: string
    deezer_id:
        type: integer
    spotify_id:
        type: integer
    discogs_id:
        type: integer
'
