#!/bin/bash

[[ -z "$1" ]] && exit 1

cat head.template body.template foot.template >> $(date +%Y)/$(date +%m)/${1// /-}.html
