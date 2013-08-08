#!/bin/bash

for file in $(find . -name '*.html'); do
    if [[ -n "$(cat $file|tr -d '\n' |grep -E '</header>.*<footer')" ]]; then
        cat head.template > buffer.html
        sed '1,/<\/header>/d;/<div id=.blank.>/,$d' $file >> buffer.html
        cat foot.template >> buffer.html

        mv buffer.html $file
    fi
done
