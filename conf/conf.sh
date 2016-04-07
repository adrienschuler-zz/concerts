#!/bin/bash

CACHE_DIR='./cache'
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'
CACHE_EXPIRE='1d'

URLS=(
  www.pointephemere.org/agenda-global
  www.linternational.fr/agenda/
  www.lamaroquinerie.fr/Agenda/
  www.flechedor.fr/Agenda/
  www.divandumonde.com/
  www.letrianon.fr/programme.html
  www.le-zenith.com/pages/programmation/programmation-par-date.html
  www.bataclan.fr/agenda.php
  www.letrabendo.net/programmation/
  www.labellevilloise.com/category/evenements/?ec3_after=today
  # www.radiometal.com/plateforme/agenda-concerts
  # www.fnacspectacles.com/recherche/recherche.do
)
