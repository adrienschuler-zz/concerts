#!/bin/bash

source conf/conf.sh
source lib/utils.sh

function proceed {
    DOMAIN=$1
    FILE=$CACHE_DIR/$DOMAIN

    if [ ! -f $FILE ];
    then
        echo "$DOMAIN cache missing."
        update_cache
    fi

    echo -e "\n$DOMAIN"
    echo `$DOMAIN $FILE` | strip_html_tags | strip_empty_newlines | sed -E 's/--/\n/g'
}

check_cache

for url in ${URLS[@]}; do
    proceed `url_to_domain $url`
done
