#!/bin/bash

CACHE_DIR='./cache'
URLS=(
  www.pointephemere.org/category/concert/
  www.linternational.fr/agenda/
  www.lamaroquinerie.fr/Agenda/
  www.flechedor.fr/Agenda/
  www.divandumonde.com/
  #www.radiometal.com/plateforme/agenda-concerts
)

# UTILS

function strip_html_tags {
  sed -E 's/<[^>]*>//g' $*
}

function strip_empty_newlines {
  sed -e '/^\s*$/d' $*
}

function url_to_domain {
  echo $* | cut -d'.' -f2
}

# CRAWLING

function pointephemere {
  AGENDA=`cat $1 | grep -A3 -Ei 'sommaire\">(.*)'`
  echo $AGENDA | strip_html_tags
}

function linternational {
  # cat $1 | grep -A3 -Ei 'ev2shr-data'  | strip_html_tags | strip_empty_newlines
  cat $1 | grep -A3 -Ei 'ev2shr-title' | strip_html_tags | strip_empty_newlines
}

function lamaroquinerie {
  cat $1 | grep -A1 -Ei 'vignetteTitre' | strip_html_tags
}

function flechedor {
  cat $1 | grep -A1 -Ei 'textProchainement' | strip_html_tags
}

function divandumonde {
  cat $1 | grep -A15 -Ei 'withdate' | strip_html_tags
}

function crawl {
  URL=$*
  DOMAIN=`url_to_domain $URL`
  echo $DOMAIN
  curl -s $URL > $CACHE_DIR/$DOMAIN
}

# CACHING

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
  if [ -d "$CACHE_DIR" ]; then
    if [ ! `ls $CACHE_DIR | wc -l` -gt 0 ]; then
      update_cache
    fi
  else
    echo "Building cache direcotry: $CACHE_DIR"
    mkdir -p $CACHE_DIR
    update_cache
  fi
}

# MAIN

function proceed {
  SITE=$1
  FILE=$CACHE_DIR/$SITE

  if [ ! -f $FILE ]; then
    echo "$SITE cache missing."
    update_cache
  fi

  echo $SITE
  echo `$SITE $CACHE_DIR/$SITE`
}

check_cache

for site in ${URLS[@]}; do
  proceed `url_to_domain $site`
done
