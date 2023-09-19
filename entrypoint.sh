#!/bin/bash

title(){
  echo -e "\n-- $@ --\n"
}

poem(){
  title $@
  poetry $@
}

poem=$(poetry -q run which python)
echo "python = $poem"

poem check
poem show
poem env list

manage(){
  title $@
  $poem manage.py $@
}

echo -e "\n\n"

export HELPDESK_ENABLED=0
manage migrate

export HELPDESK_ENABLED=1
manage migrate helpdesk
manage collectstatic --noinput
manage runserver 0.0.0.0:8000
