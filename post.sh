#!/bin/bash

# Ask the user for a title
read -p "Post title: " title

# use post title to name the file
file=`echo ${title}| sed "s/\s\+/-/g;s/./\l&/g;s/[,.!;\"']//g"`.txt

test -z "$file" && exit 1

#date format for the post
date=`date +"%d %B, %Y"`

# The format of the path to the post, here: /yyyy/mm/
folder=`date +%Y/%m`

# create the path if it does not exists
test -d ${folder} || mkdir -p ${folder}

# build the whole path
post="${folder}/${file}"

# create the file
cat <<EOF > ${post}
### [${title}](#)
## &mdash; ${date}

<!-- vim: set ft=markdown ts=4 et: -->
EOF

if ! test -f ${post}; then
    echo "cannot create ${post}"
    exit 1
fi

echo "$post created"

# create a symlink to the last post, to easily access it
ln -fs ${post} last.txt
