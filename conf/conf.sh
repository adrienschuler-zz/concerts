#!/bin/bash

CACHE_DIR='./cache'
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.76 Safari/537.36'
CACHE_EXPIRE='1d'

URLS=(
  # http://www.bataclan.fr/agenda.php
  # http://www.divandumonde.com/
  # http://espaceb.net/-Agenda-
  # http://www.labellevilloise.com/agenda/
  # http://www.lamaroquinerie.fr/Agenda/
  # http://www.le-zenith.com/pages/programmation/programmation-par-date.html
  # http://www.letrabendo.net/programmation/
  # http://www.letrianon.fr/programme
  # http://www.linternational.fr/agenda/
  # http://www.flechedor.fr/Agenda/
  # http://www.pointephemere.org/agenda-global

  # http://www.newmorning.com/programmation
  # http://www.laboule-noire.fr/programmation/
  # http://badaboum.paris/programmation
  # http://www.lacigale.fr/en/programmation/
  # http://espaceb.net/
  # http://yoyo-paris.com/agenda/
  # http://www.glazart.com/agenda/
  # http://www.rexclub.com/
  # http://www.concreteparis.fr/Booking-en.html
  # http://www.lamachinedumoulinrouge.com/en/agenda
  # http://www.parissocialclub.com/tickets/
  # http://mecanique-ondulatoire.com/

  # http://www.radiometal.com/plateforme/agenda-concerts
  # http://www.fnacspectacles.com/recherche/recherche.do
  # http://www.songkick.com/
  # http://www.bandsintown.com/
)
