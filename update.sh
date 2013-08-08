#!/bin/bash

for file in $(find . -name '*.html'); do
    if test $(grep -E '</header>&<footer>' $file); then
        sed '1,/<\/header>/d;/<footer>/,$d' $file
        cat head.template $file foot.template > buffer.html
    fi
done
