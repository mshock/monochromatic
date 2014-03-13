#!/bin/bash

RSS=rss/feed.xml

echo -ne "\rGenerating RSS file ... "

cat << EOF > $RSS
<?xml version='1.0'?>
<rss version='2.0'>
<channel>
<title>Monochromatic</title>
<description>z3bra, the stripes appart</description>
<link>http://blog.z3bra.org</link>
<item>
EOF

sed -n '/section/,/section/p' index.html >> $RSS

# dat regex... Delete lines with <section>, </section>, <p>, </p>, <br />, <h2>
# to </h2> or <!--
sed -i '/<\/*section>/d;/<\/\?[pb]\+[/r ]*>/d;/<h2>/,/<\/h2>/d;/<!--/d' $RSS

# change <article> in <description>, <h1> in <title>, ^$ in <item>
sed -i 's/^\s*//' $RSS
sed -i '/^$/{N;s/\n//}' $RSS
sed -i 's/<\(\/\)\?article>/<\1description>/' $RSS
sed -i 's/<\(\/\)\?h1>/<\1title>/' $RSS
sed -i 's/^$/<\/item>\n<item>/' $RSS
sed -i 's/<a\ .*>\(.*\)<\/a>/\1/' $RSS

cat << EOF >> $RSS
</item>
</channel>
</rss>
EOF

echo -e "[\033[1;32m OK \033[0m]"
