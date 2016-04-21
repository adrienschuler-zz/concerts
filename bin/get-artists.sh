#!/bin/bash

curl -s -XGET "http://localhost:9200/_search?pretty" -d'
{
  "size": 200,
  "fields": [
    "artist"
  ],
  "query": {
    "match_all": {}
  }
}' | grep -Eio '\[(.*)\]' | sed -E 's/\[ "(.*)" \]/\1/' | sort | uniq -u > artists


while read ARTIST; do
    ARTIST=`echo $ARTIST | sed -E 's/ /%20/g'`
    echo $ARTIST
    curl -s -XGET "http://api.deezer.com/search?q=artist:\"$ARTIST\"&limit=1" | python -mjson.tool
    curl -s -XGET "https://api.spotify.com/v1/search?q=$ARTIST&type=artist&limit=1" | python -mjson.tool
    sleep 1
done < artists
