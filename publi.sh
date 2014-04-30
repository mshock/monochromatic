#!/bin/sh

link=$(ls -l last.txt | sed 's^.*-> /')

test -z "$EDITOR" && EDITOR=vi

sed 2q last.txt > tmp.txt
sed -i "s(#)(${link/.txt/.html})" tmp.txt

echo "input a small description of the article.." >> tmp.txt

$EDITOR tmp.txt

echo >> tmp.txt

sed '' index.txt >> tmp.txt

sed 10q tmp.txt

echo -n 'Is everything okay? [N/y] '
read choice

test "$choice" = "y" && mv tmp.txt index.txt
