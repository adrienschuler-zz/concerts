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
            selectors = venue['selectors']
            page = open('cache/%s' % venue['name'], 'r')
            soup = BeautifulSoup(page, 'html.parser')
            events = get_entities(selectors['bloc'])

            for event in events:
                func = {}
                exec(venue['code'], func)
                date = func['date_format'](find(event, selectors['date']))
                artist = find(event, selectors['artist'])

                if artist:
                    doc = {
                        'name': sanitize(artist),
                        'event_suggest': sanitize(artist),
                        'artists': sanitize(artist),
                        'venue': sanitize(venue['name']),
                        'date': int(sanitize(date)),
                        'location': venue['coordinates']
                    }

                    print json.dumps(doc)
    except yaml.YAMLError as e:
        print e
