# concerts

Dumb crawler

Crawl seedlist and update local html cache:
```shell
./crawler.sh
```

Parse and index events:
```shell
python parser.py | python indexer.py
```

Match indexed events with Deezer/Spotify API:
```shell
./get-artists.sh
```
