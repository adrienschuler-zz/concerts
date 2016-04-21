# concerts

Crawl seedlist and update local html cache:
```shell
./bin/crawler.sh
```

Create local ES indices:
```shell
./bin/create-index.sh
```

Parse and index events:
```shell
./bin/parser.py | ./bin/indexer.py
```

Match indexed events with Deezer/Spotify API:
```shell
./bin/get-artists.sh
```
