#!/usr/bin/env python

import os
import re
import json

import yaml
from bs4 import BeautifulSoup


def get_entities(entities):
    try:
        parts = entities.split('.')
        return soup.body.find_all(parts[0], attrs={parts[1] : parts[2]})
    except:
        return

def sanitize(str):
    return re.sub(r'[\n\r\t]+', '', str, flags=re.UNICODE).strip()

def find(bloc, selector):
    try:
        parts = selector.split('.')

        if len(parts) == 1:
            text = bloc.find(parts[0]).text
        elif len(parts) == 3:
            if '*' in parts[2]:
                text = bloc.find(parts[0], attrs={parts[1] : re.compile(parts[2])}).text
            else:
                text = bloc.find(parts[0], attrs={parts[1] : parts[2]}).text
        return sanitize(text)
    except Exception as e:
        # print e
        return

with open('conf/venues.yaml', 'r') as stream:
    try:
        conf = yaml.load(stream)
        for venue in conf['venues']:
            page = open('cache/%s' % venue['name'], 'r')
            soup = BeautifulSoup(page, 'html.parser')
            concerts = get_entities(venue['bloc'])

            for concert in concerts:
                func = {}
                artist = find(concert, venue['artist'])
                exec(venue['code'], func)
                date = func['date_format'](find(concert, venue['date']))

                if artist:
                    if '+' in artist:
                        artists = artist.split('+')

                        for artist in artists:
                            doc = {
                                "artist": sanitize(artist),
                                "venue": sanitize(venue['name']),
                                "date": sanitize(date)
                            }
                    else:
                        doc = {
                            "artist": sanitize(artist),
                            "venue": sanitize(venue['name']),
                            "date": sanitize(date)
                        }

                    print json.dumps(doc)

    except yaml.YAMLError as e:
        print e
