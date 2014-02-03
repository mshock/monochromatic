#!/bin/bash



# Ask the user for a title
read -p "post title" title

# use post title to name the file
file=`echo ${title}| sed "s/\s\+/-/g;s/./\l&/g;s/[,.!;\"']/g"`

#date format for the post
date=`date +%d %B, %Y`

# The format of the path to the post, here: /yyyy/mm/
folder=`date +%Y/%m`

# create the path if it does not exists
test -d ${folder} || mkdir -p ${folder}

# build the whole path
post="${folder}/${file}"

# use the templates to create the post skeleton
cat tools/{head,body,foot}.template >> ${post}

# put the title and date in the post
sed "s/BLOG_TITLE/${title};s/BLOG_DATE/${date}"

test -f ${folder}/${file} || echo "cannot create ${post}" && exit 1

echo "$post created"

# create a symlink to the last post, to easily access it
ln -fs ${post} last_post.html
