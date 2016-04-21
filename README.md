# concerts

Crawl seedlist and update local html cache:
```shell
./crawler.sh
```

Create local ES indices:
```shell
./bin/create-index.sh
```

Parse and index events:
```shell
python parser.py | python indexer.py
```

Match indexed events with Deezer/Spotify API:
```shell
./get-artists.sh
```
