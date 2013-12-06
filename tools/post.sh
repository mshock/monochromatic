#!/bin/bash

[[ -z "$1" ]] && exit 1

folder=$(date +%Y/%m)
file=${1// /-}.html

[[ ! -d ${folder} ]] && mkdir ${folder}

POST="${folder}/${file}"

cat tools/{head,body,foot}.template >>  $POST

[[ ! -f ${folder}/${file} ]] && echo "cannot create ${POST}" && exit 1

echo "$POST created"

ln -fs ${POST} post.html
