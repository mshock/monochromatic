#!/bin/sh

test -z "$1" && echo "usage: `basename $0` <input file>" && exit 1

cat << EOF
<?xml version='1.0'?>
<rss version='2.0'>
<channel>
<title>Monochromatic</title>
<description>z3bra, the stripes appart</description>
<link>http://blog.z3bra.org</link>
EOF

sed -e 's/^## .*$/<description>/' \
    -e 's/^$/<\/description>\n<\/item>/' \
    -e 's/^# \[\(.*\)\](\(.*\))/<item>\n<title>\1<\/title>\n<guid>\2<\/guid>/' $1

cat << EOF
</channel>
</rss>
EOF
