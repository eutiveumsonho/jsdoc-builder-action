#!/bin/sh -l

# This script will add a new line of HTML to the index.html file
# The new line of HTML will be added after the line that contains the comment <!-- @jsdoc-builder-action new-version -->

update_html_version () {
    awk -v line="$2" '
        /<!-- @jsdoc-builder-action new-version -->/ {
            print
            print "      "line""
            next
        }
        {print}
    ' "$1" > tmp_index.html && mv tmp_index.html "$1"
}

export update_html_version