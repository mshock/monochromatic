#!/bin/sed -f

# remove header
1,/<div id='wrapper'>/d

# no more indentation
s/^\s*//

# reformat titles
/<h[1-6][^>]*>/{
    $!N
    s/<h1[^>]*>\s*\(.*\)\(<\/h1>\)\?/# \1/
    s/<h2[^>]*>\s*\(.*\)\(<\/h2>\)\?/## \1/
    s/<h3[^>]*>\s*\(.*\)\(<\/h3>\)\?/### \1/
    s/<h4[^>]*>\s*\(.*\)\(<\/h4>\)\?/#### \1/
    s/<h5[^>]*>\s*\(.*\)\(<\/h5>\)\?/##### \1/
    s/<h6[^>]*>\s*\(.*\)\(<\/h6>\)\?/###### \1/
}

# remove closing title tags
/^\s*<\/h[1-6]>\s*$/d
s/<\/h[1-6]>//

# replace all links/strong/emphasis
s/<a href=["']\(.*\)["']>\(.*\)<\/a>/[\2](\1)/
s/<\/\?strong>/**/g
s/<\/\?em>/_/g

# lists
/<ul[^>]*>/,/<\/ul>/{
    /^\s*<\/\?ul>$/d
    s/<li>\(.*\)<\/li>/* \1/
}

# images
/<a class='a_img'/{
    $!N
    /<img/{
        $!N
        s/<a class='[a-z_]*' href='\(.*\)'> *\n*\
             *<img class='[a-z_]*' src='\(.*\)' alt='\(.*\)'\/> *\n *<\/a>/[![\3](\2)](\1)/
    }
}

# pre formatted text
/<pre>/,/<\/pre>/{
    s/<\/\?code>//g
    s/<\/\?pre>//g
    s/^/    /
}

/<code>/{
    $!N
    s/<\/\?code>/`/g
}

# new lines
s/<br[\/ ]*>/  /

# paragraphs
/<p[^>]*>/,/<\/p>/s/<\/\?p>//g

# quotes
/<blockquote[^>]*>/,/<\/blockquote>/s/^\s*/> /
s/<\/\?blockquote>//g
/^> $/d

# remove simple tag, and span tags
#s/<\/\?[A-Za-z0-9]*>//g
s/<\/\?span[^>]*>//g
s/<\/\?section[^>]*>//g
s/<\/\?article[^>]*>//g

# remove footer
/<\/div>/,$d
