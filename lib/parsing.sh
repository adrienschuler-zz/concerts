#!/bin/bash

source lib/utils.sh

function pointephemere {
    grep -E -A3 'sommaire' $1
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
    grep -E -A1 'entry-title' $1
}
