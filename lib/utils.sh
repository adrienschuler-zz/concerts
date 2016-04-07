#!/bin/bash

function strip_html_tags {
    LC_ALL=C sed -E 's/<[^>]*>//g' $*
}

function strip_empty_newlines {
    LC_ALL=C sed -E '/^\s*$/d' $*
}

function url_to_domain {
    echo $1 | cut -d'.' -f2
}

function crawl {
    URL=$1
    DOMAIN=`url_to_domain $URL`
    echo $DOMAIN
    curl -s -A $UA $URL > $CACHE_DIR/$DOMAIN
}

function update_cache {
    echo "Updating Cache..."
    for URL in ${URLS[@]}; do
        echo "Crawling $URL"
        crawl $URL &
    done
    wait
    echo "Cache updated."
}

function check_cache {
    if [ -d "$CACHE_DIR" ];
    then
        if [ ! `ls $CACHE_DIR | wc -l` -gt 0 ]; then
            update_cache
        fi
    else
        echo "Building cache direcotry: $CACHE_DIR"
        mkdir -p $CACHE_DIR
        update_cache
  fi
}
