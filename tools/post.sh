#!/bin/bash

[[ -z "$1" ]] && exit 1

POST="$(date +%Y)/$(date +%m)/${1// /-}.html"

cat tools/{head,body,foot}.template >>  $POST

echo "$POST created"


