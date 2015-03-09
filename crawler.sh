#!/bin/bash

CACHE_DIR='./cache'
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'
URLS=(
  www.pointephemere.org/category/concert/
  www.linternational.fr/agenda/
  www.lamaroquinerie.fr/Agenda/
  www.flechedor.fr/Agenda/
  www.divandumonde.com/
  www.letrianon.fr/programme.html
  www.le-zenith.com/pages/programmation/programmation-par-date.html
  www.bataclan.fr/agenda.php
  www.letrabendo.net/programmation/
  # www.labellevilloise.com/category/evenements/?ec3_after=today
  # www.radiometal.com/plateforme/agenda-concerts
  # http://www.fnacspectacles.com/recherche/recherche.do
)

# UTILS

function strip_html_tags {
  LC_ALL=C sed -E 's/<[^>]*>//g' $*
}

function strip_empty_newlines {
  LC_ALL=C sed -E '/^\s*$/d' $*
}

function url_to_domain {
  echo $1 | cut -d'.' -f2
}

# CRAWLING

function pointephemere {
  grep -A3 -Ei 'sommaire\">(.*)' $1
}

function linternational {
  # grep -E -A3 'ev2shr-data' $1
  grep -E -A3 'ev2shr-title' $1
}

function lamaroquinerie {
  grep -E -A1 'vignetteTitre' $1
}

function flechedor {
  grep -E -A1 'textProchainement' $1
}

function divandumonde {
  grep -E -A15 'withdate' $1
}

function letrianon {
  grep -E -A10 'pogrammation1' $1
}

function le-zenith {
  grep -E -A3 'prog_colonne_infos' $1
}

function bataclan {
  grep -E -A8 'liste' $1
}

function letrabendo {
  grep -E -A5 'concert' $1
}

function labellevilloise {
  grep -E -A5 'entry-utility' $1
}

function crawl {
  URL=$1
  DOMAIN=`url_to_domain $URL`
  echo $DOMAIN
  curl -s -A $UA $URL > $CACHE_DIR/$DOMAIN
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
  DOMAIN=$1
  FILE=$CACHE_DIR/$DOMAIN

  if [ ! -f $FILE ]; then
    echo "$DOMAIN cache missing."
    update_cache
  fi

  echo $DOMAIN
  echo `$DOMAIN $CACHE_DIR/$DOMAIN | strip_html_tags | strip_empty_newlines`
}

check_cache

for url in ${URLS[@]}; do
  proceed `url_to_domain $url`
done
